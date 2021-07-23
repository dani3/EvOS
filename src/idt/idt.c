#include <idt/idt.h>

#include <config.h>
#include <memory/memory.h>
#include <tui/tui.h>

static struct idt_desc_t s_idt_descriptors[EVOS_TOTAL_INTERRUPTS];
static struct idtr_desc_t s_idtr_descriptor;

extern void idt_load(struct idtr_desc_t* ptr);

static void idt_zero() {
  tui_print("Divide by zero error\n", WHITE);
}

void idt_init() {
  memset(s_idt_descriptors, 0, sizeof(s_idt_descriptors));

  s_idtr_descriptor.limit = sizeof(s_idt_descriptors) - 1;
  s_idtr_descriptor.base = (uint32_t) s_idt_descriptors;

  idt_set(0, idt_zero);

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
