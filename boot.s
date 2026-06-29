BITS 16
ORG 0x7C00

start:
        cli
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov ss, ax
        mov sp, 0x7C00
        sti
        call clear
        mov si, msg
        call print
        mov si, smsg
        call print
        mov ah, 0x02
        mov al, 4
        mov ch, 0
        mov cl, 2
        mov dh, 0
        mov bx, 0x8000
        int 0x13
        jc derr
        jmp 0x0000:0x8000

derr:
        mov si, err
        call print
        mov si, err1
        call print
        hlt

print:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp print

done:
    ret

clear:
        mov ax, 0x0003
        int 0x10
        ret

msg db "MicroBoot (C) developed by Alex Lawrence.", 0x0D,0x0A,0
smsg db "Loading userland...", 0x0D,0x0A,0
err db "Unexpected behaviour: Disk error", 0x0D,0x0A,0
err1 db "PANIC! MicroOS is unable to read disk. Does the userland work correctly?", 0x0D,0x0A,0

times 510-($-$$) db 0
dw 0xAA55
