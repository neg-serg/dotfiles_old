#!/usr/bin/env python

"""1.4 John Eikenberry <jae@zhar.net> GPL-3+ http://zhar.net/projects/

Copyright
    Copyright (C) 2010 John Eikenberry <jae@zhar.net>

License
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.

Description
    My goal in writing this script was to provide all the functionality of all
    the various perl/sh scripts found around the web in one place with some
    additional bells and whistles.

    It automatically detects 8, 16, 88, 256 color capabilities (via ncurses)
    and displays the appropriate color charts. It can display the colors as
    blocks or (2d) cubes optionally with color values overlaid in int or hex
    values.  It can show the full rgb text string as well. It can also show the
    display with a vertical (default) or horizontal orientation. It has the
    option of additional padding and supports -h --help as well.

    It also works as a utility for converting between 256 and 88 color values.

Development
    Note on coding style. I was playing around with using classes as simple
    module-esque namespaces; ie. having classes that have all staticmethods and
    never get instatiated. As it makes calls at the module level this script is
    not really importable, thus limiting reuse. I plan on fixing this as well
    as implementing some testing when I get time.

Contributors
    Isaac Cammann <icammann@gmail.com> - cube display bugfix

"""
__version__ = __doc__.split('\n')[0]

import sys
import curses
from optparse import OptionParser, OptionGroup, make_option
from math import ceil, sqrt

# output constants
fg_escape = "\x1b[38;5;%dm"
bg_escape = "\x1b[48;5;%dm"
clear = "\x1b[0m"

def _get_options(args):
    """ Setup and parse options.
    """
    option_list = [
        make_option("-b", "--block", action="store_true", dest="block",
            default=True, help="Display as block format (vs cube) [default]."),
        make_option("-c", "--cube-slice", action="store_true", dest="cube",
            default=False, help="Display as cube slices (vs block)."),
        make_option("-l", "--rgb", action="store_true", dest="rgb",
            default=False, help="Long format. RGB values as text."),
        make_option("-n", "--numbers", action="store_true", dest="numbers",
            default=False, help="Include color escape numbers on chart."),
        make_option("-p", "--padding", action="store_true", dest="padding",
            default=False, help="Add extra padding (helps discern colors)."),
        make_option("-v", "--vertical", action="store_true", dest="vertical",
            default=True, help="Display with vertical orientation [default]."),
        make_option("-x", "--hex", action="store_true", dest="hex",
            default=False, help="Include hex color numbers on chart."),
        make_option("-z", "--horizontal", action="store_true",
            dest="horizontal", default=False,
            help="Display with horizontal orientation."),
        ]

    parser = OptionParser(version=__version__, option_list=option_list)

    convert_option_list = [
        make_option("-r", "--256to88", action="store", dest="reduce",
            metavar="N", type="int",
            help="Convert (reduce) 256 color value N to an 88 color value."),
        make_option("-e", "--88to256", action="store", dest="expand",
            metavar="N", type="int",
            help="Convert (expand) 88 color value N to an 256 color value."),
        ]
    group = OptionGroup(parser, "Conversion options")
    group.add_options(option_list=convert_option_list)
    parser.add_option_group(group)

    (options, args) = parser.parse_args(args)
    return options

# instantiate global options based on command arguments
options = _get_options(sys.argv[1:])


class _staticmethods(type):
    """ Got tired of adding @staticmethod in front of every method.
    """
    def __new__(m, n, b, d):
        """ turn all methods in to staticmethods.
            staticmethod() deals correctly with class attributes.
        """
        for (n, f) in d.items():
            if callable(f):
                d[n] = staticmethod(f)
        return type.__new__(m, n, b, d)


class term16(object):
    """ Basic 16 color terminal.
    """
    __metaclass__ = _staticmethods

    def _label():
        """ color label
        """
        if options.numbers:
            return " %2d "
        elif options.hex:
            return " %2x "
        return "  "

    def fg(label, n):
        """ foreground formatting
        """
        fg = n < 8 and 15 or 0
        try:
            return fg_escape % fg + label % n + clear
        except TypeError:
            return fg_escape % fg + label + clear

    def _color_table():
        """ 16 color info
        """
        label = term16._label()
        return [
                [bg_escape % n + term16.fg(label, n) + clear
                    for n in range(8)],
                [bg_escape % n + term16.fg(label, n) + clear
                    for n in range(8,16)]
            ]

    def display():
        """ display 16 color info
        """
        print("System colors:")
        colors = term16._color_table()
        padding='  ' if options.padding else ''
        for r in colors:
            print(padding.join(i for i in r))
            if options.padding: print("")


