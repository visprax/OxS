SHELL := /bin/bash

ASM    := nasm
AFLAGS := -f bin

SRC := boot/bootsector.asm
BIN := boot/bootsector.bin

all: $(BIN)

$(BIN): $(SRC)
	$(ASM) $(AFLAGS) $^ -o $@

run: $(BIN)
	qemu-system-x86_64 $^

clean:
	rm $(BIN)

.PHONY:
	all clean run
