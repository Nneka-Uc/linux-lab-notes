# Weekly Learning Summary 
# **Week Number:** Week 2  

# **Week Topics**

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

###### Typical Kernel version 

**4.15.0.72-generic**

 4 : Kernel Version(Major Version) it defines significant change or update in kernel
 
15 : Minor Version.These are small update, small features and performance upates.

 0 : Patch Version.These are bugs fixes and security updates

 72-generic: It is the Distribution spefic identifiers. It show the distro in charge of the kernel. A linux distro is a complete operating system built around the linux kernel. To differentiate between the two: A linux distro is like a car that is runned by an engine which is the kernel.  

## Memory management in Linux 
Memory in linux is divided into two areas,
- **Kernel Space**
- **User Space**

### Kernel Space: It is the portion of memory in which the kernel executes and provides its services. A process running in the kernel space has unrestricted access to the hardware. It means by design kernel space has full system privileges and can access every memory unlike the userspace. It is reserved for running the kernel codes kernel extensions and device drivers. The Kernel space and user space are seperated to ensure security and stability. The kernel ensures you have the right permission to access the hardware and also prevent crashing of the total system incase the user space crashes.

### User Space: It is reserved for running processes outside the kernel. It is restricted to access the CPU and memory. Most Unix like Operating System, including linux come prepared with all kind of utilies, programming languages and graphical tools called User space application(User Land). Examples are User Space application programs written in C, Javascript, Java, Python etc. Note that User Space can only access its own memory. One would ask if this two spaces are seperated then how do they communicate together. Well User programs functions by manipulating data that are stored in the memory or disk. User Programs get access to this data by sending request to the Kernel  using SYSTEM CALLS. However we should note that not all user space programs makes system calls to the kernel.

## Examples of Programs that runs on userspace, kernel space and the one that require system calls
| User Space Process | Kernel Space Process | System Calls Process |
|--------------------|----------------------|----------------------|
|Web browser, text editor, game, calculator | OS kernel thread, device drivers, scheduler | read(), write(), open(), fork() | 
