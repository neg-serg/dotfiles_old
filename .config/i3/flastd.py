#!/usr/bin/env python3

"""

Focus last focused window.

Usage:
    flastd.py daemon

Options:
    -h, --help  show this help message and exit

"""

import i3ipc
import os

from threading import Thread
from docopt import docopt
from singleton_mixin import *
from queue import Queue
import time

max_win_history_ = 10

q = Queue()
fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/flastd_i3.fifo'))
if os.path.exists(fifo_):
    os.remove(fifo_)

try:
    os.mkfifo(fifo_)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def fifo_listner():
    fw=FocusWatcher.instance()
    with open(fifo_) as fifo:
        while True:
            data = fifo.read()
            if len(data) == 0:
                break
            eval_str=data.split('\n', 1)[0]
            if len(eval_str) > 0:
                if eval_str == "switch":
                    fw.alt_tab()

def worker():
    while True:
        if q.empty():
            exit()
        i = q.get()
        q.task_done()

def mainloop_fw():
    while True:
        q.put(fifo_listner())
        Thread(target=worker).start()


class FocusWatcher(SingletonMixin):
    def __init__(self):
        self.window_list = i3.get_tree().leaves()
        self.prev_time = 0
        self.curr_time = 0

    def alt_tab(self):
        self.curr_time = time.time()
        windows = set(w.id for w in i3.get_tree().leaves())
        for wid in self.window_list[1:]:
            if wid not in windows:
                self.window_list.remove(wid)
            else:
                if self.curr_time - self.prev_time > 0.05:
                    i3.command('[con_id=%s] focus' % wid)
                    self.prev_time = self.curr_time
                    self.curr_time = time.time()
                break

def on_window_focus(self, event):
    wid = event.container.id
    fw=FocusWatcher.instance()

    if wid in fw.window_list:
        fw.window_list.remove(wid)

    fw.window_list.insert(0, wid)
    if len(fw.window_list) > max_win_history_:
        del fw.window_list[max_win_history_:]

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 nice alt-tab 1.0')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    if argv["daemon"]:
        i3.on('window::focus', on_window_focus)

        mainloop=Thread(target=mainloop_fw).start()

        i3.main()
