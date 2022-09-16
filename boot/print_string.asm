print_string:
    ; preserver all general purpose register values on the stack
    pusha
    ; scrolling tele-type BIOS routine
    mov ah, 0x0e
    .loop:
        ; move the value pointed at by bx to al
        mov al, [bx]
        ; see if we have reached the end of the null-terminated string
        cmp al, 0
        ; if it's the end of the string we're done
        je .done
        ; interrupt the CPU with screen-related interrupt service routines
        int 0x10
        ; set the bx pointer to the next byte
        add bx, 1
        jmp .loop
    .done:
        ; pop back all the registers values preserved on the stack
        popa
        ret

