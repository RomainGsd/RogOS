;External kernel_main because we call the main from kernel.c
.extern kernel_main

;Start is global so the linker knows where to find it
.global start

;Infos about the kernel for GRUB, we use a standard header called 'Multiboot'
.set MB_MAGIC, 0x1BADB002   ;'Magic' constant used by GRUB to detect kernel's location
.set MB_FLAGS, (1 << 0) | (1 << 1) ; instructions for GRUB: 1) load modules on page boundaries 2) provide memory map
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS)) ; checksum of previous values

;Our 'multiboot' header
.section .multiboot
    .align 4 ;make sure data is aligned on 4 bytes (or a multiple)
    .long MB_MAGIC
    .long MB_FLAGS
    .long MB_CHECKSUM

;Data initiliazed to 0 when kernel is loaded
.section .bss
    ;We create a stack of 4096 bytes for our C code
    .align 16
    stack_bottom:
        .skip 4096
    stack_top:

;The code run when the kernel is loaded
.section .text
    start: ;First code run in the kernel
        mov %stack_top, %esp ;Setup stack for our C code, then C environment is ready
        call kernel_main ;Calling our kernel main function

    hang: ;If the kernel main returns anything
        cli ;Disable CPU interrupts
        hlt ;Halt the CPU
        jmp hang ;Try again