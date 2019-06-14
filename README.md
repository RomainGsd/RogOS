# RogOS
Learning project about creating a kernel/os

In its actual state it is just a bootloader.

## Instructions
### Requirements
You must install Nasm assembler and Qemu emulator.
### Usage
```
nasm -f bin bootloader.asm -o bootloader.bin
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```
or
You may run *(you fool)* the run.sh script.
It calls nasm and run to binary inside QEMU.

## Ressources
The OSDev Wiki : https://wiki.osdev.org/
The Cfenollosa tutorial : https://github.com/cfenollosa/os-tutorial

##AAAAAAAAAAAAAAAAAAAAAAAAAH
@Benit8, please send me your C standard library