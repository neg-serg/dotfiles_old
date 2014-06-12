#!/usr/bin/env python

# Huge thanks to http://superuser.com/questions/60379/how-can-i-create-a-zip-tgz-in-linux-such-that-windows-has-proper-filenames#190786
# and http://stackoverflow.com/questions/12456560/encoding-of-filenames-containing-non-latin-characters-while-extracting-from-tar
import tarfile
import codecs
import sys

def recover(name):
    return codecs.decode(name, 'cp1251')

for tar_filename in sys.argv[1:]:
    tar = tarfile.open(name=tar_filename, mode='r', bufsize=16*1024)
    updated = []
    for m in tar.getmembers():
        m.name = recover(m.name)
        updated.append(m)
    tar.extractall(members=updated)
    tar.close()
