#ifdef __gnu_linux__
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#include "data_buffer.h"

int text_len = 71;
const int max_word_len = 7;
int min_word_len = 5;
int random_wordlen = 0;
int probability_bias = 1;

static int my_rand()
{
    enum {
        USE_RAND,
        USE_DEV_RANDOM,
        RAND_UNDEFINED,
    } rand_method = RAND_UNDEFINED;

    static FILE *file;
    int number;

    if (rand_method == RAND_UNDEFINED) {
       file = fopen("/dev/urandom", "r");
       if (file == NULL)
           rand_method = USE_RAND;
       else
           rand_method = USE_DEV_RANDOM;
    }

    switch (rand_method) {
    case USE_DEV_RANDOM:
        fread(&number, sizeof(int), 1, file);
        number = number < 0 ? -number : number;
        number = number % RAND_MAX;
        break;
    default:
        number = rand();
    }

    return number;
}

int main(int argc, char *argv[])
{
    struct data_buffer allowed_characters = DATA_BUFFER_INIT;

    /* jump over programname */
    const char *exe_name = argv[0];
    argv++;
    argc--;

    while (argc > 1) {
        if (strcmp("-e", *argv) == 0) {
            text_len = 80;
            min_word_len = 2;
            random_wordlen = 1;
        } else if (strcmp("-b", *argv) == 0) {
            if (argc > 1) {
                probability_bias = atoi(argv[1]);
                if (probability_bias <= 0) {
                    fprintf(stderr, "probability bias (-b option) needs to be positive\n");
                    exit(1);
                }
                argc--;
                argv++;
            } else {
                fprintf(stderr, "probability bias (-b option) needs a number\n");
                exit(1);
            }
        } else {
            break;
        }
        argc--;
        argv++;
    }

    if (argc != 1) {
	fprintf(stderr, "Usage: %s [-e] <characters>", exe_name);
	exit(1);
    }

    struct data_buffer characters;
    characters.data = argv[0];
    characters.data_len = strlen(argv[0]);
    characters.alloc_len = 0;

    data_buffer_printf(&allowed_characters, " ");

    int n_chars = utf8_strlen(characters.data);
    for (int i = 0; i < n_chars; i++) {
        struct data_buffer c;
        for (int j=0; j < i*probability_bias/n_chars + 1; j++) {
            int len = data_buffer_char_utf8(&characters, i, &c);
            data_buffer_append(&allowed_characters, c.data, len);
        }
    }

#if 0
    /* for debugging purposes */
    allowed_characters.data[allowed_characters.data_len] = '\0';
    printf("String: '%s'\n", allowed_characters.data);
#endif

    struct timeval time;
    if (gettimeofday(&time, NULL) != 0) {
	perror("Could not get time: ");
	exit(1);
    }

    int millis = (time.tv_sec * 1000) + (time.tv_usec / 1000);
    srand(millis);
    int word_len = 0;
    int n = utf8_strlen(allowed_characters.data);
    for (int i = 0; i < text_len; i++) {
        int r;
        if (word_len < min_word_len) /* no space in random selection */
            r = (my_rand() % (n - 1)) + 1;
        else {
            if (random_wordlen)
                r = my_rand() % n;
            else /* add a space */
                r = 0;
        }

        struct data_buffer c, space = { " ", 1, 0 };
        data_buffer_char_utf8(&allowed_characters, r, &c);

        if (word_len > max_word_len)
            c = space;

        printf("%.*s", (int) c.data_len, c.data);

        if (*c.data == ' ')
            word_len = 0;
        else
            word_len++;
    }

    return 0;
}
