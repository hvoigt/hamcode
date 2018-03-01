CFLAGS=-std=c99
.PHONY: ebook2cw

all: lettermix ebook2cw

test_data_buffer: test_data_buffer.c data_buffer.c
lettermix: lettermix.c data_buffer.c

ebook2cw:
	$(MAKE) -C ebook2cw

clean:
	$(MAKE) -C ebook2cw clean
	rm lettermix
	rm test_data_buffer
