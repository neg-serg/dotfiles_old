#!/usr/bin/env ruby

def block(color)
  "\e[48;5;#{color}m" << ' ' * 8 << "\e[0m"
end

def hexa(color, hexcode)
  "\e[38;5;#{color}m" << hexcode << "\e[0m"
end

hexas = `xrq color{0..15}`.split

(0..7).each_with_index do |color, i|
  printf("%s %s\t%s %s\n",
         block(color), hexa(color, hexas[i]),
         block(color + 8), hexa(color, hexas[i + 8]))
end
