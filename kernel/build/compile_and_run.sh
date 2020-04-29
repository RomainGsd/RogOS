#!/bin/sh

i386-elf-gcc -std=gnu99 -ffreestanding -g -c ../src/start.s -o start.o
i386-elf-gcc -std=gnu99 -ffreestanding -g -c ../src/kernel.c -o kernel.o
i386-elf-gcc -ffreestanding -nostdlib -g -T linker.ld start.o kernel.o -o mykernel.elf -lgcc
qemu-system-i386 -kernel mykernel.elf
rm mykernel.elf
clean
