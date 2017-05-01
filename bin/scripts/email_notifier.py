#!/usr/bin/env python2

import pyinotify
import pynotify
from os.path import expanduser
from mailbox import MaildirMessage
from email.header import decode_header
from gtk.gdk import pixbuf_new_from_file

# Getting the path of all the boxes
fd =  open(expanduser("~/.mutt/mailboxes"), 'r')
boxes = [expanduser(b[1:-1]) for b in fd.readline()[10:-1].split(' ')]
fd.close()

pynotify.init('email_notifier.py')

# Handling a new mail
icon = pixbuf_new_from_file(expanduser("~/.icons/Lüv/actions/24/mail-mark-unread-new.svg"))
dec_header = lambda h : ' '.join(unicode(s, e if bool(e) else 'ascii') for s, e in decode_header(h))
def newfile(event):
    fd = open(event.pathname, 'r')
    mail = MaildirMessage(message=fd)
    From = "[From]: " + dec_header(mail['From'])
    Subject = "[Subject]: " + dec_header(mail['Subject'])
    n = pynotify.Notification("New mail in "+'/'.join(event.path.split('/')[-3:-1]),
                              From+ "\n"+ Subject)
    fd.close()
    n.set_icon_from_pixbuf(icon)
    n.set_timeout(12000)
    n.show()

wm = pyinotify.WatchManager()
notifier = pyinotify.Notifier(wm, newfile)

for box in boxes:
    wm.add_watch(box+"/new", pyinotify.IN_CREATE | pyinotify.IN_MOVED_TO)

notifier.loop()
