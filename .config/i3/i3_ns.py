#!/bin/python3

import i3
import i3ipc
import sys

def scratchpad_windows():
    # get containers with appropriate scratchpad state
    containers = i3.filter(scratchpad_state='changed')
    # filter out windows (leaf nodes of the above containers)
    return i3.filter(containers, nodes=[])

# def main():
#     windows = scratchpad_windows()
#     # search for focused window among scratchpad windows
#     if i3.filter(windows, focused=True):
#         # move that window back to scratchpad
#         i3.move('scratchpad')
#     # show the next scratchpad window
#     i3.scratchpad('show')

# if __name__ == '__main__':
# main()

def debug():
    return 1

def focus():
    print("---------------------ALL--------------------")
    j=0
    for i in sorted(window_list, key=lambda im: im.name):
        if debug():
            print(i.name, i.id)
        j=j+1

    print("---------------------IM--------------------")
    j=0
    for i in sorted(marked, key=lambda im: im.name):
        if debug():
            print(i.name, i.id)
        marked[j].command('move container to workspace current')
        j=j+1

def toggle():
    focused = i3.get_tree().find_focused()
    j=0
    for i in sorted(marked, key=lambda im: im.name):
        if debug():
            print(i.name, i.id)
        if focused.id == i.id:
            unfocus()
            return
        j=j+1

    focus()

def unfocus():
    j=0
    for i in sorted(marked, key=lambda im: im.name):
        if debug():
            print(i.name, i.id)
        marked[j].command('move scratchpad')
        j=j+1

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
            # break
        # else:
        #     i.command('scratchpad show')
        j=j+1

    focus()

def get_marks(i3):
    """ Returns a list of all currently used marks. """
    return json.loads(i3.message(i3ipc.MessageType.GET_MARKS, ''))

def get_groups(i3):
    """ Returns a list of sticky groups currently in use. """
    matches = [ STICKY_GROUP.match(mark) for mark in get_marks(i3) ]
    return [ match.group(1) for match in matches if match is not None ]

def get_suffixed_mark(i3, mark):
    """ Returns the name of a currently unused mark starting with the given mark. """
    marks = get_marks(i3)

    suffix = 1
    while True:
        result = '%s_%d' % (mark, suffix)
        if not result in marks:
            return result
        suffix += 1

def swap(i3, _):
    """ Swaps each sticky container into the current workspace if possible. """

    # For each sticky group, try swapping the sticky container into this
    # workspace.
    for group in get_groups(i3):
        # TODO XXX For the (technically invalid) case of the placeholder being
        # on the same workspace as the sticky container, perhaps we should
        # first look up the sticky container by mark, check that it's on a
        # different workspace and then execute the command.
        i3.command('[workspace="__focused__" con_mark="^_sticky_%s_"] swap container with mark "_sticky_%s"' % (group, group))

def on_new_window(i3, event):
    instance = event.container.window_instance
    if not instance:
        return

    match = re.match(r'^i3-sticky-(.*)$', instance)
    if not match:
        return

    mark = get_suffixed_mark(i3, '_sticky_%s' % match.group(1))
    event.container.command('mark --add %s' % mark)

#------------------------------------------------
if __name__ == '__main__':
    if len(sys.argv) < 3:
        sys.exit('Usage: %s'  % sys.argv[0])
    else:
        i3 = i3ipc.Connection()
        window_list = i3.get_tree().leaves()
        marked = i3.get_tree().find_marked(sys.argv[1])

        # i3 = i3ipc.Connection()
        # i3.on('workspace::focus', swap)
        # i3.on('window::new', on_new_window)
        # i3.on('window::fullscreen_mode', swap)
        # # TODO XXX Handle window::mark (does not yet exist)
        # i3.main()
        if sys.argv[2] == "show":
            focus()
        elif sys.argv[2] == "hide":
            unfocus()
        elif sys.argv[2] == "toggle":
            toggle()
        elif sys.argv[2] == "next":
            iterate_over()
        elif sys.argv[1] == "scratch":
            show_scratch()
#------------------------------------------------
