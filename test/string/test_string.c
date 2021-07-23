#ifdef TEST

#include "unity.h"

#include <string/string.h>

void setUp(void) {
}

void tearDown(void) {
}

void test_string_notEmpty(void) {
  char* message = "This is a message";
  TEST_ASSERT_EQUAL_INT(strlen(message), 17);
}

void test_string_empty(void) {
  char* message = "";
  TEST_ASSERT_EQUAL_INT(strlen(message), 0);
}

#endif // TEST
