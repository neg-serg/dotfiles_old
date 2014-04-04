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
import glob
import re

try:
    from .debug import Debug
except ValueError:
    def Debug(text, level):
        print(text)

data_directory = None

leadingTabRE = re.compile(r'^\t*')
includeRE = re.compile(r'^%INCLUDE (?P<filename>.*)$')
envRE = re.compile(r'\$\{(?P<envname>[A-Za-z0-9_]+)\}')

def SetLoadDataDirectory(directory):
    global data_directory
    data_directory = directory

def EntrySplit(entry, pattern):
    result = []
    parts = entry.strip().split(pattern, 1)
    if len(parts) == 1:
        result = parts
    elif ',' in parts[1]:
        result = [parts[0], parts[1].split(',')]
    else:
        result = parts
    return result

def ParseEntries(entries, indent_level=0):
    index = 0
    while index < len(entries):
        line = entries[index].rstrip()
        m = leadingTabRE.match(line)
        this_indent_level = len(m.group(0))
        unindented = line[this_indent_level:]

        if len(line.strip()) == 0:
            # Empty line
            pass
        elif line.lstrip()[0] == '#':
            # Comment
            pass
        elif this_indent_level < indent_level:
            return {'Index': index, 'Result': result}
        elif this_indent_level == indent_level:
            if ':' in unindented:
                parts = EntrySplit(unindented, ':')
                key = parts[0]
                try:
                    result
                except NameError:
                    result = {}
                if not isinstance(result, dict):
                    raise TypeError("Dictionary/List mismatch in '%s'" % key)
                if len(parts) > 1:
                    result[key] = parts[1]
            else:
                try:
                    result
                except NameError:
                    result = []
                if not isinstance(result, list):
                    raise TypeError("Dictionary/List mismatch: %r" % result)
                result += [unindented]
        else:
            sublist = entries[index:]
            subindent = indent_level+1
            parsed = ParseEntries(sublist, subindent)
            try:
                result
            except NameError:
                result = {}
            if key in result and isinstance(result[key], dict) and isinstance(parsed['Result'], dict):
                result[key] = dict(result[key].items() + parsed['Result'].items())
            else:
                result[key] = parsed['Result']
            index += parsed['Index'] - 1
        index += 1
    try:
        result
    except NameError:
        result = {}
    return {'Index': index, 'Result': result}

def LoadFile(filename):
    fh = open(filename, 'r')
    entries = fh.readlines()
    index = 0
    while index < len(entries):
        m = includeRE.match(entries[index])
        if m is not None:
            # Include line
            inc_file = m.group('filename').strip()
            e = envRE.search(inc_file)
            try:
                while e is not None:
                    inc_file = inc_file[:e.start()] + \
                            os.environ[e.group('envname')] + \
                            inc_file[e.end():]
                    e = envRE.search(inc_file)
            except KeyError:
                raise
                pass
            if os.path.exists(inc_file):
                fhinc = open(inc_file, 'r')
                extra_entries = fhinc.readlines()
                fhinc.close()
                entries = entries[:index] + extra_entries + entries[index+1:]
            else:
                Debug("No such file: '%s'" % inc_file, "Warning")
        index += 1
    fh.close()
    return ParseEntries(entries)['Result']

def LoadDataFile(relative):
    filename = os.path.join(data_directory,relative)
    return LoadFile(filename)

def GlobData(matcher):
    files = glob.glob(os.path.join(data_directory, matcher))
    return [os.path.relpath(i,data_directory) for i in files]

if __name__ == "__main__":
    import pprint
    pprint.pprint(LoadFile('testfile.txt'))
