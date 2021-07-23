#ifndef IDT_H
#define IDT_H

#include <core/core.h>

struct idt_desc_t {
  uint16_t offset_l; // Offset bits 0 - 15.
  uint16_t selector; // Selector that is in our GDT.
  uint8_t zero;      // Does nothing, unused set to zero.
  uint8_t type_attr; // Descriptor type and attributes.
  uint16_t offset_h; // Offset 16 - 31.
} __attribute__((packed));

struct idtr_desc_t {
  uint16_t limit; // Size of descriptor table.
  uint32_t base;  // Base address of the start of the interrupt descriptor table.
} __attribute__((packed));

void idt_init(void);
void idt_set(int interrupt_no, void* address);

#endif
