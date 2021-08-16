#include <idt/idt.h>

#include <config.h>
#include <io/io.h>
#include <memory/memory.h>
#include <tui/tui.h>

static struct idt_desc_t s_idt_descriptors[EVOS_TOTAL_INTERRUPTS];
static struct idtr_desc_t s_idtr_descriptor;

extern void idt_load(struct idtr_desc_t* ptr);
extern void double_fault(void);
extern void int21h(void);

void int21h_handler(void) {
  tui_print("Keyboard interrupt\n", WHITE);
  outb(0x20, 0x20);
}

void double_fault_handler(void) {
  outb(0x20, 0x20);
}

static void idt_zero() {
  tui_print("Divide by zero error\n", WHITE);
}

void idt_init() {
  memset(s_idt_descriptors, 0, sizeof(s_idt_descriptors));

  s_idtr_descriptor.limit = sizeof(s_idt_descriptors) - 1;
  s_idtr_descriptor.base = (uint32_t) s_idt_descriptors;

  for (int i = 0; i < EVOS_TOTAL_INTERRUPTS; ++i) {
    idt_set(i, double_fault);
  }

  idt_set(0, idt_zero);
  idt_set(0x21, int21h);

  // Load the interrupt descriptor table.
  idt_load(&s_idtr_descriptor);
}

void idt_set(int interrupt_no, void* address) {
  struct idt_desc_t* desc = &s_idt_descriptors[interrupt_no];

  desc->offset_l = ((uint32_t) address) & 0x0000ffff;
  desc->selector = KERNEL_CODE_SELETOR;
  desc->zero = 0x00;
  desc->type_attr = 0xEE;
  desc->offset_h = ((uint32_t) address) >> 16;
}
