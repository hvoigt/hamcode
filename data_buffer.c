#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "data_buffer.h"

#define printlog printf

void *die_malloc(size_t size)
{
    void *mem = malloc(size);
    if (mem == NULL) {
        printlog("Failed to allocate %lu bytes. Exiting", size);
        exit(1);
    }

    return mem;
}

struct data_buffer *data_buffer_create()
{
    struct data_buffer *msg = (struct data_buffer *)
            die_malloc(sizeof(struct data_buffer));

    msg->data = NULL;
    msg->data_len = 0;
    msg->alloc_len = 0;

    return msg;
}

static void alloc_more(struct data_buffer *buffer, size_t len)
{
	size_t new_len = (buffer->data_len + len) * 2;
	new_len = new_len > buffer->alloc_len * 2 ? new_len :
		buffer->alloc_len * 2;

	buffer->data = (char *) realloc(buffer->data, new_len);
	if (buffer->data == NULL) {
		printlog("Error no more memory!");
		exit(-1);
	}
	buffer->alloc_len = new_len;
}

void data_buffer_append(struct data_buffer *buffer, const char *data, size_t len)
{
    if (buffer->data_len + len > buffer->alloc_len)
		alloc_more(buffer, len);

    memcpy(buffer->data + buffer->data_len, data, len);
    buffer->data_len += len;
}

int data_buffer_printf(struct data_buffer *buffer, const char
		*format, ...)
{

	va_list args;
	va_start(args, format);
	int written = vsnprintf(buffer->data, buffer->alloc_len, format, args);
	va_end(args);
	if (written >= buffer->alloc_len)
		alloc_more(buffer, written);

	va_start(args, format);
	written = vsnprintf(buffer->data, buffer->alloc_len, format, args);
	va_end(args);
	if (written >= buffer->alloc_len) {
		printlog("Error: Failed to write into buffer");
		exit(-1);
	}

	buffer->data_len = written;

	return written;
}
