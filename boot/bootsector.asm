;
; A simple boot sector program that prints some strings and loops infinitely.
; A boot sector is identified by the BIOS as the region containing 
; 512 bytes with the last two bytes set to the two magic numbers 
; 0xAA and 0x55 which tells the BIOS this is a boot sector program, 
; and not some random data, the rest of the 510 bytes we set it to zero.
; For printing we use CPU interrupts and specifically 0x10 which causes 
; screen related interrupt service routines (ISR) to be invoked.
;

; tells the assembler to load the program at this address.
[org 0x7c00]

; make segmentation agree with assembler about data addresses,
; if we don't set the ds to zero, BIOS will print garbage values.
mov ax, 0
mov ds, ax

; we use bx as a parameter to function calls.
mov bx, HELLO_MSG
call print_string

mov bx, GOODBY_MSG
call print_string

; hang here, $ is the position at the beginning of the line 
; containing the expression, this will loop infinitely.
jmp $

%include "printstr.asm"

; data declarations 
HELLO_MSG:
    DB "Hello World!", 0 ; a null-terminated string
GOODBY_MSG:
    DB "Goodby!", 0

; padding out to zero till the 510th byte.
; $$ evaluates to the beginning of the current section,
; ($-$$) is how far into the section we are.
times 510-($-$$) DB 0
; x86 architecture handles multi-byte values in little-endian format,
; meaning less significant bytes proceed more significant bytes.
; If we were to directly write the boot sector program in binary format,
; we'd have to set the last word to 0x55aa.
DW 0xaa55
