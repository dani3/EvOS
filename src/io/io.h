#ifndef IO_H
#define IO_H

#include <core/core.h>

uint8_t insb(uint16_t port);
uint16_t insw(uint16_t port);

void outb(uint16_t port, uint8_t val);
void outw(uint16_t port, uint16_t val);

#endif