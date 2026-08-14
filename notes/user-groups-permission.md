## User Account Categories
- Superuser Account : has unrestricted permission and used for admin task.
- Standard User Account: regular user and has its starting point from /home/username
- Service Account: Each service has its own account and used in running the service. it helps isolation and security purpose.

## Comparism between Windows and Linux
*Windows* has a centrally managed User with the help of Active Directory.
In *Linux* users are managed locally. each server has its own user

## Why have multiple Users 
- Allow permission prt team
- security
- Traceability

## Permission Level
-User Level Permission: permission given to a User
-Group Level Permission: Permission given to users that belong to a particular group

## Access Control files in Linux
/etc/passwd: shows avaliable users in a Linux server(username :pasword(x): UID :GID: Gecos : home directory : default shell
/etc/group: shows users group
/etc/shadow: shows users password

NB: Root user has a user Id of 0 and group Id of 0

## Commands 
we use sudo here because this are admin task and if you do not have super user permission you can not run this.
#### create or add user
```bash
sudo adduser username - more userfriendly. creates a home directory immediately. used when creating user manually
sudo useradd username - steps are gradually.used in script for automatically creating a user
example sudo adduser nneka
NB: creating a user automatically creates a personal group for the user with the same uid.
```
#### change a user password
```bash
sudo passwd username 
example: sudo passwd nneka
```
#### login as a User
```bash
su - usernaame 
su - nneka
```
#### Login as a root user
su - | sudo -i

#### Check if a root is locked 
sudo passwd -s root

#### Add group 
```bash
sudo addgroup username - more userfriendly
sudo usergroup  username - steps are step by steps. used in script for automatically creating a user
example  sudo  groupadd devops
```
### Check all groups
´´´bash
cat /etc/group
´´´
#### Delete user
```bash
sudo deluser username 
sudo userdel username 
example sudo deluser nneka
```
#### Delete group
```bash
sudo delgroup username 
sudo groupdel username 
example sudo delgroup devops
```
#### Modify User account
```bash
sudo usermod [options or flags] username 
- make a group to be a primarry user group
sudo usermod -g groupname username
- to add a user to multiple group
sudo usermod -G group1, group 2 username (this delete all other secondary groups the user has, better not to use it, i deleted my sudo acccess with this)
- to add a user to multiple groups without deleting other secondary groups
sudo usermod -aG group1, group2, group3 username  (best to use)
NB: use the man page to get other options 
```
#### check groups you are in
```bash
groups 
```
#### check groups other users are 
```bash
groups username 
```
#### Add a user and also include group
```bash
sudo useradd -G groupname username
```
#### remove a group from  user
```bash
sudo gpasswd -d username group
```

### Error encountered
#### Troubleshooting: Lost Sudo Privileges in WSL

During the lab, I encountered an issue where nneka a user i created that has sudo privilege because i used -G to add other groups and it deleted other secondary groups 

### Initial Error

While attempting to modify group membership:

```bash
sudo usermod -G finance dubem
```
sudo: I'm sorry nneka. I'm afraid I can't do that.

Because it is a WSL, i runned powershell. i was able to add the sudo command again
```bash 
wsl -d Ubuntu-26.04 -u root
```
