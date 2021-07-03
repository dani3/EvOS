; Indicate the offset of where this code is stored.
ORG 0x7c00
BITS 16

start:
    ; Move the address of the label to si
    mov si, message
    call print
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
    mov ah, 0eh
    ; This is a BIOS interrupt.
    int 10h
    ret

message: db 'Hello Wordl!', 0

; Pad the rest with zeroes.
times 510-($ - $$) db 0
; Add the bootloader signature (little-endian).
dw 0xAA55
