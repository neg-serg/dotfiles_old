#!/usr/bin/env python
# Tag Highlighter:
#   Author:  A. S. Budden <abudden _at_ gmail _dot_ com>
# Copyright: Copyright (C) 2013 A. S. Budden
#            Permission is hereby granted to use and distribute this code,
#            with or without modifications, provided that this copyright
#            notice is copied with it. Like anything else that's free,
#            the TagHighlight plugin is provided *as is* and comes with no
#            warranty of any kind, either expressed or implied. By using
#            this plugin, you agree that in no event will the copyright
#            holder be liable for any damages resulting from the use
#            of this software.

# ---------------------------------------------------------------------
from __future__ import print_function
import subprocess
import os
import threading

from .debug import Debug

class CscopeThread(threading.Thread):
    def __init__(self, root, command):
        self.root = root
        self.command = command
        super(CscopeThread, self).__init__()

    def run(self):
        os.chdir(self.root)

        #subprocess.call(" ".join(cscope_cmd), shell = (os.name != 'nt'))
        # shell=True stops the command window popping up
        # We don't use stdin, but have to define it in order
        # to get round python bug 3905
        # http://bugs.python.org/issue3905
        process = subprocess.Popen(self.command,
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE
                )#, shell=True)
        (sout, serr) = process.communicate()

cscopeThread = None

def StartCscopeDBGeneration(options):
    global cscopeThread
    root = options['SourceDir']

    args = ['-b', '-f', options['CscopeFileFull']]

    if options['Recurse']:
        args.append('-R')

    cscope_cmd = [options['CscopeExeFull']] + args

    Debug("cscope command is " + repr(cscope_cmd), "Information")

    cscopeThread = CscopeThread(root, cscope_cmd)
    cscopeThread.start()

def CompleteCscopeDBGeneration():
    global cscopeThread
    if cscopeThread is not None:
        cscopeThread.join()
    cscopeThread = None
