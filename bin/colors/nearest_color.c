/* See LICENSE file for copyright and license details. */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

/*
 * X.org 256 colors palette
 * http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
 */
int map[256][3] = {
    {  0,  0,  0}, {128,  0,  0}, {  0,128,  0}, {128,128,  0}, {  0,  0,128}, {128,  0,128}, {  0,128,128}, {192,192,192},
    {128,128,128}, {255,  0,  0}, {  0,255,  0}, {255,255,  0}, {  0,  0,255}, {255,  0,255}, {  0,255,255}, {255,255,255},
    {  0,  0,  0}, {  0,  0, 95}, {  0,  0,135}, {  0,  0,175}, {  0,  0,215}, {  0,  0,255}, {  0, 95,  0}, {  0, 95, 95},
    {  0, 95,135}, {  0, 95,175}, {  0, 95,215}, {  0, 95,255}, {  0,135,  0}, {  0,135, 95}, {  0,135,135}, {  0,135,175},
    {  0,135,215}, {  0,135,255}, {  0,175,  0}, {  0,175, 95}, {  0,175,135}, {  0,175,175}, {  0,175,215}, {  0,175,255},
    {  0,215,  0}, {  0,215, 95}, {  0,215,135}, {  0,215,175}, {  0,215,215}, {  0,215,255}, {  0,255,  0}, {  0,255, 95},
    {  0,255,135}, {  0,255,175}, {  0,255,215}, {  0,255,255}, { 95,  0,  0}, { 95,  0, 95}, { 95,  0,135}, { 95,  0,175},
    { 95,  0,215}, { 95,  0,255}, { 95, 95,  0}, { 95, 95, 95}, { 95, 95,135}, { 95, 95,175}, { 95, 95,215}, { 95, 95,255},
    { 95,135,  0}, { 95,135, 95}, { 95,135,135}, { 95,135,175}, { 95,135,215}, { 95,135,255}, { 95,175,  0}, { 95,175, 95},
    { 95,175,135}, { 95,175,175}, { 95,175,215}, { 95,175,255}, { 95,215,  0}, { 95,215, 95}, { 95,215,135}, { 95,215,175},
    { 95,215,215}, { 95,215,255}, { 95,255,  0}, { 95,255, 95}, { 95,255,135}, { 95,255,175}, { 95,255,215}, { 95,255,255},
    {135,  0,  0}, {135,  0, 95}, {135,  0,135}, {135,  0,175}, {135,  0,215}, {135,  0,255}, {135, 95,  0}, {135, 95, 95},
    {135, 95,135}, {135, 95,175}, {135, 95,215}, {135, 95,255}, {135,135,  0}, {135,135, 95}, {135,135,135}, {135,135,175},
    {135,135,215}, {135,135,255}, {135,175,  0}, {135,175, 95}, {135,175,135}, {135,175,175}, {135,175,215}, {135,175,255},
    {135,215,  0}, {135,215, 95}, {135,215,135}, {135,215,175}, {135,215,215}, {135,215,255}, {135,255,  0}, {135,255, 95},
    {135,255,135}, {135,255,175}, {135,255,215}, {135,255,255}, {175,  0,  0}, {175,  0, 95}, {175,  0,135}, {175,  0,175},
    {175,  0,215}, {175,  0,255}, {175, 95,  0}, {175, 95, 95}, {175, 95,135}, {175, 95,175}, {175, 95,215}, {175, 95,255},
    {175,135,  0}, {175,135, 95}, {175,135,135}, {175,135,175}, {175,135,215}, {175,135,255}, {175,175,  0}, {175,175, 95},
    {175,175,135}, {175,175,175}, {175,175,215}, {175,175,255}, {175,215,  0}, {175,215, 95}, {175,215,135}, {175,215,175},
    {175,215,215}, {175,215,255}, {175,255,  0}, {175,255, 95}, {175,255,135}, {175,255,175}, {175,255,215}, {175,255,255},
    {215,  0,  0}, {215,  0, 95}, {215,  0,135}, {215,  0,175}, {215,  0,215}, {215,  0,255}, {215, 95,  0}, {215, 95, 95},
    {215, 95,135}, {215, 95,175}, {215, 95,215}, {215, 95,255}, {215,135,  0}, {215,135, 95}, {215,135,135}, {215,135,175},
    {215,135,215}, {215,135,255}, {215,175,  0}, {215,175, 95}, {215,175,135}, {215,175,175}, {215,175,215}, {215,175,255},
    {215,215,  0}, {215,215, 95}, {215,215,135}, {215,215,175}, {215,215,215}, {215,215,255}, {215,255,  0}, {215,255, 95},
    {215,255,135}, {215,255,175}, {215,255,215}, {215,255,255}, {255,  0,  0}, {255,  0, 95}, {255,  0,135}, {255,  0,175},
    {255,  0,215}, {255,  0,255}, {255, 95,  0}, {255, 95, 95}, {255, 95,135}, {255, 95,175}, {255, 95,215}, {255, 95,255},
    {255,135,  0}, {255,135, 95}, {255,135,135}, {255,135,175}, {255,135,215}, {255,135,255}, {255,175,  0}, {255,175, 95},
    {255,175,135}, {255,175,175}, {255,175,215}, {255,175,255}, {255,215,  0}, {255,215, 95}, {255,215,135}, {255,215,175},
    {255,215,215}, {255,215,255}, {255,255,  0}, {255,255, 95}, {255,255,135}, {255,255,175}, {255,255,215}, {255,255,255},
    {  8,  8,  8}, { 18, 18, 18}, { 28, 28, 28}, { 38, 38, 38}, { 48, 48, 48}, { 58, 58, 58}, { 68, 68, 68}, { 78, 78, 78},
    { 88, 88, 88}, { 96, 96, 96}, {102,102,102}, {118,118,118}, {128,128,128}, {138,138,138}, {148,148,148}, {158,158,158}
};

