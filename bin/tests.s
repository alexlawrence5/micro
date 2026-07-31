hmain:
    mov si, hmsg
    call print
    ret

hmsg db "Hello from Hello Program!",13,10,0
