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
        'priority':'Firefox',
    },
    'vid':{
        'classes': {'mpv'},
        'priority':'mpv',
        'usual_fullscreen':True,
    }
}

def debug():
    return 0

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
                if not focused.window_class in settings[tag]["classes"]:
                    for num,pr in zip(range(len(window_list)),window_list):
                        if pr.window_class == settings[tag]["priority"]:
                            pr.command('focus')
                            f.seek(0)
                            f.write(str(num)+'\n')
                else:
                    if tw[j].fullscreen_mode != False and len(tw) > 1:
                        tw[j].command('fullscreen disable')
                    tw[j+1].command('focus')
                    f.seek(0)
                    f.write(str(j+1)+'\n')
        except (IndexError, FileNotFoundError) as ex:
            cur=tw[0]
            if cur.id != focused.id:
                cur.command('focus')
            with open(filename, "w") as f:
                f = open(filename, 'w')
                f.write('0\n')

def print_me():
    s=""
    ws=find_acceptable_windows_by_class()
    for j,i in zip(range(len(ws)),ws):
        if i.id == focused.id:
            s="[x]["+str(j)+"] "+" ["+str(i.id)+"] "+i.name
        else:
            s="["+str(j)+"] "+" ["+str(i.id)+"] "+i.name
        dprint(s)

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
            if debug():
                print_me()
            cycle_next()
        if argv[2] == "print":
            print_me()
