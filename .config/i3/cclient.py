#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  nclient.py next <name>
  nclient.py (-h | --help)
  nclient.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from docopt import docopt
import os.path

fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/i3_tags.fifo'))

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 cycler over windows')
    possible_commands=["next"]

    for i in argv:
        if argv[i] and i in set(possible_commands):
            with open(fifo_,"w") as fp:
                fp.write(i+" "+argv["<name>"]+"\n")