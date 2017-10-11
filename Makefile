CFLAGS=-std=c99
.PHONY: ebook2cw

all: lettermix ebook2cw

lettermix: lettermix.c

ebook2cw:
	$(MAKE) -C ebook2cw

clean:
	$(MAKE) -C ebook2cw clean
	rm lettermix
