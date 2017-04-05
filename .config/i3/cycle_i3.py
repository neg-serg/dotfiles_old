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

from itertools import cycle

glob_settings=cycle_settings().settings
q = Queue()

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
        self.win_iter=None
        self.tagged={}
        self.counters={}
        for i in glob_settings:
            self.tagged[i]=list({})
            self.counters[i]=0

    def go_next(self, tag):
        try:
            self.win_iter=cycle(self.tagged[tag])

            if len(self.tagged[tag]) == 0:
                prog=glob_settings[tag]["prog"]
                i3.command('exec {}'.format(prog))
            elif len(self.tagged[tag]) == 1:
                self.tagged[tag][0]['win'].command('focus')
                self.tagged[tag][0]['focused']=True
            else:
                self.tagged[tag][self.counters[tag]%len(self.tagged[tag])]['win'].command('focus')
            self.counters[tag]+=1
        except KeyError:
            find_all()
            if self.counters[tag] > 0:
                self.counters[tag]-=1
            self.go_next(tag)

fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/i3_tags.fifo'))
if os.path.exists(fifo_):
    os.remove(fifo_)

try:
    os.mkfifo(fifo_)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def fifo_listner():
    cw=cycle_window.instance()
    with open(fifo_) as fifo:
        while True:
            data = fifo.read()
            if len(data) == 0:
                break
            eval_str=data.split('\n', 1)[0]
            args=list(filter(lambda x: x != '', eval_str.split(' ')))
            if len(args) > 0:
                if args[0] == "next":
                    cw.go_next(args[1])

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
    cw=cycle_window.instance()
    for con in wlist:
        if con.window_class in glob_settings[tag]["classes"]:
            cw.tagged[tag].append({ 'win':con, 'focused':False })

def print_tagged_info(tag):
    cw=cycle_window.instance()
    for win in cw.tagged[tag]:
        print("tagged[{}]={}~{}".format(tag,win['win'].name,win['focused']))

def find_all():
    cw=cycle_window.instance()
    wlist = i3.get_tree().leaves()
    cw.tagged={}

    for i in glob_settings:
        cw.tagged[i]=list({})

    for tag in glob_settings:
        find_acceptable_windows_by_class(tag, wlist)
        print_tagged_info(tag)

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

def add_acceptable(self, event):
    cw=cycle_window.instance()
    con = event.container
    for tag in glob_settings:
        if con.window_class in glob_settings[tag]["classes"]:
            cw.tagged[tag].append({ 'win':con, 'focused':con.focused })

def del_acceptable(self, event):
    cw=cycle_window.instance()
    con = event.container
    for tag in glob_settings:
        if con.window_class in glob_settings[tag]["classes"]:
            del cw.tagged[tag]

# handle events, do not try to do it from the one script
if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    if argv["daemon"]:
        find_all()

        i3.on('window::new', add_acceptable)
        i3.on('window::close', del_acceptable)

        mainloop=Thread(target=mainloop_cycle).start()

        i3.main()
