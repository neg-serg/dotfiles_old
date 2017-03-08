#!/usr/bin/python3

import i3ipc
import i3 as i3hl

from sys import argv
from sys import exit

import subprocess

import uuid
import re

filename='/tmp/current_index'

settings = {
    'web' : {
        'classes' : {
            'Firefox',
            'Navigator',
            'Tor Browser',
            'Chromium',
        },
        'prog':"firefox",
        'priority':'Tor Browser',
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
        try:
            with open(filename, "r+") as f:
                j=int(f.readline())
                cur=tw[j]

                if cur.id != focused.id:
                    for pr in window_list:
                        if pr.window_class == settings[tag]["priority"]:
                            pr.command('focus')
                else:
                    tw[j+1].command('focus')
                f.seek(0)
                f.write(str(j+1)+'\n')
        except (IndexError, FileNotFoundError) as ex:
            with open(filename, "w") as f:
                f = open(filename, 'w')
                f.write('0\n')
            cur=tw[0]
            if cur.id != focused.id:
                cur.command('focus')

def print_me():
    s=""
    for j,i in zip(range(len(find_acceptable_windows_by_class())),find_acceptable_windows_by_class()):
        if i.id == focused.id:
            s="[x]["+str(j)+"] "+" ["+str(i.id)+"] "+i.name
        else:
            s="["+str(j)+"] "+" ["+str(i.id)+"] "+i.name
        print(s)

def find_acceptable_windows_by_class():
    tagged_windows=[]
    for cur in window_list:
        if cur.window_class in settings[tag]["classes"]:
            tagged_windows.append(cur)

    return sorted(tagged_windows, key=lambda w:w.id, reverse=False)

if __name__ == '__main__':
    if len(argv) < 3:
        exit('Usage: %s'  % argv[0])
    else:
        i3 = i3ipc.Connection()
        window_list = i3.get_tree().leaves()
        focused = i3.get_tree().find_focused()
        tag=argv[1]

        if argv[2] == "next":
            cycle_next()
        if argv[2] == "print":
            print_me()
