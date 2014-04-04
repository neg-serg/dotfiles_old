#!/usr/bin/python
from __future__ import print_function

# Very simple script to parse the types_c generated file
# and put it in a format that makes direct comparison between
# versions practical (a development tool only).

import re

with open('types_c.taghl') as fh:
    lines = [i.strip() for i in fh.readlines()]

filename = "None"
new_lines = []
for line in lines:
    if line.startswith('"'):
        continue
    elif len(line) == 0:
        continue
    elif line.startswith('if b:TagHighlightPrivate'):
        filename = re.sub(r'.*== "(.*)"', r'\1', line)
    elif line.startswith('endif'):
        filename = 'None'
    elif line.startswith('syn keyword'):
        remainder = line[12:]
        parts = remainder.split()
        id = parts[0]
        bits = parts[1:]
        for bit in bits:
            new_lines.append('%s:%s:%s\n' % (filename, id, bit))
    else:
        print("Unhandled line: '%s'" % line)

with open('tcp.taghl', 'w') as fh:
    for entry in sorted(new_lines):
        fh.write(entry)
