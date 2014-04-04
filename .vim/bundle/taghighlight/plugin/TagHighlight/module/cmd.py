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

import os
import optparse

from .config import SetInitialOptions, LoadLanguages
from .options import AllOptions
import ast

def DictHandler(option, opt_str, value, parser):
    setattr(parser.values, option.dest, ast.literal_eval(value))

def ProcessCommandLine():
    parser = optparse.OptionParser()
    pyoptions = []

    for dest in AllOptions.keys():
        if 'CommandLineSwitches' not in AllOptions[dest]:
            # Vim-only option
            continue
        if AllOptions[dest]['Default'] == 'None':
            AllOptions[dest]['Default'] = None

        # Correct erroneous conversion of help text to list
        if isinstance(AllOptions[dest]['Help'], list):
            AllOptions[dest]['Help'] = "".join(AllOptions[dest]['Help'])

        pyoptions.append(dest)
        if not isinstance(AllOptions[dest]['CommandLineSwitches'], list):
            AllOptions[dest]['CommandLineSwitches'] = AllOptions[dest]['CommandLineSwitches'].split(',')

        if AllOptions[dest]['Type'] == 'bool':
            if AllOptions[dest]['Default'] == True:
                action = 'store_false'
            else:
                action = 'store_true'
            parser.add_option(*AllOptions[dest]['CommandLineSwitches'],
                    action=action,
                    default='DEFAULT_OPTION_USED',
                    dest=dest,
                    help=AllOptions[dest]['Help'])
        elif AllOptions[dest]['Type'] == 'dict':
            parser.add_option(*AllOptions[dest]['CommandLineSwitches'],
                    action="callback",
                    type="string",
                    default='DEFAULT_OPTION_USED',
                    dest=dest,
                    callback=DictHandler,
                    help=AllOptions[dest]['Help'])
        else:
            optparse_type='string'
            if AllOptions[dest]['Type'] in ['string', 'int']:
                action='store'
            elif AllOptions[dest]['Type'] == 'list':
                action='append'
            else:
                # TODO: This needs handling somehow
                pyoptions.remove(dest)
                continue
                raise Exception('Unrecognised option type: ' + AllOptions[dest]['Type'])
            parser.add_option(*AllOptions[dest]['CommandLineSwitches'],
                    action=action,
                    default='DEFAULT_OPTION_USED',
                    type=optparse_type,
                    dest=dest,
                    help=AllOptions[dest]['Help'])

    options, remainder = parser.parse_args()
    manually_set = []
    optdict = vars(options)

    for dest in pyoptions:
        if optdict[dest] == 'DEFAULT_OPTION_USED':
            optdict[dest] = AllOptions[dest]['Default']
        else:
            manually_set.append(dest)

    return optdict, manually_set
