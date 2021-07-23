#include <memory/memory.h>

void* memset(void* buffer, int c, size_t length) {
  for (size_t i = length - 1; i != 0; --i) {
    ((uint8_t*) buffer)[i] = (uint8_t) c;
  }

  return buffer;
}
