ASM = nasm
EM = qemu-system-x86_64

all:
	$(ASM) -f bin boot.s -o boot.bin
	$(ASM) -f bin userland.s -o usr.bin
	cat boot.bin usr.bin > vdmicro.img

emulate:
	$(EM) -fda vdmicro.img

prop:
	rm -rf *.o *.bin *.elf
