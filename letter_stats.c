/* a simple tool to count character occurrences in a
 * text.
 * Compile with:
 *
 *      gcc letter_stats.c -o letter_stats

 * Usage: letter_stats < file.txt
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <limits.h>
#include <stdlib.h>

void die_usage()
{
    fprintf(stderr, "Usage: letter_stats [-s] [-m] < file.txt");
    exit(1);
}

int main(int argc, char *argv[])
{
    int use_min_max = 0, generate_string = 0, divisor = 1;
    char line[4096];
    int stats[256];
    memset(stats, 0, sizeof(stats));

    argc--;
    argv++;
    while (argc > 0) {
        if (!strcmp(*argv, "-s")) {
            generate_string = 1;
            use_min_max = 1;
        } else if (!strcmp(*argv, "-m"))
            use_min_max = 1;
        else
            die_usage();

        argc--;
        argv++;
    }

    while (fgets(line, sizeof(line), stdin) != NULL) {
        for (int i = 0; line[i]; i++) {
            char c = tolower(line[i]);
            stats[c]++;
        }
    }

    if (use_min_max) {
        int min = INT_MAX;
        int max = 0;
        for (int i = ' '; i <= '~'; i++) {
            if (stats[i] == 0)
                continue;

            max = stats[i] > max ? stats[i] : max;
            min = stats[i] < min ? stats[i] : min;
        }

        printf("Min: %d, Max: %d\n", min, max);
        divisor = min;
    }

    for (int i = '!'; i <= '~'; i++) {
        if (stats[i] == 0)
            continue;

        int count = stats[i] / divisor;

        if (generate_string) {
            for (int j = 0; j < count; j++)
                printf("%c", i);
        } else
            printf("%10d : %c\n", count, i);
    }
}
