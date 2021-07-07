ORG 0
BITS 16

; https://wiki.osdev.org/FAT
; Implement a fake BPB.
_start:
    ; The first three bytes are expected from the BIOS.
    ; A short jump
    jmp short start
    ; And a nop.
    nop

; Fill the rest of the BPB (33 bytes).
times 33 db 0

start:
    ; Jump to our code, some BIOSs might not do this themselves.
    ; Replace the code segment register with 0x7c0.
    jmp 0x7c0:step2

handle_zero:
    mov ah, 0x0e
    mov al, 'A'
    int 0x10
    iret

step2:
    ; Clear interrupts while we change the data segment
    cli

    mov ax, 0x7c0
    ; Set data segment
    mov ds, ax
    ; Set extra segment
    mov es, ax

    mov ax, 0x00
    ; Set Stack segment
    mov ss, ax
    ; Set stack pointer
    mov sp, 0x7c00

    ; Enable interrupts
    sti

    ; Offset
    mov word[ss:0x00], handle_zero
    ; Segment
    mov word[ss:0x02], 0x7c0

    int 0

    ; Move the address of the label to si
    mov si, message
    call print
    jmp $

print:
    ; Page number
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

message: db 'Hello Wordl!', 0

; Pad the rest with zeroes.
times 510-($ - $$) db 0
; Add the bootloader signature (little-endian).
dw 0xAA55
