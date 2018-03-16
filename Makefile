CFLAGS=-std=c99
.PHONY: ebook2cw

all: lettermix ebook2cw letter_stats

test_data_buffer: test_data_buffer.c data_buffer.c
lettermix: lettermix.c data_buffer.c
letter_stats: letter_stats.c

ebook2cw:
	$(MAKE) -C ebook2cw

clean:
	$(MAKE) -C ebook2cw clean
	rm lettermix
	rm test_data_buffer
