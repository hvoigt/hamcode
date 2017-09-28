#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int text_len = 80;
const int max_word_len = 7;
const char *allowed_characters = " kmuresnaptlwi,jz=foy,vg5/q";
//const char *allowed_characters = " kmuresnaptlwi,jz=foy,vg5/q92h38b?47c1d60x";

int main(int argc, char *argv[])
{
    sranddev();
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
