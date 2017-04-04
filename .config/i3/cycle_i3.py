#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  cycle_i3.py daemon

"""

import i3ipc
import i3 as i3hl

from sys import argv, exit

import subprocess

import uuid
import re

from subprocess import check_output
from docopt import docopt
from cycle_settings import *

from queue import Queue
from threading import Thread, Lock, enumerate

import re
import errno
import os

glob_settings=cycle_settings().settings
q = Queue()

tagged={}
for i in glob_settings:
    tagged[i]=list()

# Based on tornado.ioloop.IOLoop.instance() approach.
# See https://github.com/facebook/tornado
class SingletonMixin(object):
    __singleton_lock = Lock()
    __singleton_instance = None

    @classmethod
    def instance(class_):
        if not class_.__singleton_instance:
            with class_.__singleton_lock:
                if not class_.__singleton_instance:
                    class_.__singleton_instance = class_()
        return class_.__singleton_instance

class cycle_window(SingletonMixin):
    def __init__(self):
        self.tab_position=0
        self.wlist=[]
        self.focused=[]

    def go_next(self, tag):
        self.wlist = i3.get_tree().leaves()
        self.focused = i3.get_tree().find_focused()
        print("tagged={}".format(tagged))
        print("tagged[tag]={}".format(tagged[tag]))
        if tagged[tag] == []:
            prog=glob_settings[tag]["prog"]
            i3.command('exec {}'.format(prog))
        else:
            try:
                self.cur=tagged[tag][self.tab_position]
                if not self.focused.window_class in glob_settings[tag]["priority"]:
                    for num,pr in zip(range(len(self.wlist)),self.wlist):
                        if pr.window_class == glob_settings[tag]["priority"]:
                            pr.command('focus')
                            self.tab_position+=1
                else:
                    if tagged[tag][self.tab_position].fullscreen_mode != False and len(tagged[tab]) > 1:
                        tagged[tag][self.tab_position].command('fullscreen disable')
                    if self.tab_position < len(tagged[tag]):
                        indexofnext=self.tab_position+1
                    else:
                        indexofnext=0
                    tagged[tag][indexofnext].command('focus')
                    self.tab_position=indexofnext
            except IndexError as ex:
                self.cur=tagged[tag][0]
                if self.cur.id != self.focused.id:
                    self.cur.command('focus')
                    self.tab_position=0

fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/i3_tags.fifo'))
if os.path.exists(fifo_):
    os.remove(fifo_)

try:
    os.mkfifo(fifo_)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def fifo_listner():
    cl=cycle_window.instance()
    with open(fifo_) as fifo:
        while True:
            data = fifo.read()
            if len(data) == 0:
                break
            eval_str=data.split('\n', 1)[0]
            args=list(filter(lambda x: x != '', eval_str.split(' ')))
            if len(args) > 0:
                if args[0] == "next":
                    cl.go_next(args[1])

def worker():
    while True:
        if q.empty():
            exit()
        i = q.get()
        q.task_done()

def mainloop_cycle():
    while True:
        q.put(fifo_listner())
        Thread(target=worker).start()


def find_acceptable_windows_by_class(tag, wlist):
    global tagged
    for cur in wlist:
        if cur.window_class in glob_settings[tag]["classes"]:
            tagged[tag].append(cur)

def find_all():
    wlist = i3.get_tree().leaves()
    for tag in glob_settings:
        find_acceptable_windows_by_class(tag, wlist)

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

def add_acceptable(self, event):
    con = event.container
    for tag in glob_settings:
        if not con.window_class in glob_settings[tag]["priority"]:
            tagged[tag].append(con)

# handle events, do not try to do it from the one script
if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    if argv["daemon"]:
        find_all()
        i3.on('window::new', add_acceptable)
        mainloop=Thread(target=mainloop_cycle).start()
        i3.main()
