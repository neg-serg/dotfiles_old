#!/usr/bin/env python
"""cliphist.py: utility to print clipit history file.
If an argument is passed on the command line, it will
be used as a separator, otherwise history items are
separated by a blank line. """

import struct, os, sys

homedir  = os.environ['HOME']
histfile = homedir + '/.local/share/parcellite/history'
if len(sys.argv) > 1:
    sep = sys.argv[1]
else:
    sep = '---------------------------------------------------------------------'


with open(histfile,'rb') as f:
    f.read(68)
    size,_ = struct.unpack('2i',f.read(8))
    while (size > 0):
        item = f.read(size)
        print item
        _,_,_,size,_ = struct.unpack('5i',f.read(20))
        if size > 0:
            print sep
