#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  nclient.py show <name>
  nclient.py hide <name>
  nclient.py toggle <name>
  nclient.py next
  nclient.py hide_current
  nclient.py (-h | --help)
  nclient.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from docopt import docopt
import os.path

name_="ns_scratchd"
fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/'+name_+'.fifo'))

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    possible_commands=["show","hide","toggle","next","hide_current"]

    for i in argv:
        if argv[i] and i in set(possible_commands):
            with open(fifo_,"w") as fp:
                if not (argv["<name>"] is None):
                    fp.write(i+" "+argv["<name>"]+"\n")
                else:
                    fp.write(i+"\n")
