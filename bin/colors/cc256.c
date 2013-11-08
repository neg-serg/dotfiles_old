#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>

void usage() {
  printf("Usage: cc256 [-c columns] [-t foreground text]\n\n");
  printf("  \033[1mcc256\033[0m will output a table representing up to 256 colors\n");
  printf("  which might be supported by your terminal emulator.\n");
  printf("  If a number is provided as the first argument, that'll define\n");
  printf("  the number of columns used. The default is 8.\n\n");
  printf("  rxvt-unicode supports 88 colors out of the box.\n");
  printf("  It'll support 256 colors if patched.\n");
  printf("  xterm supports 256 colors out of the box\n");
  exit(0);
}

int main(int argc, char *argv[]) {
  char *fg_char    = NULL;
  char *end        = "\033[0m";
  int columns = 16;

  int color_int, opt;

  while((opt = getopt(argc, argv, "hc:t:")) != -1) {
    switch(opt) {
      case 'c':
        columns = atoi(optarg);
        if(columns == 0) {
          usage();
          exit(0);
        }
        else {
          /* dont let the args fall though */
          break;
        }
      case 't':
        fg_char = optarg;
        break;
      case 'h':
        usage();
        break;
      default:
        fprintf(stderr, "Usage: %s [-c columns] [-t] text to print\n", "cc256");
        exit(EXIT_FAILURE);
    }
  }


  for(color_int=0;color_int<255;++color_int) {
    if(color_int % columns == 0) {
      end = "\033[0m\n";
    }
    else {
      end = "\033[0m";
    }
    if(color_int == 0) {
      continue;
    }
    if(fg_char != NULL) {
      printf("\033[48;5;%d%s %s %s", color_int, "m",fg_char, end);
    }
    else {
      printf("\033[48;5;%d%s %03d %s", color_int, "m", color_int, end);
    }
  }
  printf("\n");
  return(0);
}
