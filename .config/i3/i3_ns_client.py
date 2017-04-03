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
from redis import Redis
from rq import Queue
import i3_ns_daemon

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    ns=i3_ns_daemon.named_scratchpad()

    redis_conn = Redis()
    queue = Queue(connection=redis_conn)

    if argv["show"]:
        job = queue.enqueue(ns.focus(), argv['<name>'])
    elif argv["hide"]:
        job = queue.enqueue(ns.unfocus(), argv['<name>'])
    elif argv["toggle"]:
        job = queue.enqueue(ns.toggle(), argv['<name>'])
    elif argv["next"]:
        job = queue.enqueue(ns.next(), argv['<name>'])
