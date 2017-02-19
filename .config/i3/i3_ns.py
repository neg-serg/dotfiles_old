#!/bin/python3

import i3ipc
import sys

i3 = i3ipc.Connection()
im_list = i3.get_tree().leaves()
marked = i3.get_tree().find_marked("im")

global state

def debug():
    return false

def toggle():
    global state
    if state == 0:
        focus()
    elif state == 1:
        unfocus()

def focus():
    global state
    print("---------------------ALL--------------------")
    j=0
    for i in sorted(im_list, key=lambda im: im.name):
        print(i.name, i.id)
        j=j+1

    print("---------------------IM--------------------")
    j=0
    for i in sorted(marked, key=lambda im: im.name):
        if debug:
            print(i.name, i.id)
        marked[j].command('move container to workspace current')
        j=j+1
    state = 1

def unfocus():
    global state
    j=0
    for i in sorted(im_list, key=lambda im: im.name):
        if debug:
            print(i.name, i.id)
        im_list[j].command('move scratchpad')
        j=j+1
    state = 0

def iterate_over():
    j=0
    focused = i3.get_tree().find_focused()
    for i in sorted(im_list, key=lambda im: im.name):
        if debug:
            print(i.name, i.id)
            print("focused id=",focused.id)
        if focused.id == i.id:
            im_list[j].command('move scratchpad')
        j=j+1

if len(sys.argv) < 2:
    sys.exit('Usage: %s'  % sys.argv[0])

if sys.argv[1] == "show":
    focus()
elif sys.argv[1] == "hide":
    unfocus()
elif sys.argv[1] == "toggle":
    toggle()
elif sys.argv[1] == "next":
    iterate_over()
