# Fixing `snap install` on RHEL 9 / CentOS Stream 9

While trying to install VS Code via Snap on RHEL 9, I ran into a chain of three
separate failures. Each one had to be diagnosed and fixed in order before the
install would succeed. This is a walkthrough of the whole process, including
the commands used to isolate each problem.

## Environment

```
$ uname -a
Linux localhost.localdomain 5.14.0-749.el9.x86_64 ... GNU/Linux
```

RHEL-family kernel (`.el9`) — not Debian/Ubuntu. This matters: **snap is not
first-class on RHEL**. It ships via EPEL, and a couple of setup steps that
Ubuntu does automatically have to be done by hand.

## Problem 1 — snapd isn't running at all

```
$ sudo snap install code
error: cannot communicate with server: Post "http://localhost/v2/snaps/code":
dial unix /run/snapd.socket: connect: no such file or directory
```

The `snap` CLI is just a client. It talks to the `snapd` daemon over a Unix
domain socket at `/run/snapd.socket`. If that socket file doesn't exist,
either:

- `snapd` isn't installed, or
- `snapd` is installed but its socket unit was never started

### Diagnosis

```bash
rpm -q snapd                        # is it even installed?
sudo systemctl status snapd.socket  # is the socket unit active?
sudo systemctl status snapd         # is the daemon itself running?
ls -l /run/snapd.socket             # does the socket file exist on disk?
```

### Fix

EPEL was already enabled on this machine (`/etc/yum.repos.d/epel.repo`
present), so:

```bash
sudo dnf install -y snapd
sudo systemctl enable --now snapd.socket
```

`snapd` itself is **socket-activated** — you don't need to keep it running
constantly. `systemd` wakes it up automatically the moment something connects
to `/run/snapd.socket`, and it goes back to idle afterward. Seeing
`snapd.service` show `inactive (dead)` right after use is expected, *not*
an error, as long as `snapd.socket` shows `active (listening)`.

## Problem 2 — no `/snap` directory

```
$ sudo snap install code --classic
error: cannot install "code": classic confinement requires snaps under /snap
       or symlink from /snap to /var/lib/snapd/snap
```

VS Code's snap package uses **classic confinement** — full filesystem/system
access, no sandbox. Classic-confinement snaps expect to live at a predictable
absolute path: `/snap/<name>/current/...`. Ubuntu creates `/snap` as part of
its base install. RHEL does not.

### Fix

```bash
sudo ln -s /var/lib/snapd/snap /snap
```

This just points `/snap` at where `snapd` actually stores its data on this
distro (`/var/lib/snapd/snap`).

## Problem 3 (implicit) — first-run initialization

Because the RHEL packaging of `snapd` doesn't set up `core`/`base` snaps or
the FUSE/AppArmor bits the way Ubuntu's meta-package does, first-time use may
be slower or need extra dependencies (`fuse`, `squashfuse`). Give `snapd` a
few seconds after enabling the socket before retrying an install.

## Final working sequence

```bash
sudo dnf install -y epel-release        # only if not already present
sudo dnf install -y snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install code --classic
```

## What a socket actually is (for anyone landing here confused)

A Unix domain socket is a communication channel between two programs on the
**same machine** — conceptually similar to a network socket, but it never
touches the network stack. It appears in the filesystem as a special file
(note the `s` at the start of `srw-rw-rw-` in `ls -l`), but it has no content
you can `cat` — it's a live rendezvous point, not a data file.

That's also why it lives under `/run`: `/run` is a `tmpfs` (RAM-backed)
filesystem for *runtime* state — things that only make sense while the
service producing them is alive, and that should not and cannot survive a
reboot. Compare with `/etc`, which holds the persistent, on-disk
configuration that `/run` and `/proc` reflect at runtime.

## Debugging technique used here

Rather than guessing, each layer of the pipeline was checked independently,
narrowing the problem down step by step:

| Check | Confirms |
|---|---|
| `rpm -q snapd` | Package is installed |
| `systemctl status snapd.socket` | Socket unit is enabled and listening |
| `ls -l /run/snapd.socket` | Socket file actually exists |
| `systemctl status snapd` | Daemon itself starts/stops correctly |
| `snap install <pkg> --classic` | End-to-end install path works |

This is a general-purpose approach for any "service isn't responding"
problem on Linux: install → socket/service unit → actual daemon process →
end-to-end test.
