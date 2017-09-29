#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

const int text_len = 80;
const int max_word_len = 7;

int main(int argc, char *argv[])
{
    char *allowed_characters;
    if (argc != 2) {
	fprintf(stderr, "Usage: %s <characters>", argv[0]);
	exit(1);
    }
    asprintf(&allowed_characters, " %s", argv[1]);

    srand(time(NULL));
    int word_len = 0;
    int n = strlen(allowed_characters);
    for (int i = 0; i < text_len; i++) {
        int r;
        if (word_len < 2)
            r = (rand() % (n - 1)) + 1;
        else
            r = rand() % n;

        char c = allowed_characters[r];
        if (word_len > max_word_len)
            c = ' ';

        if (c == ' ')
            word_len = 0;

        printf("%c", c);
        word_len++;
    }

    return 0;
}
