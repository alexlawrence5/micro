ASM = nasm
EM = qemu-system-x86_64

all:
	$(ASM) -f bin boot.s -o boot.bin
	$(ASM) -f bin userland.s -o usr.bin
	cat boot.bin usr.bin > vdmicro.img

emulate:
	$(EM) -fda vdmicro.img

ngemulate:
	$(EM) -fda vdmicro.img -nographic

boot:
	$(ASM) -f bin boot.s -o boot.bin

userland:
	$(ASM) -f bin userland.s -o usr.bin

prop:
	rm -rf *.o *.bin *.elf
