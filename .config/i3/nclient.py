#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  i3_ns_client.py show <name>
  i3_ns_client.py hide <name>
  i3_ns_client.py toggle <name>
  i3_ns_client.py next <name>
  i3_ns_client.py (-h | --help)
  i3_ns_client.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from docopt import docopt

fifo_="/tmp/ns_scratchpad.fifo"

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    possible_commands=["show","hide","toggle","next"]

    for i in argv:
        if argv[i] and i in set(possible_commands):
            with open(fifo_,"w") as fp:
                fp.write(i+" "+argv["<name>"])
