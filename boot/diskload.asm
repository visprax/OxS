; Loads DH sectors to ES:BX from drive DL
disk_load:
    ; store dx on stack, so later we can compare how many sectors
    ; were requested to be read, even if it's alterd in the meantime
    push dx 
    
    ; BIOS read sector function, also for the actual
    ; reading the 0x13 interrupt must be raised
    mov ah, 0x02
    
    mov al, dh   ; read DH sectors
    mov ch, 0x00 ; select cylinder 0
    mov dh, 0x00 ; select head 0
    mov cl, 0x02 ; read from second sector (i.e. after the boot sector)
    
    ; BIOS read sector function interrupt
    int 0x13
    
    ; jump if the carry flag was set (i.e. any errors were occured)
    jc disk_error

    pop dx 
    ; AL is sectors that were actually read and
    ; DH is sectors that were expected to be read
    cmp dh, al
    jne disk_error
    
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; global variables
DISK_ERROR_MSG:
    DB "Disk read error!", 0
