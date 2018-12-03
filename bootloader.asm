;
; RogOS
; File: bootloader.asm
;

[org 0x7c00] ; global offset
mov ah, 0x0e

mov bx, HELLO
call print_string

jmp $ ; jmp to current addr -> inf loop

%include "asm_libs/print.asm"
%include "asm_libs/print_hex.asm"

HELLO:
	db "Hello World", 0

; Padding & Magic Number
times 510-($-$$) db 0
dw 0xaa55
