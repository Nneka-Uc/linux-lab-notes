##### Weekly Learning Summary 
#### **Week Number:** Week 2  

#### **Week Topics**

- Introduction to the Linux Kernel
- Kernel Space and the User Space
- Working with Hardware

## Linux Kernel
The Kernel is the major component of an Operating system. It is like the engine of the OS.
Kernel is the core interface between a computer hardware and its processes. Linux has a monolithic kernel but modular in implementation. 

- Linux is monolithic means that it runs everything by itself. It is in charge of Cpu Scheduling, Memory management and several other operations by itself.

- When I said that Linux has modular capabilities, I mean that its part can be dynamically loaded and managed. For instance, you add or remove parts without rebuilding the whole machine. You plug a new USB driver in a file system and its automatically loaded and when its removed, its unloaded without reloading the system.

![Linux Kernel Diagram](../images/Linuxkernel.png)

*Figure 1: How the Linux kernel communicates with CPU, memory, devices, and applications.*

## Kernel Task
There are four major task for the linux command

- **Memory Management**: Linux kernel keeps track of how much memoory is used to store what and where.
- **Process Management**: Determines which processes can use the CPU, when and for how long it will last.
- **Device Drivers**: Linux kernel also acts as a mediator or interpreter between the hardware devices and your application processes.
- **System Calls and Security**: It receives requests for Services from the applications processes, it runs it and returns results.Before the kernel also runs a task, it check permissions and access controls

## Kernel Version
Kernel Version refers to the specific version of a Linux kernel running on your system. It tells about fixtures, bugs and hardware supports.

To see your kernel version

- uname -r or uname -a

* Typical Kernel version 

**4.15.0.72-generic**

 4 : Kernel Version(Major Version) it defines significant change or update in kernel
 
15 : Minor Version.These are small update, small features and performance upates.

 0 : Patch Version.These are bugs fixes and security updates

 72-generic: It is the Distribution spefic identifiers. It show the distro in charge of the kernel. A linux distro is a complete operating system built around the linux kernel. To differentiate between the two: A linux distro is like a car that is runned by an engine which is the kernel.  


