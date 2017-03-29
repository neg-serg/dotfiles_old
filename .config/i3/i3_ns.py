#!/usr/bin/python3

import i3ipc
import i3 as i3hl

from sys import argv
from sys import exit
from itertools import cycle
from subprocess import check_output

import uuid
import re

settings = {
    'im' : {
        'classes' : {
            'TelegramDesktop',
            'Telegram-desktop',
            'telegram-desktop',
            'skypeforlinux',
            'ViberPC',
            'finch',
        },
        'geom' : "528x1029+1372+127"
    },
    'ncmpcpp': {
        'classes' : { 'mpd-pad2' },
        'geom' : "1200x600+400+400",
        'prog': 'st -f "PragmataPro for Powerline:pixelsize=18" -c mpd-pad2 -e ncmpcpp'
    },
    'mutt': {
        'classes' : { '' },
        'instances' : { 'mutt' },
        'geom' : "1250x700+293+0",
        'prog' : "st -f \'PragmataPro for Powerline:size=12\' -c mutt -e mutt",
    },
    'ranger': {
        'classes' : { 'ranger' },
        'geom' : "1132x760+170+18",
        'prog' : "~/bin/scripts/run_ranger"
    },
    'teardrop': {
        'classes' : { 'teardrop' },
        'geom' : "1823x489+38+0",
        'prog' : "st -c teardrop -f \'PragmataPro for Powerline:size=10\' -e ~/bin/scripts/teardrop"
    }
}

ns_data="/tmp/ns_data"

def parse_geom():
    geom={}
    geom=re.split(r'[x+]', settings[group]["geom"])
    return "move absolute position {2} {3}, resize set {0} {1}".format(*geom)

def make_mark():
    return 'mark {}'.format(group) + str(str(uuid.uuid4().fields[-1]))

def mark_group(self, event):
    global settings
    global group

    con = event.container
    if con.window_class in settings[group]["classes"]:
        con.command(make_mark())
        scratch_cmd='move scratchpad, '+parse_geom()
        con.command(scratch_cmd)
        print(make_mark())

    try:
        if con.window_class in settings[group]["instances"]:
            con.command(make_mark())
            scratch_cmd='move scratchpad, '+parse_geom()
            con.command(scratch_cmd)
            print(make_mark())
    except KeyError:
        return

def debug():
    return 1

def dprint(*args):
    if debug():
        print(*args)

def strwrap(s):
    return "[-- " + s + " --]"

def focus():
    dprint(strwrap("ALL"))
    for j,i in zip(range(len(window_list)), sorted(window_list, key=lambda im: im.name)):
        dprint(i.name, i.id)

    dprint(strwrap("IM"))
    for j,i in zip(range(len(marked)), sorted(marked, key=lambda im: im.name)):
        dprint(i.name, i.id)
        marked[j].command('move container to workspace current')

def toggle():
    focused = i3.get_tree().find_focused()
    if visible() > 0:
        unfocus()
        return

    for j,i in zip(range(len(marked)), sorted(marked, key=lambda im: im.name)):
        dprint(i.name, i.id)
        if focused.id == i.id:
            unfocus()
            return

    if focused.fullscreen_mode:
        focused.command('fullscreen toggle')
        with open(ns_data, "w") as f:
            f.write("%s\n" % focused.id)

    focus()

def restore_fullscreens():
    with open(ns_data, "r") as f:
        for line in f:
            fullscreen_me=line

    for i in i3.get_tree().leaves():
        if i.id == int(fullscreen_me):
            i.command('fullscreen toggle')
    with open(ns_data, "w") as f:
        f.write("")


def unfocus():
    for j,i in zip(range(len(marked)), sorted(marked, key=lambda im: im.name)):
        dprint(i.name, i.id)
        marked[j].command('move scratchpad')

    restore_fullscreens()

def get_windows_on_ws(i3):
   return filter(lambda x: x.window, i3.get_tree().find_focused().workspace().descendents())

def find_visible_windows(windows_on_workspace):
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


def iterate_over():
    focused = i3.get_tree().find_focused()
    focus()
    for j,i in zip(range(len(marked)),sorted(marked, key=lambda im: im.name)):
        dprint(i.name, i.id)
        dprint("focused id=",focused.id)
        if focused.id != i.id:
            marked[j].command('move container to workspace current')
            i.command('move scratchpad')
    focus()

def visible():
    visible_windows = find_visible_windows(get_windows_on_ws(i3))

    dprint("Visible and marked")
    vmarked = 0
    for w in visible_windows:
        for i in sorted(marked, key=lambda im: im.name):
            if w.id == i.id:
                if debug():
                    print("{name,id}=", i.name, i.id)
                    print("name=", w.name)
                vmarked+=1

    return vmarked

def scratch_list():
    v=[]
    for i in settings:
        v.append(i)
    return v

def print_info():
    v=scratch_list()
    print(v)

#------------------------------------------------
if __name__ == '__main__':
    if len(argv) < 3:
        exit('Usage: %s'  % argv[0])
    else:
        i3 = i3ipc.Connection()
        window_list = i3.get_tree().leaves()
        group=argv[1]
        marked=i3.get_tree().find_marked(group+"[0-9]+")
        if marked == [] and "prog" in settings[group]:
            i3.command("exec {}".format(settings[group]["prog"]))
        marks=i3hl.get_marks()

        if argv[2] == "show":
            focus()
        elif argv[2] == "hide":
            unfocus()
        elif argv[2] == "toggle":
            toggle()
        elif argv[2] == "next":
            iterate_over()
        elif argv[2] == "d":
            print_info()
        elif argv[2] == "marker":
            i3.on('window::new', mark_group)
            dprint("::My marks::")
            for i in marks:
                dprint(i)
            i3.main()
#------------------------------------------------
