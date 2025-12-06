# File types in Linux

In linux everything is a file no matter whether it is a external device, keyboard, or objects. In Linux there are three types of files 
 - Regular file
 - Directory
 - Special File


### Regular File
This contain the regular files we know like text, data, images. Examples are configuration files, shell scripts and codes, jpegs

### Dirctory 
A type of the file that stores other files and other directories. Example Home directory

### Special files 
This is characterised into five other files 

a. **Character File**: Usually found under /dev diectory. It allows Operating System to communicate to Input or Output devices setially (mouse or keyboard)
Example: Pressing characters or alphabets on the keyboard.

b. **Block Files**: It represent files for block devices located under /dev files. A block device represent hardware that stores and transfer data in fixed sized chunks rather than character by character. Example are Hard disk and Ram.

c. **Links**: It is a way to associate two or more filenames to same set. There are two types of link: Hard Link and Soft Link
   - Hard Link: This creates an associate file to another file on the same filesystem. It points to the nodes/data of the file. It behaves as an independent file and deleting the last link will delte the data. To create a hard link to a file 
        
        `ln originalfilename newhardlinkname`

   - Soft Link: This is also called Symbolic link. It can be compared to a short cut to a file. It points to the parent file. It points to the path of the parent. Deleting a symlink does not affect the data in the actual file but deleting the parents file affects the symbolic link. Symlink can exist on the same filesystem, different filesystem, differentphyical disk, network drive. To create a symbolic link
        
        `ln -s originalfilename newsoftlinkname`

d. **Socket File**: It is a special file that enables communicatiob between two processes, including network daemons.

e. **Named Pipes**: A special type of file that allows connecting one process as an input to another. The data flow in a pipe in unidiectional from the first process to the second. Data flow one way (first in to first out) and only work on processes on the same machine.

## How to Identify different types of files in Linux
    `file filename` or `ls -l filename`
for ls -l filename , the first character indicates the type of file.

![file system characters](../image/filetype.png)
