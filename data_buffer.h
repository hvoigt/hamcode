#ifndef DATA_BUFFER_H
#define DATA_BUFFER_H

#include <stddef.h>

struct data_buffer {
    char *data;
    size_t data_len;
    size_t alloc_len;
};

#define DATA_BUFFER_INIT { NULL, 0, 0 };

void *die_malloc(size_t size);
struct data_buffer *data_buffer_create();
void data_buffer_append(struct data_buffer *buffer, const char *data, size_t len);
int data_buffer_printf(struct data_buffer *buffer, const char *format, ...);
/* return the character (c) and its length in bytes at position pos */
int data_buffer_char_utf8(struct data_buffer *buffer, int pos,
        struct data_buffer *c);

int utf8_strlen(const char *str);
int utf8_charsize(unsigned char c);

#endif // DATA_BUFFER_H
