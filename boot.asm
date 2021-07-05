ORG 0
BITS 16

; Jump to our code, some BIOS might not do this themselves.
jmp 0x7c0:start

start:
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
