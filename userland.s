BITS 16
ORG 0x8000

mov si, ascii1
call print
mov si, ascii2
call print
mov si, ascii3
call print
mov si, ascii4
call print
mov si, empt
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

    mov si, buffer
    mov di, timer
    call strcmp
    jc .timer

    mov si, buffer
    mov di, un
    call strcmp
    jc .uname

    mov si, buffer
    mov di, ls
    call strcmp
    jc .list

    mov si, buffer
    mov di, cat
    call strcmp
    jc .show

    mov si, buffer
    mov di, hltsys
    call strcmp
    jc .halt

    mov si, buffer
    mov di, fc
    call strcmp
    jc .fq

    mov si, unknown
    call print
    ret

.help:
    mov si, help_msg
    call print
    ret

.uname:
        mov si, unameo
        call print
        ret

.cls:
    mov ax, 0x0003
    int 0x10
    ret

;  micro power controller (mpc) commands

.reboot:
    int 0x19
    ret

.halt:
        mov si, panhlt
        call print
        cli
        hlt
        sti
        ret

; end of mpc

.easteregg:
        mov si, eastermg
        call print
        ret

.fq:
        mov si, faq
        call print
        ret

.show:
                mov si, f1data
                call print
                ret

.list:
                mov si, f1
                call print
                ret

.vr:
        mov si, ver
        call print
        ret

.timer:
        mov si, tmsg
        call print
        mov ah, 0x00
        int 0x1A
        mov bx, dx

.wait:
        mov ah, 0x00
        int 0x1A
        cmp dx, bx
        je .wait
        mov si, tdone
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
help_msg db "help, cls, reboot, hltsys, count, ls, cat, faq", 0x0D, 0x0A, 0
eastermg db "Woohoo! U founded it!", 0x0D, 0x0A, 0
tmsg db "counter started.", 0x0D, 0x0A, 0
tdone db "1 tick passed (≈1 sec)", 0x0D, 0x0A, 0
ver db "MicroOS 1.4 - Done with pain and love", 0x0D, 0x0A, 0
unameo db "MicroOS 1.4 x86 (Little Worm), with MicroFS 2.0 and MicroShell 6.0.", 0x0D, 0x0A, 0
panhlt db "PANIC: User requested to halt the CPU.", 0x0D, 0x0A, 0
faq db "MicroOS is NOT an complete OS. It is just an sort of OS. And there is a fake FS layer; that is NOT an real FS. It is just simulated FS.", 0x0D, 0x0A,0
empt db "", 0x0D, 0x0A, 0

ascii1 db "       _             ", 0x0D, 0x0A, 0
ascii2 db " _____|_|___ ___ ___ ", 0x0D, 0x0A, 0
ascii3 db "|     | |  _|  _| . |", 0x0D, 0x0A, 0
ascii4 db "|_|_|_|_|___|_| |___|", 0x0D, 0x0A, 0

f1 db "hello.mtf", 0x0D,0x0A,0
f1data db "Hello from MiFS.", 0x0D,0x0A,0

help db "help", 0
cls db "clear", 0
reboot db "reboot", 0
east db "easter egg", 0
v db "kbinfo", 0
timer db "count", 0
un db "uname", 0
hltsys db "hltsys", 0
ls db "ls", 0
cat db "cat hello.mtf", 0
fc db "faq", 0

buffer times 64 db
