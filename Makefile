SHELL := /bin/bash

ASM    := nasm
AFLAGS := -f bin

all: bootsector/bootsector.bin

bootsector/bootsector.bin: bootsector/bootsector.asm
	$(ASM) $(AFLAGS) $^ -o $@

run: bootsector/bootsector.bin
	qemu-system-x86_64 $^

clean:
	rm bootsector/bootsector.bin

.PHONY:
	all clean run
