ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:
    jmp short start
    nop

times 33 db 0

start:
    jmp 0:step2

step2:
    ; Clear interrupts while we change the data segment
    cli

    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    ; Enable interrupts
    sti

; https://wiki.osdev.org/Protected_Mode
.load_protected:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x01
    mov cr0, eax
    jmp CODE_SEG:load32

; GDT
gdt_start:
gdt_null:
    dd 0x00
    dd 0x00

; Offset 0x8
gdt_code:       ; CS should point to this
    dw 0xffff   ; Segment limit first 0-15 bits
    dw 0        ; Base first 0-15 bits
    db 0        ; Base 16-23 bits
    db 0x9a     ; Access byte
    db 11001111b ; High 4 bit flags and the low 4 bit flags
    db 0        ; Base 24-31 bits

; Offset 0x10
gdt_data:       ; DS, SS, ES, FS, GS
    dw 0xffff   ; Segment limit first 0-15 bits
    dw 0        ; Base first 0-15 bits
    db 0        ; Base 16-23 bits
    db 0x92     ; Access byte
    db 11001111b ; High 4 bit flags and the low 4 bit flags
    db 0        ; Base 24-31 bits

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

[BITS 32]
load32:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp

    ; Enable the A20 line
    in al, 0x92     ; read from the processor bus
    or al, 2
    out 0x92, al    ; write to the processor bus

    jmp $

; Pad the rest with zeroes.
times 510-($ - $$) db 0
; Add the bootloader signature (little-endian).
dw 0xAA55
