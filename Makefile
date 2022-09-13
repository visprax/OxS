SHELL := /bin/bash

ASM    := nasm
AFLAGS := -f bin

SRC := bootsector/bootsector.asm
BIN := bootsector/bootsector.bin

all: $(BIN)

$(BIN): $(SRC)
	$(ASM) $(AFLAGS) $^ -o $@

run: $(BIN)
	qemu-system-x86_64 $^

clean:
	rm $(BIN)

.PHONY:
	all clean run
