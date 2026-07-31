amain:
    mov si, amsg
    call print
    ret

amsg db "MicroOS 1.6 (x86 build). Licensed under KIOS-license.",13,10,0
