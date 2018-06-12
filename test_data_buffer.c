#include <stdio.h>
#include <string.h>

#include "data_buffer.h"

int main()
{
    const char *string;
    int size;

    string = "a";
    size = utf8_charsize(string[0]);
    if (size != 1) {
	printf("Error: wrong charsize for 'a': %d\n", size);
	return 1;
    }

    string = "ä";
    size = utf8_charsize(string[0]);
    if (size != 2) {
	printf("Error: wrong charsize for 'ä': %d\n", size);
	return 1;
    }

    string = "abc";
    int len = utf8_strlen(string);
    if (len != 3) {
	printf("Error: wrong string length for 'abc': %d\n", len);
	return 1;
    }

    string = "äüö";
    len = utf8_strlen(string);
    if (len != 3) {
	printf("Error: wrong string length for 'äüö'\n");
	return 1;
    }

    string = "1";
    len = utf8_strlen(string);
    if (len != 1) {
	printf("Error: wrong string length for '1'\n");
	return 1;
    }

    string = "";
    len = utf8_strlen(string);
    if (len != 0) {
	printf("Error: wrong string length for empty string\n");
	return 1;
    }

    char *buffer_string = "aäb";
    struct data_buffer buffer = { buffer_string, strlen(buffer_string), 0 };
    struct data_buffer c;

    len = data_buffer_char_utf8(&buffer, 0, &c);
    if (*c.data != 'a' && len != 1) {
	printf("Error: wrong char for pos 0: %.*s, len: %d\n", len,
		c.data, len);
	return 1;
    }

    len = data_buffer_char_utf8(&buffer, 1, &c);
    if (strncmp("ä", c.data, 2) && len != 2) {
	printf("Error: wrong char for pos 1: %.*s\n, len: %d", len,
		c.data, len);
	return 1;
    }

    len = data_buffer_char_utf8(&buffer, 2, &c);
    if (*c.data != 'b' && len != 1) {
	printf("Error: wrong char for pos 2: %.*s, len: %d\n", len,
		c.data, len);
	return 1;
    }
}