/*
 * takes a 24 bits colors as an argument, and return the nearest color from our
 * 256 X colors palette using the color quantization method.
 * check https://en.wikipedia.org/wiki/Color_quantization for more infos
 */
int
quantization(int rgb[3])
{
    int i, tmp, index;
    int distance = 442 * 442; /* it's always 442 somewhere */

    for (i = 0, tmp = 0; i < 256; i++) {
        tmp = (rgb[0] - map[i][0]) * (rgb[0] - map[i][0]) +
              (rgb[1] - map[i][1]) * (rgb[1] - map[i][1]) +
              (rgb[2] - map[i][2]) * (rgb[2] - map[i][2]);
        if (tmp < distance) {
            distance = tmp;
            index = i;
        }
    }
    return index;
}

/*
 * converts an hexadecimal representation of a color into a 3 dimensionnal
 * array (RGB decomposition)
 */
void
hex2rgb(char *hex, int *rgb)
{
    int i;
    char tmp[2];
    for (i = 0; i < 3; i++) {
        strncpy(tmp, hex + 1 + 2 * i, 2);
        rgb[i] = strtol(tmp, NULL, 16);
    }
}

int
main(int argc, char *argv[])
{
    char hex[8];
    int rgb[3], color = 0, truemod = 0;

    /* either use the "true-colors" ANSI escape (works only with Xterm) */
    if (argc > 1 && strncmp(argv[1], "-t", 2) == 0)
        truemod = 1;

    while (fgets(hex, 8, stdin)) {
        if (hex[0] == '#') {
            hex2rgb(hex, rgb);
            color = quantization(rgb);

            if (truemod) {
                printf("[48;2;%d;%d;%dm%8s[0m ", rgb[0],rgb[1],rgb[2], "");
                printf("[38;2;%d;%d;%dm%s [0m",  rgb[0],rgb[1],rgb[2], hex);
            } else {
                printf("[48;5;%dm%8s[0m ", color, "");
                printf("[38;5;%dm%s[0m",   color, hex);
            }
            printf("\n");
        }
    }

    printf("[0m");
    return 0;
}
