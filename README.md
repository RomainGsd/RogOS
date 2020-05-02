# RogOS
Learning project about creating a kernel/os

## Instructions
### Requirements
You must install Nasm assembler and Qemu emulator. \
Then you must recompile your own GCC cross-compiler: as explained here : \
https://wiki.osdev.org/GCC_Cross-Compiler
### Usage
#### Kernel
Go to 'kernel' directory and run : \
```
make
make run
```
#### Bootloader
```
nasm -f bin bootloader.asm -o bootloader.bin
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```
Or you can run the run.sh script. \
It calls nasm and runs the binary inside QEMU.

## Resources
The OSDev Wiki : https://wiki.osdev.org/ \
The Cfenollosa tutorial : https://github.com/cfenollosa/os-tutorial