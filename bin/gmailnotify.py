#!/usr/bin/env python2

import sys
import urllib
import pynotify
import os
import time

from ConfigParser import ConfigParser
from optparse import OptionParser
from os import getenv
from os.path import join


class Inbox(object):
    def __init__(self, name, config,
                 urgency=pynotify.URGENCY_NORMAL, sound=None):
        self.name = name
        self.config = config
        self.urgency = urgency
        self.sound = sound
        self.last_mails = []

    def titles(self, msg):
        begin = msg.find("<title>")
        end = msg.find("</title>")
        t = []

        while begin > 0:
            t.append(msg[begin + len("<title>"):end])
            begin = msg.find("<title>", begin + len("<title>"))
            end = msg.find("</title>", end + len("</title>"))

        return t

    def get_feed(self):
        user = self.config.get('credentials', 'username')
        password = self.config.get('credentials', 'password')
        url = "https://%s:%s@mail.google.com/mail/feed/atom/%s" % (user,
                password, self.name)
        msg = urllib.urlopen(url).read()
        return msg

    def _notify(self, body):
        try:
            n = pynotify.Notification("New Mail (%s) " % self.name, body)
            n.set_urgency(self.urgency)
            n.show()
        except:
            print "Unable to send notification."


    def update(self, fh):
        msg = self.get_feed()
        summaries = self.titles(msg)[1:]

        new = [self._notify(s) for s in summaries if s not in self.last_mails]

        if new and self.sound:
            os.popen("aplay %s" % self.sound)

        self.last_mails = summaries

        if (fh is not None and len(summaries) > 0):
            fh.write("%s (%s):\n" % (self.name, len(summaries)))
            for s in summaries:
                fh.write("   %s\n" % s)

        return new


def run(config, boxes):
    sleep = config.getint("options", "sleep")
    while True:
        if config.has_option("options", "write_dest"):
            filename = config.get("options", "write_dest")
            f = open(filename, 'w')
        else:
            f = None
        try:
            for box in boxes:
                box.update(f)
        except:
            try:
                n = pynotify.Notification("Error getting emails")
                n.set_urgency(pynotify.URGENCY_CRITICAL)
                n.show()
            except:
                print "Unable to send notification."

        print "done"
        if f is not None:
            f.close()


        time.sleep(sleep * 60)


def read_config():
    config = ConfigParser()
    files = []
    try:
        files.append(join(getenv("XDG_CONFIG_HOME"), "gmailnotify.conf"))
    except:
        files.append(join(getenv("HOME"), ".config", "gmailnotify.conf"))

    config.read(files)

    return config


def prompt_password(config):
    import Tkinter as tk

    root = tk.Tk()

    def set_pw():
        pw = pw_entry.get()
        config.set('credentials', 'password', pw)
        root.destroy()

    label1 = tk.Label(root, text="Enter password for %s: " %
            config.get('credentials', 'username'))
    pw_entry = tk.Entry(root, show="*")
    pw_entry.focus_set()
    button = tk.Button(root, text='OK', command=set_pw)

    # simple widget layout, stack vertical
    label1.pack(pady=2)
    pw_entry.pack(pady=5)
    button.pack(pady=5)

    # start the event loop
    root.mainloop()
    return config


def parse_credentials_include(cred_file):
    cred_file = os.path.expanduser(cred_file)
    if not os.path.isfile(cred_file):
        print "ERROR: %s not found" % cred_file
        sys.exit(1)

    with open(cred_file) as f:
        login = f.read()

    login.strip()
    login = login.split("\n")
    # remove empty elements
    login = [x for x in login if x]

    if len(login) != 2:
        print "ERROR: invalid credentials"
        sys.exit(1)

    return login


def parse_credentials(config):
    if config.has_option('credentials', 'file'):
        user, password = parse_credentials_include(config.get('credentials',
            'file'))
        config.set('credentials', 'username', user)
        config.set('credentials', 'password', password)

    if config.get('credentials', 'password') == 'prompt':
        config = prompt_password(config)
    return config


def parse_mailboxes(config):
    urgencies = {}
    urgencies['low'] = pynotify.URGENCY_CRITICAL
    urgencies['normal'] = pynotify.URGENCY_NORMAL
    urgencies['critical'] = pynotify.URGENCY_CRITICAL

    boxes = []

    for section in config.sections():
        if section != 'credentials' and section != 'options':
            if config.has_option(section, 'sound'):
                sound = config.get(section, 'sound')
            else:
                sound = None

            if config.has_option(section, 'urgency'):
                urgency = urgencies[config.get(section, 'urgency')]
            else:
                urgency = urgencies['normal']

            boxes.append(Inbox(section, config, urgency, sound))
    return boxes


def parse_config():
    config = read_config()
    config = parse_credentials(config)
    mailboxes = parse_mailboxes(config)
    return (config, mailboxes)

def main():
    pynotify.init("gmailnotify.py")
    config, boxes = parse_config()

    parser = OptionParser("gmailnotify")
    parser.add_option("-d", "--display", action='store_true',
            dest='display', default=False,
            help="Display unread messages. If no arguments are given, display"
            " all inboxes, otherwise just the ones in the arguments.")
    parser.add_option("-w", "--write", action='store', dest='write_dest',
            default=None)



    (options, args) = parser.parse_args()

    if options.write_dest is not None:
        config.set("options", "write_dest", options.write_dest)
    if options.display:
        unread = False
        if args:
            boxes = [box for box in boxes if box.name in args]
        for box in boxes:
            if config.has_option("options", "write_dest"):
                fh = open(config.get("options", "write_dest"), 'w')
            else:
                fh = None
            unread = True if unread or box.update(fh) else False

        if not unread:
            n = pynotify.Notification("There's nothing to see here")
            n.show()
        sys.exit(0)

    run(config, boxes)

if __name__ == '__main__':
    main()
