#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  i3_ns.py show <name>
  i3_ns.py hide <name>
  i3_ns.py toggle <name>
  i3_ns.py next <name>
  i3_ns.py daemon
  i3_ns.py (-h | --help)
  i3_ns.py --version
  i3_ns.py --debug

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

import i3ipc
import i3 as i3hl

from sys import exit
from itertools import cycle
from subprocess import check_output

import uuid
import re
from docopt import docopt

import redis

from ns_config import *

class named_scratchpad(object):
    def __init__(self):
        self.debug=0
        self.settings=ns_settings().settings
        self.ns_data=ns_settings().ns_data
        self.group_list=ns_settings().group_list

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
        return 'mark {}'.format(group) + str(str(uuid.uuid4().fields[-1]))

    def focus(self, gr):
        handle_marked_group(gr)
        self.dprint(self.strwrap("ALL"))
        for j,i in zip(range(len(window_list)), sorted(window_list, key=lambda im: im.name)):
            self.dprint(i.name, i.id)

        self.dprint(self.strwrap("IM"))
        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            self.marked[j].command('move container to workspace current')

    def toggle(self, gr):
        handle_marked_group(gr)
        focused = i3.get_tree().find_focused()
        if self.visible() > 0:
            self.unfocus()
            return

        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            if focused.id == i.id:
                self.unfocus()
                return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            with open(ns_data, "w") as f:
                f.write("%s\n" % focused.id)

        self.focus()

    def restore_fullscreens(self, gr):
        handle_marked_group(gr)
        with open(ns_data, "r") as f:
            for line in f:
                fullscreen_me=line

        for i in i3.get_tree().leaves():
            if i.id == int(fullscreen_me):
                i.command('fullscreen toggle')
        with open(ns_data, "w") as f:
            f.write("")


    def unfocus(self, gr):
        handle_marked_group(gr)
        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            self.marked[j].command('move scratchpad')

        restore_fullscreens()

    def get_windows_on_ws(self,i3):
        return filter(lambda x: x.window, i3.get_tree().find_focused().workspace().descendents())

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
        handle_marked_group(gr)
        focused = i3.get_tree().find_focused()
        self.focus()
        for j,i in zip(range(len(self.marked)),sorted(self.marked, key=lambda im: im.name)):
            self.dprint(i.name, i.id)
            self.dprint("focused id=",focused.id)
            if focused.id != i.id:
                self.marked[j].command('move container to workspace current')
                i.command('move scratchpad')
        self.focus()

    def visible(self):
        visible_windows = self.find_visible_windows(self.get_windows_on_ws(i3))

        self.dprint("Visible and marked")
        vmarked = 0
        for w in visible_windows:
            for i in sorted(marked, key=lambda im: im.name):
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

    def handle_marked_group(group):
        self.marked=i3.get_tree().find_marked(group+"[0-9]+")
        if self.marked == [] and "prog" in ns.settings[group]:
            i3.command("exec {}".format(ns.settings[group]["prog"]))

class Singleton(named_scratchpad):
    def __init__(self):
        named_scratchpad.__init__(self)
    def __str__(self):
        return self.val

def mark_group(self, event):
    ns=Singleton()
    for group in ns.group_list:
        print("group={}",group)
        con = event.container
        if con.window_class in ns.settings[group]["classes"]:
            con.command
            scratch_cmd='move scratchpad, '+ns.parse_geom(group)
            con.command(scratch_cmd)
            print(ns.make_mark(group))

        try:
            if con.window_class in ns.settings[group]["instances"]:
                con.command(make_mark())
                scratch_cmd='move scratchpad, '+ns.parse_geom(group)
                con.command(scratch_cmd)
                print(ns.make_mark(group))
        except KeyError:
            return

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    ns=Singleton()
    i3 = i3ipc.Connection()
    window_list = i3.get_tree().leaves()
    marks=i3hl.get_marks()

    if argv["daemon"]:
        i3.on('window::new', mark_group)
        i3.main()
