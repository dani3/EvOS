#include <kernel.h>

#include <idt/idt.h>
#include <tui/tui.h>

void kernel_main() {
  tui_init();
  // Initialize the interrupt descriptor table.
  idt_init();
}
