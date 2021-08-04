/**
 * @file io.h
 * @author Daniel Mancebo Aldea (daniel.m.aldea@hotmail.com)
 *
 * @brief An I/O port is usually used as a technical term for a specific address on the x86's IO
 * bus. This bus provides communication with devices in a fixed order and size, and was used as an
 * alternative to memory access.
 *
 * For more information, refer to @link https://wiki.osdev.org/I/O_Ports
 */
#ifndef IO_H
#define IO_H
#include <core/core.h>

/// receive a byte through the given port.
uint8_t insb(uint16_t port);
/// receive two bytes through the given port.
uint16_t insw(uint16_t port);

/// send a byte through the given port.
void outb(uint16_t port, uint8_t val);
/// send two bytes through the given port.
void outw(uint16_t port, uint16_t val);

#endif
