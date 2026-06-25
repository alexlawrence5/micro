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

    mov si, msg
    call print

loop:
    mov si, prompt
    call print

    mov di, buffer
    call input

    mov si, buffer
    call proc
    jmp loop

input:
    xor cx, cx

.read:
    mov ah, 0
    int 0x16

    cmp al, 13
    je .done

    mov [di], al
    inc di
    inc cx

    mov ah, 0x0E
    int 0x10
    jmp .read

.done:
        mov ah, 0x0E
        mov al, 0x0D
        int 0x10
        mov al, 0x0A
        int 0x10
    mov byte [di], 0
    ret

proc:
    mov si, buffer

    mov di, help
    call strcmp
    jc .help

    mov si, buffer
    mov di, cls
    call strcmp
    jc .cls

    mov si, buffer
    mov di, reboot
    call strcmp
    jc .reboot

    mov si, buffer
    mov di, east
    call strcmp
    jc .easteregg

    mov si, buffer
    mov di, v
    call strcmp
    jc .vr

    mov si, unknown
    call print
    ret

.help:
    mov si, help_msg
    call print
    ret

.cls:
    mov ax, 0x0003
    int 0x10
    ret

.reboot:
    int 0x19
    ret

.easteregg:
        mov si, eastermg
        call print
        ret

.vr:
        mov si, ver
        call print
        ret

strcmp:
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .no

    cmp al, 0
    je .yes

    inc si
    inc di
    jmp .loop

.yes:
    stc
    ret

.no:
    clc
    ret

print:
.loop:
    lodsb
    cmp al, 0
    je .done

    mov ah, 0x0E
    int 0x10
    jmp .loop

.done:
    ret

msg db "MicroOS - Ultimate mini OS", 0x0D, 0x0A, 0
prompt db "$ ", 0
unknown db "unknown cmd", 0x0D, 0x0A, 0
help_msg db "help, cls, reboot", 0x0D, 0x0A, 0
eastermg db "Woohoo! U founded it!", 0x0D, 0x0A, 0
ver db "MicroOS 1.0 - Done with pain and love", 0x0D, 0x0A, 0

help db "help", 0
cls db "clear", 0
reboot db "reboot", 0
east db "easter egg", 0
v db "kbinfo", 0

buffer times 64 db 0

times 510-($-$$) db 0
dw 0xAA55
