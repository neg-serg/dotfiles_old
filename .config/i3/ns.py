#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  i3_ns.py daemon
  i3_ns.py toggle <name>


Options:
  -h --help     Show this screen.
  --version     Show version.

"""

import i3ipc
import i3 as i3hl

from sys import exit
from itertools import cycle
from subprocess import check_output
from docopt import docopt
from ns_config import *

from time import sleep
from queue import *
from threading import Thread, enumerate, Lock

import uuid
import re
import errno
import os
import redis

glob_settings=ns_settings().settings
marked={'im':[], 'ncmpcpp':[], 'mutt':[], 'ranger':[], 'teardrop':[] }

# Based on tornado.ioloop.IOLoop.instance() approach.
# See https://github.com/facebook/tornado
class SingletonMixin(object):
    __singleton_lock = Lock()
    __singleton_instance = None

    @classmethod
    def instance(cls):
        if not cls.__singleton_instance:
            with cls.__singleton_lock:
                if not cls.__singleton_instance:
                    cls.__singleton_instance = cls()
        return cls.__singleton_instance

class named_scratchpad(SingletonMixin):
    def __init__(self):
        self.debug=0
        self.settings=ns_settings().settings
        self.group_list=[]

        for group in self.settings:
            self.group_list.append(group)

        self.ns_data="/tmp/ns_data"

    def dprint(self, *args):
        if self.debug:
            print(*args)

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
        self.dprint(self.strwrap("ALL"))
        for j,i in zip(range(len(window_list)), sorted(window_list, key=lambda im: im.name)):
            self.dprint(i.name, i.id)

        self.dprint(self.strwrap("IM"))
        for j,i in zip(range(len(marked[gr])), sorted(marked[gr], key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            marked[gr][j].command('move container to workspace current')

    def toggle(self, gr):
        focused = i3.get_tree().find_focused()
        if self.visible(gr) > 0:
            self.unfocus(gr)
            return

        for j,i in zip(range(len(marked[gr])), sorted(marked[gr], key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            if focused.id == i.id:
                self.unfocus(gr)
                return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            with open(self.ns_data, "w") as f:
                f.write("%s\n" % focused.id)

        self.focus(gr)

    # def restore_fullscreens(self, gr):
    #     fullscreen_me=""
    #     with open(self.ns_data, "r") as f:
    #         for line in f:
    #             fullscreen_me=line

    #     for i in i3.get_tree().leaves():
    #         if i.id == int(fullscreen_me):
    #             i.command('fullscreen toggle')
    #     with open(self.ns_data, "w") as f:
    #         f.write("")

    def unfocus(self, gr):
        for j,i in zip(
                range(len(marked[gr])),
                sorted(marked[gr], key=lambda im: im.name)
            ):
            self.dprint(i.name, i.id)
            marked[gr][j].command('move scratchpad')

        # self.restore_fullscreens(gr)

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

            self.dprint(i.name, i.id)
            self.dprint("focused id=",focused.id)
            if focused.id != i.id:
                marked[gr][j].command('move container to workspace current')
                i.command('move scratchpad')
        self.focus(gr)

    def visible(self, gr):
        visible_windows = self.find_visible_windows(self.get_windows_on_ws(i3))

        self.dprint("Visible and marked")
        vmarked = 0
        for w in visible_windows:
            for i in sorted(marked[gr], key=lambda im: im.name):
                if w.id == i.id:
                    if self.debug:
                        print("{name,id}=", i.name, i.id)
                        print("name=", w.name)
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
    for group in glob_settings:
        ns=named_scratchpad.instance()
        con = event.container
        if con.window_class in ns.settings[group]["classes"]:
            con.command
            scratch_cmd='move scratchpad, '+ns.parse_geom(group)
            con.command(scratch_cmd)
            print(ns.make_mark(group))

            marked[group].append(con)
            print("marked={}".format(marked))

        try:
            if con.window_class in ns.settings[group]["instances"]:
                con.command(make_mark())
                scratch_cmd='move scratchpad, '+ns.parse_geom(group)
                con.command(scratch_cmd)
                print(ns.make_mark(group))

                marked[group].append(con)
                print("marked={}".format(marked))
        except KeyError:
            return

FIFO = '/tmp/ns_scratchpad.fifo'

try:
    os.mkfifo(FIFO)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def fifo_listner():
    ns=named_scratchpad.instance()
    print("Opening FIFO...")
    with open(FIFO) as fifo:
        print("FIFO opened")
        while True:
            data = fifo.read()
            if len(data) == 0:
                print("Writer closed")
                break
            print('Read: "{0}"'.format(data))
            eval(data)

q = Queue()

def put():
    q.put(fifo_listner())

def worker():
    while True:
        if q.empty():
            exit()
        i = q.get()
        q.task_done()

def before_i3_main():
    sleep(2)
    while True:
        put()
        Thread(target=worker).start()
        sleep(0.2)

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    ns=named_scratchpad.instance()

    i3 = i3ipc.Connection()
    window_list = i3.get_tree().leaves()
    marks=i3hl.get_marks()

    red = redis.StrictRedis(host='localhost', port=6379, db=0)

    if argv["daemon"]:
        i3.on('window::new', mark_group)
        Thread(target=before_i3_main).start()
        i3.main()
