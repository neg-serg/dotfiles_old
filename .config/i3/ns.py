#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  ns.py daemon

Options:
  -h --help     Show this screen.
  --version     Show version.

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2017

"""

import i3ipc

from sys import exit
from subprocess import check_output
from docopt import docopt
from ns_config import *

from queue import Queue
from threading import Thread
from singleton_mixin import *

import uuid
import re
import errno
import os

q = Queue()
glob_settings=ns_settings().settings
marked={}

for i in glob_settings:
    marked[i]=list()

class named_scratchpad(SingletonMixin):
    def __init__(self):
        self.settings=ns_settings().settings
        self.group_list=[]
        self.fullscreen_list=[]

        for group in self.settings:
            self.group_list.append(group)

        self.ns_data="/tmp/ns_data"

    def strwrap(self, s):
        return "[-- " + s + " --]"

    def parse_geom(self, group):
        geom={}
        geom=re.split(r'[x+]', self.settings[group]["geom"])
        return "move absolute position {2} {3}, resize set {0} {1}".format(*geom)

    def make_mark(self, group):
        output=(group) + str(str(uuid.uuid4().fields[-1]))
        return 'mark {}'.format(output)

    def focus(self, gr):
        for j,i in zip(range(len(marked[gr])), sorted(marked[gr], key=lambda im: im.name)):
            marked[gr][j].command('move container to workspace current')

    def toggle(self, gr):
        if marked[gr] == [] and "prog" in self.settings[gr]:
            i3.command("exec {}".format(self.settings[gr]["prog"]))

        focused = i3.get_tree().find_focused()
        if self.visible(gr) > 0:
            self.unfocus(gr)
            return

        for j,i in zip(range(len(marked[gr])), sorted(marked[gr], key=lambda im: im.name)):
            if focused.id == i.id:
                self.unfocus(gr)
                return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(gr)

    def restore_fullscreens(self, gr):
        for i in self.fullscreen_list:
            i.command('fullscreen toggle')

        self.fullscreen_list=[]

    def unfocus(self, gr):
        for j,i in zip(
                range(len(marked[gr])),
                sorted(marked[gr], key=lambda im: im.name)
            ):
            marked[gr][j].command('move scratchpad')

        self.restore_fullscreens(gr)

    def get_windows_on_ws(self,i3):
        return filter(
            lambda x: x.window,
            i3.get_tree()
                .find_focused()
                .workspace()
                .descendents()
        )

    def find_visible_windows(self, windows_on_workspace):
        visible_windows = []
        for w in windows_on_workspace:
            try:
                xprop = check_output(['xprop', '-id', str(w.window)]).decode()
            except FileNotFoundError:
                raise SystemExit("The `xprop` utility is not found!"
                                " Please install it and retry.")

            if '_NET_WM_STATE_HIDDEN' not in xprop:
                visible_windows.append(w)

        return visible_windows

    def iterate_over(self, gr):
        focused = i3.get_tree().find_focused()
        self.focus(gr)
        for j,i in zip(
            range(len(marked[gr])),
            sorted(marked[gr], key=lambda im: im.name)):

            if focused.id != i.id:
                marked[gr][j].command('move container to workspace current')
                i.command('move scratchpad')
        self.focus(gr)

    def visible(self, gr):
        visible_windows = self.find_visible_windows(self.get_windows_on_ws(i3))
        vmarked = 0
        for w in visible_windows:
            for i in sorted(marked[gr], key=lambda im: im.name):
                if w.id == i.id:
                    vmarked+=1

        return vmarked

    def scratch_list(self):
        v=[]
        for i in self.settings:
            v.append(i)
        return v

    def print_info(self):
        v=scratch_list()
        print(v)

def mark_group(self, event):
    def scratch_move():
        con.command(ns.make_mark(group))
        scratch_cmd='move scratchpad, '+ns.parse_geom(group)
        con.command(scratch_cmd)
        marked[group].append(con)

    def check_class():
        return bool(con.window_class in ns.settings[group]["classes"])

    def check_instance():
        return bool(con.window_instance in ns.settings[group]["instances"])

    for group in glob_settings:
        ns=named_scratchpad.instance()
        con = event.container
        try:
            if check_class() or check_instance():
                scratch_move()
        except KeyError:
            pass

fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/ns_scratchpad.fifo'))
if os.path.exists(fifo_):
    os.remove(fifo_)

try:
    os.mkfifo(fifo_)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def fifo_listner():
    ns=named_scratchpad.instance()
    with open(fifo_) as fifo:
        while True:
            data = fifo.read()
            if len(data) == 0:
                break
            eval_str=data.split('\n', 1)[0]
            args=list(filter(lambda x: x != '', eval_str.split(' ')))
            if len(args) > 0:
                if args[0] == "show":
                    ns.focus(args[1])
                elif args[0] == "hide":
                    ns.unfocus(args[1])
                elif args[0] == "toggle":
                    ns.toggle(args[1])
                elif args[0] == "next":
                    ns.iterate_over(args[1])

def worker():
    while True:
        if q.empty():
            exit()
        i = q.get()
        q.task_done()

def mainloop_ns():
    while True:
        q.put(fifo_listner())
        Thread(target=worker).start()

def mark_all(hide):
    def scratch_move(by):
        con.command(ns.make_mark(group))

        if not hide:
            suff=''
        else:
            if by == "class":
                suff=', [con_id=__focused__ {}={}] scratchpad show'.format(by,con.window_class)
            elif by == "instance":
                suff=', [con_id=__focused__ {}={}] scratchpad show'.format(by,con.window_instance)

        scratch_cmd='move scratchpad, '+ns.parse_geom(group)+suff
        con.command(scratch_cmd)
        marked[group].append(con)

    def check_class():
        return bool(con.window_class in ns.settings[group]["classes"])

    def check_instance():
        return bool(con.window_instance in ns.settings[group]["instances"])

    window_list = i3.get_tree().leaves()
    for group in glob_settings:
        ns=named_scratchpad.instance()
        for con in window_list:
            try:
                if check_class():
                    scratch_move(by="class")
                    return
                if check_instance():
                    scratch_move(by="instance")
                    return
            except KeyError:
                pass

def cleanup_mark(self, event):
    for i in glob_settings:
        marked[i]=list()
    mark_all(hide=False)

def cleanup_all():
    if os.path.exists(fifo_):
        os.remove(fifo_)

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    i3 = i3ipc.Connection()

    import atexit
    atexit.register(cleanup_all)

    ns=named_scratchpad.instance()

    if argv["daemon"]:
        mark_all(hide=True)

        i3.on('window::new', mark_group)
        i3.on('window::close', cleanup_mark)

        mainloop=Thread(target=mainloop_ns).start()

        i3.main()
