SHELL := /bin/bash

ASM    := nasm
AFLAGS := -f bin

SRC := boot/boot.asm
BIN := boot/boot.bin

all: $(BIN)

$(BIN): $(SRC)
	$(ASM) $(AFLAGS) $^ -o $@

run: $(BIN)
	qemu-system-x86_64 $^

clean:
	rm $(BIN)

.PHONY:
	all clean run
