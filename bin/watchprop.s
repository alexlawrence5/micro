watchprop:
.loop:
    mov si, mprompt
    call printc

    mov di, mbuffer
    call input

    mov si, mbuffer
    mov di, exitcmd
    call strcmp
    jc .exit

    mov si, mbuffer
    mov di, hlcp
    call strcmp
    jc .hl

    mov si, mbuffer
    mov di, rebcp
    call strcmp
    jc .reb

    mov si, munknown
    call print
    jmp .loop

.exit:
    ret

.hl:
    hlt

.reb:
    int 0x19
    ret

mprompt db "wprop> ",0
exitcmd db "closebatch",0
hlcp db "hlt",0
rebcp db "reboot",0
munknown db "Unknown command",13,10,0

mbuffer times 64 db 0
