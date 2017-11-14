#ifdef __gnu_linux__
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

int text_len = 71;
const int max_word_len = 7;
int min_word_len = 5;
int random_wordlen = 0;

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
    char *allowed_characters;

    /* jump over programname */
    const char *exe_name = argv[0];
    argv++;
    argc--;

    while (argc > 1) {
        if (strcmp("-e", *argv) == 0) {
            text_len = 80;
            min_word_len = 2;
            random_wordlen = 1;
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
    asprintf(&allowed_characters, " %s", argv[0]);

    struct timeval time;
    if (gettimeofday(&time, NULL) != 0) {
	perror("Could not get time: ");
	exit(1);
    }

    int millis = (time.tv_sec * 1000) + (time.tv_usec / 1000);
    srand(millis);
    int word_len = 0;
    int n = strlen(allowed_characters);
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

        char c = allowed_characters[r];
        if (word_len > max_word_len)
            c = ' ';

        printf("%c", c);
        if (c == ' ')
            word_len = 0;
        else
            word_len++;
    }

    return 0;
}
