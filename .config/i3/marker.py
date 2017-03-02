#!/usr/bin/python3
import i3ipc
import i3

from sys import argv
from sys import exit
from itertools import cycle
from subprocess import check_output

group_classes = {
    'TelegramDesktop',
    'Telegram-desktop',
    'telegram-desktop',
    'skypeforlinux'
}

counter = 0

def make_mark():
    return 'mark {}'.format(group) + str(counter)

def mark_group(self, event):
    global counter
    global group_classes

    con = event.container
    if con.window_class in group_classes:
        con.command(make_mark())
        con.command('move scratchpad,  move absolute position 1372 127, resize set 528 1029')
        print(make_mark())
        counter+=1

if len(argv) > 1:
    group=argv[1]

    i3con=i3ipc.Connection()
    marks=i3.get_marks()
    marked=i3con.get_tree().find_marked(group+"[0-9]+")

    print("::My marks::")
    for i in marks:
        print(i)

    i3con.on('window::new', mark_group)
    i3con.main()
