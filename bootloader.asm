;
; RogOS
; File: bootloader.asm
;

[org 0x7c00] ; bootloader offset

mov bp, 0x9000      ; Set the stack
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm
jmp $

%include "asm_libs/disk.asm"
%include "asm_libs/print_string.asm"
%include "asm_libs/print_hex.asm"
%include "asm_libs/32bit_print.asm"
%include "asm_libs/32bit_gdt.asm"
%include "asm_libs/32bit_switch.asm"

[bits 32]
BEGIN_PM:   ;after the switch you arrive here
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

;bootsector
times 510-($-$$) db 0
dw 0xaa55