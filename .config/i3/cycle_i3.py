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
    tagged[i]=list({})

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
    def go_next(self, tag):
        print_tagged_info(tag)
        if tagged[tag] == []:
            prog=glob_settings[tag]["prog"]
            i3.command('exec {}'.format(prog))
        else:
            return
            # for iter in tagged[tag]:
            #     if iter['focused'] == False:
            #         counter+=1
            # if counter == len(tagged[tag]):
            #     tagged[tag][0]['win'].command('focus')
            #     tagged[tag][0]['focused']=True
            #     counter=0

def fullscreen_handle():
    if tagged[tag]['win'].fullscreen_mode != False:
        tagged[tag]['win'].command('fullscreen disable')

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
            tagged[tag].append(
                {
                    'win':cur,
                    'focused':cur.focused
                }
            )

def print_tagged_info(tag):
    print("tagged={}".format(tagged))
    for i in tagged[tag]:
        print("tagged[tag]={}".format(i))

def find_all():
    wlist = i3.get_tree().leaves()
    for tag in glob_settings:
        find_acceptable_windows_by_class(tag, wlist)
        print_tagged_info(tag)

def handle_focused(self, event):
    con = event.container
    return

def handle_unfocused(self, event):
    con = event.container
    return

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

def add_acceptable(self, event):
    con = event.container
    for tag in glob_settings:
        if con.window_class in glob_settings[tag]["classes"]:
            tagged[tag]['win'].append(con, con.focused)

# handle events, do not try to do it from the one script
if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    if argv["daemon"]:
        find_all()
        i3.on('window::new', add_acceptable)
        i3.on('window::focus', handle_focused)
        i3.on('window::unfocus', handle_unfocused)
        mainloop=Thread(target=mainloop_cycle).start()
        i3.main()
