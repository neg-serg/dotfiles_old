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
settings_=ns_settings().settings
marked={i:[] for i in settings_}

class named_scratchpad(SingletonMixin):
    def __init__(self):
        self.group_list=[]
        self.fullscreen_list=[]
        [self.group_list.append(gr) for gr in settings_]

    def parse_geom(self, group):
        geom=re.split(r'[x+]', settings_[group]["geom"])
        return "move absolute position {2} {3}, resize set {0} {1}".format(*geom)

    def make_mark(self, group):
        output=(group) + str(str(uuid.uuid4().fields[-1]))
        return 'mark {}'.format(output)

    def focus(self, gr):
        for j,i in zip(range(len(marked[gr])), sorted(marked[gr], key=lambda im: im.name)):
            marked[gr][j].command('move container to workspace current')

    def toggle(self, gr):
        if marked[gr] == [] and "prog" in settings_[gr]:
            i3.command("exec {}".format(settings_[gr]["prog"]))

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
        [i.command('fullscreen toggle') for i in self.fullscreen_list]
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

    def iterate_over(self, group):
        focused = i3.get_tree().find_focused()
        self.focus(group)
        for number,win in zip(
                range(len(marked[group])),
                sorted(marked[group], key=lambda im: im.name)
            ):
            if focused.id != win.id:
                marked[group][number].command('move container to workspace current')
                win.command('move scratchpad')
        self.focus(group)

    def visible(self, gr):
        visible_windows = self.find_visible_windows(self.get_windows_on_ws(i3))
        vmarked = 0
        for w in visible_windows:
            for i in sorted(marked[gr], key=lambda im: im.name):
                if w.id == i.id:
                    vmarked+=1
        return vmarked

    def hide_current(self):
        focused = i3.get_tree().find_focused()
        for group in settings_:
            for i in sorted(marked[group], key=lambda im: im.name):
                if focused.id == i.id:
                    self.unfocus(group)
                    return

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
            switch = {
                "show": ns.focus,
                "hide": ns.unfocus,
                "next": ns.iterate_over,
                "toggle": ns.toggle,
                "hide_current": ns.hide_current,
            }
            if len(args) == 2:
                switch[args[0]](args[1])
            elif len(args) == 1:
                switch[args[0]]()

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

def mark_group(self, event):
    def scratch_move(by):
        con.command(ns.make_mark(group)+', move scratchpad,'+ns.parse_geom(group))
        marked[group].append(con)

    def check_class():
        return bool(con.window_class in settings_[group]["classes"])

    def check_instance():
        return bool(con.window_instance in settings_[group]["instances"])

    for group in settings_:
        ns=named_scratchpad.instance()
        con=event.container
        try:
            if check_class():
                scratch_move(by="class")
                return
            if check_instance():
                scratch_move(by="instance")
                return
        except KeyError:
            pass

def mark_all(hide=True):
    def scratch_move(by):
        if hide:
            hide_cmd=', [con_id=__focused__] scratchpad show'
        else:
            hide_cmd=''
        con.command(ns.make_mark(group)+', move scratchpad,'+ns.parse_geom(group)+hide_cmd)
        marked[group].append(con)

    def check_class():
        return bool(con.window_class in settings_[group]["classes"])

    def check_instance():
        return bool(con.window_instance in settings_[group]["instances"])

    window_list = i3.get_tree().leaves()
    for group in settings_:
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
    for tag in settings_:
        for j,win in zip(range(len(marked[tag])),marked[tag]):
            if win.id == event.container.id:
                del marked[tag][j]

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
