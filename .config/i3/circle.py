#!/usr/bin/env python3

""" i3 window tag circle
Usage:
    circle.py daemon

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2017

"""

import i3ipc
import re
import errno
import os

from queue import Queue
from sys import exit
from docopt import docopt
from cycle_settings import *
from singleton_mixin import *
from threading import Thread, enumerate

glob_settings=cycle_settings().settings
q = Queue()

class cycle_window(SingletonMixin):
    def __init__(self):
        self.tagged={}
        self.counters={}
        self.to_be_restored=None
        self.restore_now=True
        for i in glob_settings:
            self.tagged[i]=list({})
            self.counters[i]=0

    def go_next(self, tag):
        def tag_conf():
            return glob_settings[tag]

        def cur_win():
            return self.current_win

        def cur_win_in_current_class_set():
            tag_classes_set=set(glob_settings[tag]["classes"])
            return bool(cur_win().window_class in tag_classes_set)

        def current_class_in_priority():
            if not cur_win_in_current_class_set():
                return bool(cur_win() == tag_conf()["priority"])
            else:
                return True

        def is_priority_attr():
            return bool("priority" in tag_conf())

        def class_eq_priority():
            return bool(item['win'].window_class == tag_conf()["priority"])

        def inc_c():
            self.counters[tag]+=1

        def target_i():
            return self.tagged[tag][target_]

        def go_next_(inc_counter=True):
            self.restore_now=True

            for con in i3.get_tree().find_fullscreen():
                if con.id == cur_win().id and cur_win_in_current_class_set():
                    self.to_be_restored=con
                    self.to_be_restored.command('fullscreen disable')
                    self.restore_now=False

            target_i()['win'].command('focus')
            target_i()['focused']=True

            if inc_counter:
                inc_c()

            if not (self.to_be_restored is None) and self.restore_now:
                self.to_be_restored.command('fullscreen enable')
                self.to_be_restored=None

        def go_to_not_repeat():
            inc_c()
            self.go_next(tag)

        try:
            if len(self.tagged[tag]) == 0:
                if "prog" in tag_conf():
                    prog=tag_conf()["prog"]
                    i3.command('exec {}'.format(prog))
                else:
                    return
            elif len(self.tagged[tag]) == 1:
                target_=0
                go_next_()
            else:
                target_=self.counters[tag] % len(self.tagged[tag])

                if is_priority_attr() and not current_class_in_priority():
                    for target_,item in zip(range(len(self.tagged[tag])),self.tagged[tag]):
                        if class_eq_priority():
                            go_next_(inc_counter=False); return
                elif self.current_win.id == target_i()['win'].id:
                    go_to_not_repeat()
                else:
                    go_next_()
        except KeyError:
            invalidate_tags_info()
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
        if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
            cw.tagged[tag].append({ 'win':con, 'focused':False })
        elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
            cw.tagged[tag].append({ 'win':con, 'focused':False })

def print_tagged_info(tag):
    cw=cycle_window.instance()
    for win in cw.tagged[tag]:
        print("tagged[{}]={}~{}".format(tag,win['win'].name,win['focused']))

def invalidate_tags_info():
    cw=cycle_window.instance()
    wlist = i3.get_tree().leaves()
    cw.tagged={}

    for i in glob_settings:
        cw.tagged[i]=list({})

    for tag in glob_settings:
        find_acceptable_windows_by_class(tag, wlist)

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

def add_acceptable(self, event):
    def add_tagged_win():
        cw.tagged[tag].append({'win':con,'focused':con.focused})

    cw=cycle_window.instance()
    con = event.container
    for tag in glob_settings:
        try:
            if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                add_tagged_win()
            elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                add_tagged_win()
        except KeyError:
            invalidate_tags_info()
            add_acceptable(self, event)

def del_acceptable(self, event):
    def del_tagged_win():
        del cw.tagged[tag]

    cw=cycle_window.instance()
    con = event.container
    for tag in glob_settings:
        try:
            if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                del_tagged_win()
            elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                del_tagged_win()
        except KeyError:
            invalidate_tags_info()
            del_acceptable(self, event)

def save_current_win(self,event):
    con=event.container
    cw=cycle_window.instance()
    cw.current_win=con

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 window tag circle 0.5')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    if argv["daemon"]:
        cw=cycle_window.instance()
        cw.current_win=i3.get_tree().find_focused()
        invalidate_tags_info()

        i3.on('window::new', add_acceptable)
        i3.on('window::close', del_acceptable)
        i3.on("window::focus", save_current_win)

        mainloop=Thread(target=mainloop_cycle).start()

        i3.main()
