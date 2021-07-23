#include <string/string.h>

/**
 * @brief returns the length of a given string.
 *
 * @param p_str: pointer to an array of chars.
 *
 * @return the size of the string.
 */
size_t strlen(const uint8_t *p_str) {
  size_t len = 0;
  while (*p_str) {
    len++;
    p_str++;
  }

  return len;
}
