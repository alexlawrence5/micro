; an alternative program for neofetch
; much faster, made for micro

cpumod: times 49 db 0

printfetch:
.next:
        lodsb
        test al, al
        jz .done
        mov ah, 0x0E
        int 0x10
        jmp .next
.done:
        ret

gcpu:
        mov eax, 0x80000002
        cpuid
        mov [cpumod], eax
        mov [cpumod+4], ebx
        mov [cpumod+8], ecx
        mov [cpumod+12], edx
        mov eax, 0x80000003
        cpuid
        mov [cpumod+16], eax
        mov [cpumod+20], ebx
        mov [cpumod+24], ecx
        mov [cpumod+28], edx
        mov eax, 0x80000004
        cpuid
        mov [cpumod+32], eax
        mov [cpumod+36], ebx
        mov [cpumod+40], ecx
        mov [cpumod+44], edx
        mov byte [cpumod+48], 0 ; lil 49 byted essay
        ret

fetch:
        mov si, osfetch
        call printfetch
        mov si, usage
        call printfetch
        call memc
        mov si, kib
        call printfetch
        mov si, cpucmd
        call printfetch
        call gcpu
        mov si, cpumod
        call printfetch
        ret


osfetch db "OS: MicroOS 1.6 x86", 13, 10, 0
usage db "RAM usage: ", 0
kib db " KiB", 13, 10, 0
cpucmd db "CPU: ", 0

; my brain fried when i wrote this
