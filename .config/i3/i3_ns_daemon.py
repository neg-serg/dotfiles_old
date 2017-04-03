#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  i3_ns_daemon.py show <name>
  i3_ns_daemon.py hide <name>
  i3_ns_daemon.py toggle <name>
  i3_ns_daemon.py next <name>
  i3_ns_daemon.py d
  i3_ns_daemon.py (-h | --help)
  i3_ns_daemon.py --version

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

def dprint(*args):
    if debug():
        print(*args)

def debug():
    return 0

def strwrap(s):
    return "[-- " + s + " --]"

settings=ns_settings().settings
ns_data=ns_settings().ns_data
group_list=ns_settings().group_list

class named_scratchpad(object):

    def parse_geom(self):
        geom={}
        geom=re.split(r'[x+]', settings[self.group]["geom"])
        return "move absolute position {2} {3}, resize set {0} {1}".format(*geom)

    def make_mark(self):
        return 'mark {}'.format(self.group) + str(str(uuid.uuid4().fields[-1]))

    def mark_group(self, event):
        con = event.container
        if con.window_class in settings[self.group]["classes"]:
            con.command(make_mark())
            scratch_cmd='move scratchpad, '+parse_geom()
            con.command(scratch_cmd)
            print(make_mark())

        try:
            if con.window_class in settings[self.group]["instances"]:
                con.command(make_mark())
                scratch_cmd='move scratchpad, '+parse_geom()
                con.command(scratch_cmd)
                print(make_mark())
        except KeyError:
            return

    def focus(self, group):
        if self.marked == [] and "prog" in settings[group]:
            i3.command("exec {}".format(settings[group]["prog"]))
        dprint(strwrap("ALL"))
        for j,i in zip(range(len(self.window_list)), sorted(self.window_list, key=lambda im: im.name)):
            dprint(i.name, i.id)

        dprint(strwrap("IM"))
        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            dprint(i.name, i.id)
            self.marked[j].command('move container to workspace current')

    def toggle(self):
        focused = i3.get_tree().find_focused()
        if self.visible() > 0:
            self.unfocus()
            return

        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            dprint(i.name, i.id)
            if focused.id == i.id:
                self.unfocus()
                return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            with open(ns_data, "w") as f:
                f.write("%s\n" % focused.id)

        self.focus()

    def restore_fullscreens(self):
        with open(ns_data, "r") as f:
            for line in f:
                fullscreen_me=line

        for i in i3.get_tree().leaves():
            if i.id == int(fullscreen_me):
                i.command('fullscreen toggle')
        with open(ns_data, "w") as f:
            f.write("")


    def unfocus(self):
        for j,i in zip(range(len(self.marked)), sorted(self.marked, key=lambda im: im.name)):
            dprint(i.name, i.id)
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


    def iterate_over(self):
        focused = i3.get_tree().find_focused()
        self.focus()
        for j,i in zip(range(len(self.marked)),sorted(self.marked, key=lambda im: im.name)):
            dprint(i.name, i.id)
            dprint("focused id=",focused.id)
            if focused.id != i.id:
                self.marked[j].command('move container to workspace current')
                i.command('move scratchpad')
        self.focus()

    def visible(self):
        visible_windows = self.find_visible_windows(self.get_windows_on_ws(i3))

        dprint("Visible and marked")
        vmarked = 0
        for w in visible_windows:
            for i in sorted(self.marked, key=lambda im: im.name):
                if w.id == i.id:
                    if debug():
                        print("{name,id}=", i.name, i.id)
                        print("name=", w.name)
                    vmarked+=1

        return vmarked

    def scratch_list(self):
        v=[]
        for i in settings:
            v.append(i)
        return v

    def print_info(self):
        v=scratch_list()
        print(v)

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    def main(group):
        i3 = i3ipc.Connection()

        ns=named_scratchpad()

        ns.window_list = i3.get_tree().leaves()
        ns.marked=i3.get_tree().find_marked(group+"[0-9]+")

        marks=i3hl.get_marks()

        for group in group_list:
            i3.on('window::new', group)

        i3.main()

    main(argv["<name>"])
