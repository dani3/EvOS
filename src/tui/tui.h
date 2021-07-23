/**
 * @file tui.h
 * @author Daniel Mancebo (daniel.m.aldea@hotmail.com)
 *
 * @brief Header file of the TUI component (Terminal User Interface). Use this component to print
 * messages to the screen.
 */
#ifndef TUI_H
#define TUI_H

#include <core/core.h>

/// @brief colors supported by the TUI.
typedef enum {
  BLACK = 0,
  BLUE,
  GREEN,
  CYAN,
  RED,
  MAGENTA,
  BROWN,
  LIGHT_GRAY,
  DARK_GRAY,
  LIGHT_BLUE,
  LIGHT_GREEN,
  LIGHT_CYAN,
  LIGHT_RED,
  LIGHT_MAGENTA,
  YELLOW,
  WHITE
} tui_color_t;

/// @brief initialize and clear the TUI.
void tui_init(void);

/// @brief prints a message to the screen.
void tui_print(char *message, tui_color_t color);

#endif
