;
; A simple boot sector program that load some sectors from the disk 
; and loops infinitely. A boot sector is identified by the BIOS as 
; the region containing 512 bytes with the last two bytes set to the 
; two magic numbers 0xAA and 0x55 which tells the BIOS this is a boot 
; sector program, and not some random data, the rest of the 510 bytes 
; we set it to zero. For printing we use CPU interrupts and specifically 
; 0x10 which causes screen related interrupt service routines (ISR) 
; to be invoked.
;

; tells the assembler to load the program at this address.
[org 0x7c00]

; make segmentation agree with assembler about data addresses,
; if we don't set the ds to zero, BIOS will print garbage values.
mov ax, 0
mov ds, ax

; set stack safely out of the way of the boot address.
mov bp, 0x8000
mov sp, bp

; load 5 sectors to 0x0000(ES):0x9000(BX) from the boot disk.
mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

; print the first loaded word stored at 0x9000
; address which we expect to be 0xdada
mov dx, [0x9000]
call print_hex

; also print the first word from the second 
; loaded sector which we expect to be 0xface
mov dx, [0x9000 + 512]
call print_hex

; hang here, $ is the position at the beginning of the line 
; containing the expression, this will loop infinitely.
jmp $

%include "boot/printstr.asm"
%include "boot/printhex.asm"
%include "boot/diskload.asm"

; global variables
BOOT_DRIVE:
    DB 0

; padding out to zero till the 510th byte.
; $$ evaluates to the beginning of the current section,
; ($-$$) is how far into the section we are.
times 510-($-$$) DB 0
; x86 architecture handles multi-byte values in little-endian format,
; meaning less significant bytes proceed more significant bytes.
; If we were to directly write the boot sector program in binary format,
; we'd have to set the last word to 0x55aa.
DW 0xaa55

; BIOS will load only the first 512-byte sector from the disk,
; here we set another 2 sectors after the boot sector to a familiar 
; work so after reading the sectors we can actually make sure that 
; we read the sectors by printing the first word of each sector.
times 256 DW 0xdada ; first  sector after boot sector
times 256 DW 0xface ; second sector after boot sector
