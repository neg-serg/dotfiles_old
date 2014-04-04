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
from __future__ import print_function
import sys
import os

def RunWithOptions(options, manually_set=[]):
    start_directory = os.getcwd()
    from .config import config, SetInitialOptions, LoadLanguages
    from .debug import Debug

    SetInitialOptions(options, manually_set)

    Debug("Running types highlighter generator", "Information")
    Debug("Release:" + config['Release'], "Information")
    Debug("Version:" + repr(config['Version']), "Information")
    Debug("Options:" + repr(options), "Information")
    Debug("Manually Set:" + repr(manually_set), "Information")

    tag_file_absolute = os.path.join(config['CtagsFileLocation'], config['TagFileName'])
    if config['DoNotGenerateTags'] and not os.path.exists(tag_file_absolute):
        Debug("Cannot use existing tagfile as it doesn't exist (checking for " + tag_file_absolute + ")", "Error")
        return

    LoadLanguages()

    if config['PrintConfig']:
        import pprint
        pprint.pprint(config)
        return

    if config['PrintPyVersion']:
        print(sys.version)
        return

    from .ctags_interface import GenerateTags, ParseTags
    from .generation import CreateTypesFile

    cscope_check_c = False
    if config['EnableCscope']:
        cscope_file = os.path.join(config['CscopeFileLocation'], config['CscopeFileName'])
        config['CscopeFileFull'] = cscope_file
        if os.path.exists(cscope_file) or not config['CscopeOnlyIfCCode']:
            Debug("Running cscope", "Information")
            from .cscope_interface import StartCscopeDBGeneration, CompleteCscopeDBGeneration
            StartCscopeDBGeneration(config)
        else:
            Debug("Deferring cscope until C code detected", "Information")
            cscope_check_c = True

    if not config['DoNotGenerateTags']:
        Debug("Generating tag file", "Information")
        GenerateTags(config)
    tag_db, file_tag_db = ParseTags(config)

    for language in config['LanguageList']:
        if language in tag_db:
            CreateTypesFile(config, language, tag_db[language], file_tag_db[language])

    if config['EnableCscope']:
        if cscope_check_c and 'c' in tag_db:
            Debug("Running cscope as C code detected", "Information")
            from .cscope_interface import StartCscopeDBGeneration, CompleteCscopeDBGeneration
            StartCscopeDBGeneration(config)
        CompleteCscopeDBGeneration()

    os.chdir(start_directory)