class term256(term16):
    """ eg. xterm-256
    """

    def _rgb_lookup():
        """ color rgb lookup dict
        """
        rgb = "%02x/%02x/%02x"
        cincr = [0] + [95+40*n for n in range(5)]
        color_rgb = [rgb % (i, j, k)
                for i in cincr for j in cincr for k in cincr]
        color_rgb = dict(zip(range(16, len(color_rgb)+16), color_rgb))
        greys = [rgb % (((8+n),)*3) for n in range(0, 240, 10)]
        greys = dict(zip(range(232, 256), greys))
        color_rgb.update(greys)
        return color_rgb

    def _rgb_color_table():
        """ 256 color info
        """
        label = "% 4d: %s"
        _rgb = term256._rgb_lookup()
        return [[fg_escape % n + label % (n, _rgb[n]) + clear
                for n in [i+j for j in range(6)]]
                    for i in range(16, 256, 6)]

    def _rgb_display():
        """ display colors with rgb hex info
        """
        colors = term256._rgb_color_table()
        padding='  ' if options.padding else ''
        while colors:
            rows, colors = colors[:6], colors[6:]
            if not options.horizontal:
                rows = zip(*rows)
            for r in rows:
                print(padding.join(i for i in r))
                if options.padding: print("")
            print("")

    def _label():
        """ color label for 256 color values
        """
        if options.numbers:
            return "%3d "
        elif options.hex:
            return " %2x "
        return "  "

    def fg(label, n):
        """ foreground formatting
        """
        if n < 232:
            fg = n < 124 and 15 or 0
        else:
            fg = n < 244 and 15 or 0
        try:
            return fg_escape % fg + label % n + clear
        except TypeError:
            return fg_escape % fg + label + clear

    def _color_table():
        """ compact 256 color info
        """
        label = term256._label()
        return [[bg_escape % n + term256.fg(label, n) + clear
                for n in [i+j for j in range(6)]]
                    for i in range(16, 232, 6)]

    def _grey_table():
        """ compact grey table
        """
        label = " " + term256._label()
        return [[bg_escape % n + term256.fg(label, n) + clear
                for n in [i+j for j in range(12)]]
                    for i in range(232, 256, 12)]

    def _compact_display():
        """ display colors in compact format
        """
        colors = term256._color_table()
        if options.cube:
            _cube_display(colors)
        elif options.block:
            _block_display(colors)
        print("")
        print("Greyscale ramp:")
        greys  = term256._grey_table()
        padding='  ' if options.padding else ''
        for r in greys:
            print(padding.join(i for i in r))
            if options.padding: print("")

    def display():
        """ display 256 color info (+ 16 in compact format)
        """
        if options.rgb:
            print("Xterm RGB values for 6x6x6 color cube and greyscale.")
            print("")
            term256._rgb_display()
        else:
            term16.display()
            print("")
            print("6x6x6 color cube:")
            term256._compact_display()


class term88(term16):
    """ xterm-88 or urxvt
    """

    def _rgb_lookup():
        """ color rgb lookup dict
        """
        rgb = "%02x/%02x/%02x"
        cincr = [0, 0x8b, 0xcd, 0xff]
        color_rgb = [rgb % (i, j, k)
                for i in cincr for j in cincr for k in cincr]
        color_rgb = dict(zip(range(16, len(color_rgb)+16), color_rgb))
        greys = [rgb % ((n,)*3)
                for n in [0x2e, 0x5c, 0x73, 0x8b, 0xa2, 0xb9, 0xd0, 0xe7]]
        greys = dict(zip(range(80, 88), greys))
        color_rgb.update(greys)
        return color_rgb

    def _rgb_color_table():
        """ 256 color info
        """
        label = "% 4d: %s"
        _rgb = term88._rgb_lookup()
        return [[fg_escape % n + label % (n, _rgb[n]) + clear
                for n in [i+j for j in range(4)]]
                    for i in range(16, 88, 4)]

    def _rgb_display():
        """ display colors with rgb hex info
        """
        colors = term88._rgb_color_table()
        while colors:
            rows, colors = colors[:4], colors[4:]
            for r in zip(*rows):
                print(''.join(i for i in r))
            print("")

    def fg(label, n):
        if n < 80:
            fg = n < 48 and 15 or 0
        else:
            fg = n < 84 and 15 or 0
        try:
            return fg_escape % fg + label % n + clear
        except TypeError:
            return fg_escape % fg + label + clear

    def _color_table():
        """ 88 color info
        """
        label = term88._label()
        return [[bg_escape % n + term88.fg(label, n) + clear
                for n in [i+j for j in range(4)]]
                    for i in range(16, 80, 4)]

    def _grey_table():
        """ 88 color grey info
        """
        label = term88._label()
        return [bg_escape % n + term88.fg(label, n) + clear
                for n in range(80, 88)]

    def display():
        """ display 16 + 88 color info
        """
        if options.rgb:
            print("Xterm RGB values for 4x4x4 color cube and greyscale.")
            print("")
            term88._rgb_display()
        else:
            padding = '  ' if options.padding else ''
            term16.display()
            print("")
            print("4x4x4 color cube:")
            colors = term88._color_table()
            if options.cube:
                _cube_display(colors)
            elif options.block:
                _block_display(colors)
            print("")
            print("Greyscale ramp:")
            greys  = term88._grey_table()
            print(padding.join(i for i in greys))


