;
; Print a string to the screen in 32-bit protected mode, 
; (i.e. without the use of BIOS routines).
; Most graphics card will start in simple Video Graphics Array (VGA)
; color text mode with dimensions 80x25 characters. There is no 
; need to render individual pixels, there is a simple font defined 
; in the internal memory of the VGA display device. Each character 
; is represented by two bytes, one for the ASCII code of 
; the character and the other for the character attributes.
; So to display a character on the screen, we need to set its ASCII 
; code and attributes at the correct memory address for the current 
; VGA mode, which is usually at address 0xb8000.
;
[bits 32]

; start of the memory address which the screen is usually mapped to
VIDEO_MEMORY equ 0xb8000
; property of each character which is printed, here it's white on black
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EDX
print_string_pm:
    pusha
    ; set the EDX to the start of memory address
    mov edx, VIDEO_MEMORY 

print_string_pm_loop:
    ; store the char at EBX in AL
    mov al, [ebx]
    ; store the attribute in AH
    mov ah, WHITE_ON_BLACK
    
    ; if the end of the string is reached, we're done
    cmp al, 0
    je print_string_pm_done
    
    ; store the current character cell code and attributes
    mov [edx], ax
    
    ; increment EBX to the next character in the string
    add ebx, 1
    ; increment EDX to next character cell in video memory
    add edx, 2
    
    ; print the next character until it's done
    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret


