#include <stdio.h>

int main(int argc, char* argv[])
{
    FILE* fp = fopen(argv[1], "r");
    int c, i;
    for(i = 0;(c = fgetc(fp)) != EOF; i++) {
        if ((i % 8) == 0)
            printf(".byte ");
        printf("0x%02x", c);
        if ((i % 8) != 7)
            printf(", ");
        else
            puts("");
    }

    return 0;
}
