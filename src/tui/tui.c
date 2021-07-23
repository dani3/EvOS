/**
 * @file tui.c
 * @author Daniel Mancebo (daniel.m.aldea@hotmail.com)
 *
 * @brief Implementation of the TUI module. This module handles printing messages to the screen by
 * using the "VGA mode 3", which allows direct memory access to a linear address containing each
 * character.
 *
 * For more information @see https://wiki.osdev.org/Text_UI
 */
#include <tui/tui.h>

#include <string/string.h>

// 80 character width.
#define VGA_WIDTH 80
// 25 lines.
#define VGA_HEIGHT 25

// Pointer to the physical address where the linear text buffer is located.
static uint16_t *s_vga_memory;

// Holds the current column in the screen.
static uint16_t s_column;
// Holds the current line in the screen.
static uint16_t s_row;

/**
 * @brief create a printable char given the actual character and a color.
 *
 * @param c: character.
 * @param color: color.

 * @return printable char.
 */
static uint16_t make_char(char c, tui_color_t color) {
  return (color << 8) | c;
}

/**
 * @brief puts a char into the VGA memory.
 *
 * @param x: column where the character has to be drawn to.
 * @param y: row where the character has to be drawn to.
 * @param c: character to be drawn.
 * @param color: color of the character.
 */
static void tui_put_char(uint16_t x, uint16_t y, char c, tui_color_t color) {
  s_vga_memory[(y * VGA_WIDTH) + x] = make_char(c, color);
}

/**
 * @brief initialize the TUI.
 */
void tui_init() {
  s_vga_memory = (uint16_t *) 0xB8000;
  s_row = 0;
  s_column = 0;

  // Clear the screen.
  for (uint8_t y = 0; y < VGA_HEIGHT; y++) {
    for (uint8_t x = 0; x < VGA_WIDTH; x++) {
      tui_put_char(x, y, ' ', BLACK);
    }
  }
}

/**
 * @brief prints a given message to the screen.
 *
 * @param message: message to be printed.
 * @param color: color of the message.
 */
void tui_print(char *message, tui_color_t color) {
  for (uint32_t i = 0; i < strlen((uint8_t *) message); ++i) {
    // If it's a newline, increment the row.
    if (message[i] == '\n') {
      s_row++;
      s_column = 0;

    } else {
      tui_put_char(s_column++, s_row, message[i], color);
      if (s_column >= VGA_WIDTH) {
        s_column = 0;
        s_row++;
      }
    }
  }
}
