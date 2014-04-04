#!/usr/bin/env python
# Tag Highlighter:
#   Author:  A. S. Budden <abudden _at_ gmail _dot_ com>
# Copyright: Copyright (C) 2009-2013 A. S. Budden
#            Permission is hereby granted to use and distribute this code,
#            with or without modifications, provided that this copyright
#            notice is copied with it. Like anything else that's free,
#            the TagHighlight plugin is provided *as is* and comes with no
#            warranty of any kind, either expressed or implied. By using
#            this plugin, you agree that in no event will the copyright
#            holder be liable for any damages resulting from the use
#            of this software.

# ---------------------------------------------------------------------
import sys
import os

from optparse import Values
from .utilities import TagHighlightOptionDict
from .loaddata import LoadFile, LoadDataFile, SetLoadDataDirectory
from .debug import SetDebugLogFile, SetDebugLogLevel, Debug

config = TagHighlightOptionDict()

def SetDataDirectories():
    global config
    if hasattr(sys, 'frozen'):
        # Compiled variant, executable should be in
        # plugin/TagHighlight/Compiled/Win32, so data
        # is in ../../data relative to executable
        config['DataDirectory'] = os.path.abspath(
                os.path.join(os.path.dirname(sys.executable),
                '../../data'))
        config['VersionInfoDir'] = os.path.abspath(os.path.dirname(sys.executable))
    else:
        # Script variant: this file in
        # plugin/TagHighlight/module, so data is in
        # ../data relative to this file
        config['DataDirectory'] = os.path.abspath(
                os.path.join(os.path.dirname(__file__),
                '../data'))
        config['VersionInfoDir'] = config['DataDirectory']

    SetLoadDataDirectory(config['DataDirectory'])

    if not os.path.exists(config['DataDirectory']):
        raise IOError("Data directory doesn't exist, have you installed the main distribution?")

def LoadVersionInfo():
    global config
    data = LoadDataFile('release.txt')
    config['Release'] = data['release']

    try:
        config['Version'] = LoadFile(os.path.join(config['VersionInfoDir'],'version_info.txt'))
    except IOError:
        config['Version'] = {
                'clean': 'Unreleased',
                'date': 'Unreleased',
                'revision_id': 'Unreleased',
                }

def SetInitialOptions(new_options, manual_options):
    global config
    for key in new_options:
        config[key] = new_options[key]
    if 'DebugLevel' in config:
        SetDebugLogLevel(config['DebugLevel'])
    if 'DebugFile' in config:
        SetDebugLogFile(config['DebugFile'])
    config['ManuallySetOptions'] = manual_options

def LoadLanguages():
    global config
    if 'LanguageHandler' in config:
        return
    from .languages import Languages
    config['LanguageHandler'] = Languages(config)

    full_language_list = config['LanguageHandler'].GetAllLanguages()
    if len(config['Languages']) == 0:
        # Include all languages
        config['LanguageList'] = full_language_list
    else:
        config['LanguageList'] = [i for i in full_language_list if i in config['Languages']]
    Debug("Languages:\n\t{0!r}\n\t{1!r}".format(full_language_list, config['LanguageList']), "Information")

SetDataDirectories()
LoadVersionInfo()
