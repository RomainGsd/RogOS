;
; RogOS
; File: disk.asm
;

disk_load:
    pusha
    push dx

    mov ah, 0x02    ; int 0x13 first argument ('read')
    mov al, dh      ; al <- Number of sectors to read
    mov ch, 0x00    ; ch <- cylinder number
    mov cl, 0x02    ; cl <- Sector number :
                        ; 0x01 = boot sector, 0x02 = first 'available' sector
    ;mov dl, 0x80       ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
                        ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00    ; dh <- head number

    int 0x13        ; BIOS interrupt
    jc  disk_error

    pop dx
    cmp al, dh      ; 'read' set 'al' the nb of sectors read
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print_string
    call newline
    mov dh, ah      ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTOR_ERROR
    call print_string

disk_loop:
    jmp $

DISK_ERROR db "Disk read error", 0
SECTOR_ERROR db "Incorrect number of sectors read", 0

