#!/bin/bash

nasm -f bin bootloader.asm -o bootloader.bin
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
