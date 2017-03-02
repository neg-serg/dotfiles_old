#!/bin/python3

import i3ipc
from sys import argv
from sys import exit
from itertools import cycle
from subprocess import check_output

def debug():
    return 0

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
    focus()

def unfocus():
    for j,i in zip(range(len(marked)), sorted(marked, key=lambda im: im.name)):
        dprint(i.name, i.id)
        marked[j].command('move scratchpad')
        j=j+1

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
    j=0
    focused = i3.get_tree().find_focused()
    focus()
    for i in sorted(marked, key=lambda im: im.name):
        if debug():
            print(i.name, i.id)
            print("focused id=",focused.id)
        if focused.id != i.id:
            marked[j].command('move container to workspace current')
            i.command('move scratchpad')
        j=j+1

    focus()

def visible():
    # if len(argv) > 1 and argv[1] == "reverse":
    #     cycle_windows = cycle(reversed(visible_windows))
    # else:
    #     cycle_windows = cycle(visible_windows)

    # for window in cycle_windows:
    #     if window.focused:
    #         focus_to = next(cycle_windows)
    #         i3.command('[id="%d"] focus' % focus_to.window)
    #         break

    visible_windows = find_visible_windows(get_windows_on_ws(i3))

    if debug():
        print("Visible and marked")

    vmarked = 0
    for w in visible_windows:
        for i in sorted(marked, key=lambda im: im.name):
            if w.id == i.id:
                if debug():
                    print("{name,id}=", i.name, i.id)
                    print("name=", w.name)
                vmarked+=1

    return vmarked

#------------------------------------------------
if __name__ == '__main__':
    if len(argv) < 3:
        exit('Usage: %s'  % argv[0])
    else:
        i3 = i3ipc.Connection()
        window_list = i3.get_tree().leaves()
        marked = i3.get_tree().find_marked(argv[1])

        # i3 = i3ipc.Connection()
        # i3.on('workspace::focus', swap)
        # i3.on('window::new', on_new_window)
        # i3.on('window::fullscreen_mode', swap)
        # # TODO XXX Handle window::mark (does not yet exist)
        # i3.main()
        if argv[2] == "show":
            focus()
        elif argv[2] == "hide":
            unfocus()
        elif argv[2] == "toggle":
            toggle()
        elif argv[2] == "next":
            iterate_over()
#------------------------------------------------
