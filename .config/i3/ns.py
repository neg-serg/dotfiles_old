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

from docopt import docopt
from ns_config import *

from threading import Thread
from singleton_mixin import *
from script_i3_general import *

import uuid
import re
import errno
import os

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
        for j,i in zip(
                range(len(marked[gr])),
                marked[gr]
            ):
            marked[gr][j].command('move container to workspace current')

    def toggle(self, gr):
        if marked[gr] == [] and "prog" in settings_[gr]:
            i3.command("exec {}".format(settings_[gr]["prog"]))

        # We need to hide scratchpad it is visible, regardless it focused or not
        focused = i3.get_tree().find_focused()

        if self.visible(gr) > 0:
            self.unfocus(gr); return

        for i in marked[gr]:
            if focused.id == i.id:
                self.unfocus(gr); return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(gr)

    def unfocus(self, gr):
        def restore_fullscreens():
            [i.command('fullscreen toggle') for i in self.fullscreen_list]
            self.fullscreen_list=[]

        for j,i in zip(
                range(len(marked[gr])),
                marked[gr]
            ):
            marked[gr][j].command('move scratchpad')
        restore_fullscreens()

    def visible(self, gr):
        visible_windows = find_visible_windows(get_windows_on_ws())
        vmarked = 0
        for w in visible_windows:
            for i in marked[gr]:
                if w.id == i.id:
                    vmarked+=1
        return vmarked

    def apply_to_current_group(self, func):
        def get_current_group(self,focused):
            for group in settings_:
                for i in marked[group]:
                    if focused.id == i.id:
                        return group

        curr_group=get_current_group(self,i3.get_tree().find_focused())
        if curr_group  != None:
            func(curr_group)

    def next_win(self):
        focused_=i3.get_tree().find_focused()

        def next_win_(group):
            self.focus(group)
            for number,win in zip(
                    range(len(marked[group])),
                    marked[group]
                ):
                if focused_.id != win.id:
                    marked[group][number].command('move container to workspace current')
                    marked[group].insert(len(marked[group]), marked[group].pop(number))
                    win.command('move scratchpad')
            self.focus(group)

        self.apply_to_current_group(next_win_)

    def hide_current(self):
        self.apply_to_current_group(self.unfocus)

    def switch(self, args):
        switch_ = {
            "show": self.focus,
            "hide": self.unfocus,
            "next": self.next_win,
            "toggle": self.toggle,
            "hide_current": self.hide_current,
        }

        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

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
            if check_class():    scratch_move(by="class")
            if check_instance(): scratch_move(by="instance")
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
                if check_class():    scratch_move(by="class")
                if check_instance(): scratch_move(by="instance")
            except KeyError:
                pass

def cleanup_mark(self, event):
    for tag in settings_:
        for j,win in zip(range(len(marked[tag])),marked[tag]):
            if win.id == event.container.id:
                del marked[tag][j]

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    if argv["daemon"]:
        i3 = i3ipc.Connection()
        name='ns_scratchd'

        mng=daemon_manager.instance()
        mng.add_daemon(name)

        def cleanup_all():
            daemon_=mng.daemons[name]
            if os.path.exists(daemon_.fifo_):
                os.remove(daemon_.fifo_)

        import atexit
        atexit.register(cleanup_all)

        ns=named_scratchpad.instance()
        mark_all(hide=True)

        i3.on('window::new', mark_group)
        i3.on('window::close', cleanup_mark)
        mainloop=Thread(target=mng.daemons[name].mainloop, args=(ns,)).start()
        i3.main()
