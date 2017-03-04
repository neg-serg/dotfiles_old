#!/usr/bin/python3
import i3ipc
import i3

from sys import argv
from sys import exit
from itertools import cycle
from subprocess import check_output

import uuid
import re

settings = {
    'im' : {
        'classes' : { 'TelegramDesktop', 'Telegram-desktop', 'telegram-desktop', 'skypeforlinux' },
        'geom' : "528x1029+1372+127"
    }
}

def parse_geom():
    geom=re.split(r'[x+]', settings[group]["geom"])
    return "move absolute position {} {}, resize set {} {}".format(*geom)

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
