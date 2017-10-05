#ifdef __gnu_linux__
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

const int text_len = 72;
const int max_word_len = 7;

int main(int argc, char *argv[])
{
    char *allowed_characters;
    if (argc != 2) {
	fprintf(stderr, "Usage: %s <characters>", argv[0]);
	exit(1);
    }
    asprintf(&allowed_characters, " %s", argv[1]);

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
        if (word_len < 5)
            r = (rand() % (n - 1)) + 1;
        else
            /* add a space */
            r = 0;

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
