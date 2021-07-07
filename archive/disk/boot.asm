ORG 0
BITS 16

_start:
    jmp short start
    nop

times 33 db 0

start:
    ; Jump to our code, some BIOSs might not do this themselves.
    jmp 0x7c0:step2

step2:
    ; Clear interrupts while we change the data segment
    cli

    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00

    ; Enable interrupts
    sti

    mov ah, 0x02    ; Read sector command
    mov al, 1       ; One sector to read
    mov ch, 0       ; Cylunder low eight bits
    mov cl, 2       ; Read sector two
    mov dh, 0       ; Head number
    mov bx, buffer
    int 0x13
    ; Jump carry
    jc error

    mov si, buffer
    call print

    ; Infinite loop
    jmp $

error:
    mov si, error_message
    call print

    ; Infinite loop
    jmp $

print:
    mov bx, 0
.loop:
    ; Load the char of the "si" register and load it into the "al" register.
    ; It will increment the pointer by itself.
    lodsb
    ; If we reached the null terminator.
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char:
    ; Output a char to a screen.
    mov ah, 0x0e
    ; This is a BIOS interrupt.
    int 0x10
    ret

error_message: db 'Failed to load sector', 0

; Pad the rest with zeroes.
times 510-($ - $$) db 0
; Add the bootloader signature (little-endian).
dw 0xAA55

; Placeholder for placing our message outside the boot sector.
buffer:
