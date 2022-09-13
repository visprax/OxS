;
; A simple boot sector program that loops infinitely.
; A boot sector is identified by the BIOS as the region containing 
; 512 bytes with the last two bytes set to the two magic numbers 
; 0xAA and 0x55 which tells the BIOS this is a boot sector program, 
; and not some random data, the rest of the 510 bytes we set it to zero.
;


; $ is the position at the beginning of the line containing the expression.
jmp $

; $$ evaluates to the beginning of the current section.
; ($-$$) is how far into the section we are.
times 510-($-$$) DB 0

; x86 architecture handles multi-byte values in little-endian format,
; meaning less significant bytes proceed more significant bytes.
; If we were to directly write the boot sector program in binary format,
; we'd have to set the last word to 0x55aa.
DW 0xaa55
