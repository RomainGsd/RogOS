;
; RogOS
; File: print_hex.asm
;

print_hex:
    pusha
    mov cx, 0

hex_loop:
    cmp cx, 4
    je end
    
    mov ax, dx
    and ax, 0x000f
    add al, 0x30
    cmp al, 0x39 ; if > 9, add extra 8 to represent 'A' to 'F'
    jle step2
    add al, 7 ; 'A' is ASCII 65 instead of 58, so 65-58=7

step2:
    mov bx, HEX_OUT + 5
    sub bx, cx
    mov [bx], al
    ror dx, 4

    add cx, 1
    jmp hex_loop

end:
    mov bx, HEX_OUT
    call print_string

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for our new string