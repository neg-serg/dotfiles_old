#!/bin/sh
# Base16 Bespin - Console color setup script
# Jan T. Sott

color00="28/21/1c" # Base 00 - Black
color01="cf/6a/4c" # Base 08 - Red
color02="54/be/0d" # Base 0B - Green
color03="f9/ee/98" # Base 0A - Yellow
color04="5e/a6/ea" # Base 0D - Blue
color05="9b/85/9d" # Base 0E - Magenta
color06="af/c4/db" # Base 0C - Cyan
color07="8a/89/86" # Base 05 - White
color08="66/66/66" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="ba/ae/9e" # Base 07 - Bright White
color16="cf/7d/34" # Base 09
color17="93/71/21" # Base 0F
color18="36/31/2e" # Base 01
color19="5e/5d/5c" # Base 02
color20="79/79/77" # Base 04
color21="9d/9b/97" # Base 06

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
else
  printf_template="\033]4;%d;rgb:%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
if [ "$TERM" != linux ]; then
  printf $printf_template 16 $color16
  printf $printf_template 17 $color17
  printf $printf_template 18 $color18
  printf $printf_template 19 $color19
  printf $printf_template 20 $color20
  printf $printf_template 21 $color21
fi

# clean up
unset printf_template
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
