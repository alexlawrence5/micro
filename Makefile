ASM = nasm
EM = qemu-system-x86_64

all:
  $(ASM) -f bin main.s -o output.bin

emulate:
  $(ASM) -fda boot.bin

prop:
  rm -rf *.o *.bin *.elf
