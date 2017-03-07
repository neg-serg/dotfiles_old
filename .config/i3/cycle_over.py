#!/usr/bin/python3

import i3ipc
import i3 as i3hl

from sys import argv
from sys import exit

import uuid
import re

settings = {
    'web' : {
        'classes' : {
            'Firefox',
            'Navigator',
            'Tor Browser',
        },
        'prog':"firefox",
    }
}

def debug():
    return 1

def dprint(*args):
    if debug():
        print(*args)

def strwrap(s):
    return "[-- " + s + " --]"

def cycle_next():
    tw=find_acceptable_windows_by_class()
    # if no such window do run
    if tw == []:
        dprint("No such window, run")
        prog=settings[tag]["prog"]
        i3.command('exec {}'.format(prog))
    else:
        for j,i in zip(range(len(tw)), tw):
            cur=tw[j]
            if not cur.window_class == i3.get_tree().find_focused().window_class:
                dprint(i.name)
                cur.command('focus')
            else:
                dprint("[x]"+tw[j+1].name)
                tw[j+1].command('focus')
            return

def find_acceptable_windows_by_class():
    tagged_windows=[]
    for j,i in zip(range(len(window_list)), window_list):
        cur=window_list[j]
        if cur.window_class in settings[tag]["classes"]:
            tagged_windows.append(cur)

    return sorted(tagged_windows, key=lambda w:w.name)

if __name__ == '__main__':
    if len(argv) < 3:
        exit('Usage: %s'  % argv[0])
    else:
        i3 = i3ipc.Connection()
        window_list = i3.get_tree().leaves()
        tag=argv[1]

        if argv[2] == "next":
            cycle_next()
