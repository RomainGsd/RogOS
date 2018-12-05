;
; RogOS
; File: print_string.asm
;

print_string:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je done
    mov ah, 0x0e
    int 0x10
    add bx, 1
    jmp start

done:
    popa
    ret

newline:
    pusha
    mov al, 0x0a
    mov ah, 0x0e
    int 0x10
    mov al, 0x0d
    int 0x10
    popa
    ret