def _cube_display(colors):
    """ Display color cube as color aligned flatten cube sides.
    """
    padding = '  ' if options.padding else ''
    if options.horizontal:
        def _horizontal(colors):
            size = int(sqrt(len(colors)))
            for n in (n*size for n in range(size)):
                colors[n:n+size] = zip(*colors[n:n+size])
            while colors:
                rows, colors = colors[:size*2], colors[size*2:]
                for n in range(size):
                    print(padding.join(i
                            for i in rows[n]+tuple(reversed(rows[n+size]))))
                    if options.padding: print(padding)
                if colors: print("")
        _horizontal(colors)
    else: #options.vertical - default
        def _vertical(colors):
            size = int(sqrt(len(colors)))
            top = [colors[n:len(colors):size*2] for n in range(size)]
            bottom = [colors[n+size:len(colors):size*2]
                    for n in reversed(range(size))]
            for group in [top, bottom]:
                for rows in group:
                    for r in rows:
                        print(padding.join(i for i in r), end = ' ')
                        if options.padding: print(padding, end = ' ')
                    if options.padding: print("")
                    print("")
        _vertical(colors)

def _block_display(colors):
    """ Display color cube as cube sides organized by color #s (default).
    """
    padding = '  ' if options.padding else ''
    size = int(sqrt(len(colors)))
    if not options.horizontal:
        for n in (n*size for n in range(size)):
            colors[n:n+size] = zip(*colors[n:n+size])
    while colors:
        half = size*int(size/2)
        rows, colors = colors[:half], colors[half:]
        for n in range(size):
            for r in rows[n:len(rows):size]:
                print(padding.join(i for i in r), end = ' ')
                if options.padding: print(padding, end = ' ')
            if options.padding: print("")
            print("")
        if colors: print("")

def convert88to256(n):
    """ 88 (4x4x4) color cube to 256 (6x6x6) color cube values
    """
    if n < 16:
        return n
    elif n > 79:
        return 234 + (3 * (n - 80))
    else:
        def m(n):
            "0->0, 1->1, 2->3, 3->5"
            return n and n + n-1 or n
        b = n - 16
        x = b % 4
        y = (b / 4) % 4
        z = b / 16
        return 16 + m(x) + (6 * m(y) + 36 * m(z))

def convert256to88(n):
    """ 256 (6x6x6) color cube to 88 (4x4x4) color cube values
    """
    if n < 16:
        return n
    elif n > 231:
        if n < 234:
            return 0
        return 80 + ((n - 234) / 3)
    else:
        def m(n, _ratio=(4./6.)):
            if n < 2:
                return int(ceil(_ratio*n))
            else:
                return int(_ratio*n)
        b = n - 16
        x = b % 6
        y = (b / 6) % 6
        z = b / 36
        return 16 + m(x) + (4 * m(y) + 16 * m(z))

def _terminal():
    """ detect # of colors supported by terminal and return appropriate
        terminal class
    """
    curses.setupterm()
    num_colors = curses.tigetnum('colors')
    if num_colors > 0:
        return {16:term16, 88:term88, 256:term256}.get(num_colors, term16)

def main():
    if options.reduce:
        v = convert256to88(options.reduce)
        # reconvert back to display reduction in context
        print("{0} (equivalent to 256 value: {1})".format(v, convert88to256(v)))
    elif options.expand:
        print(convert88to256(options.expand))
    else:
        term = _terminal()
        if term is None:
            print("Your terminal reports that it has no color support.")
        else:
            term.display()

if __name__ == "__main__":
    main()
