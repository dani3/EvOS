#ifdef TEST

#  include "unity.h"

#  include "string.h"

void setUp(void) {
}

void tearDown(void) {
}

void test_string_emptyString(void) {
  char* message = "";
  TEST_ASSERT_EQUAL_INT(strlen(message), 0);
}

void test_string_oneElement(void) {
  char* message = "a";
  TEST_ASSERT_EQUAL_INT(strlen(message), 1);
}

void test_string_largeString(void) {
  char* message =
      "This is a relative large message. The strlen function should be able to handle this quickly";
  TEST_ASSERT_EQUAL_INT(strlen(message), 91);
}

#endif // TEST
