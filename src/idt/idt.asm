section .asm

global int21h
global idt_load
global double_fault

extern int21h_handler
extern double_fault_handler

idt_load:
  push ebp
  mov ebp, esp

  mov ebx, [ebp+8]
  lidt [ebx]

  pop ebp
  ret

int21h:
  cli
  pushad
  call int21h_handler
  popad
  sti
  iret

double_fault:
  cli
  pushad
  call double_fault_handler
  popad
  sti
  iret
