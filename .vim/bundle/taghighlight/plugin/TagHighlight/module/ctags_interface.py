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
import subprocess
import os
import re
import glob
from .utilities import TagDB, FileTagDB, rglob
from .languages import Languages
from .debug import Debug

field_processor = re.compile(
r'''
    ^                 # Start of the line
    (?P<keyword>.*?)  # Capture the first field: everything up to the first tab
    \t                # Field separator: a tab character
    (?P<filename>.*?) # Second field (filename): everything up to the next tab
    \t                # Field separator: a tab character
    (?P<search>.*?)   # Any character at all, but as few as necessary (i.e. catch everything up to the ;")
    ;"                # The end of the search specifier (see http://ctags.sourceforge.net/FORMAT)
    (?=\t)            # There MUST be a tab character after the ;", but we want to match it with zero width
    .*\t              # There can be other fields before "kind", so catch them here.
                      # Also catch the tab character from the previous line as there MUST be a tab before the field
    (kind:)?          # This is the "kind" field; "kind:" is optional
    (?P<kind>\w)      # The kind is a single character: catch it
    (?=\t|$)          # It must be followed either by a tab or by the end of the line (but don't include that in the match)
    (?P<other>        # Catch anything in between the kind and the scope indicator
        \t            # Each block is a tab, followed by
        (?!file:)     # NOT file: (as this is the scope indicator)
        [^\t]+        # One or more non-tab characters
    )*                # This block can repeat
    (?P<scope>        # Look for a file-scope indicator
        \t            # Preceded by a tab character
        file:         # This is the file-scope indicator
        (?=\t|$)      # Must be followed by a tab character or the end of line (but don't include it in the match)
    )?                # The file-scope identifier is optional
    .*                # Soak up the rest of the line
''', re.VERBOSE)

field_const = re.compile(r'\bconst\b')

def GenerateTags(options):
    Debug("Generating Tags", "Information")

    # Change the working directory to the source root
    # now so that argument globs work correctly.
    os.chdir(options['SourceDir'])

    if 'CtagsArguments' in options['ManuallySetOptions']:
        args = options['CtagsArguments']
    else:
        if 'CtagsVariant' in options['ManuallySetOptions']:
            variant = options['CtagsVariant']
        else:
            variant = 'exuberant'
        args = ctags_variant_args[variant](options)

    ctags_cmd = [options['CtagsExeFull']] + args

    Debug("ctags command is " + repr(ctags_cmd), "Information")

    #subprocess.call(" ".join(ctags_cmd), shell = (os.name != 'nt'))
    # shell=True stops the command window popping up
    # We don't use stdin, but have to define it in order
    # to get round python bug 3905
    # http://bugs.python.org/issue3905
    process = subprocess.Popen(ctags_cmd,
            stdin=subprocess.PIPE,
            stderr=subprocess.PIPE,
            stdout=subprocess.PIPE
            )#, shell=True)
    (sout, serr) = process.communicate()

    tagFile = open(os.path.join(options['CtagsFileLocation'], options['TagFileName']), 'r')
    tagLines = [line.strip() for line in tagFile]
    tagFile.close()

    # Also sort the file a bit better (tag, then kind, then filename)
    tagLines.sort(key=ctags_key)

    tagFile = open(os.path.join(options['CtagsFileLocation'],options['TagFileName']), 'w')
    for line in tagLines:
        tagFile.write(line + "\n")
    tagFile.close()

def ParseTags(options):
    """Function to parse the tags file and generate a dictionary containing language keys.

    Each entry is a list of tags with all the required details.
    """
    languages = options['LanguageHandler']
    kind_list = languages.GetKindList()

    # Language: {Type: set([keyword, keyword, keyword])}
    ctags_entries = TagDB()
    # Language: {File: {Type: set([keyword, keyword, keyword])}}
    file_entries = FileTagDB()

    lineMatchers = {}
    for key in languages.GetAllLanguages():
        lineMatchers[key] = re.compile(
                r'^.*?\t[^\t]*\.(?P<extension>' +
                languages.GetLanguageHandler(key)['PythonExtensionMatcher'] +
                ')\t')

    p = open(os.path.join(options['CtagsFileLocation'],options['TagFileName']), 'r')
    while 1:
        try:
            line = p.readline()
        except UnicodeDecodeError:
            continue
        if not line:
            break

        for key, lineMatcher in list(lineMatchers.items()):
            if lineMatcher.match(line):
                # We have a match
                m = field_processor.match(line.strip())
                if m is not None:
                    try:
                        new_entry = None
                        short_kind = 'ctags_' + m.group('kind')
                        kind = kind_list[key][short_kind]
                        keyword = m.group('keyword')
                        if options['ParseConstants'] and \
                                (key == 'c') and \
                                (kind == 'CTagsGlobalVariable'):
                            if field_const.search(m.group('search')) is not None:
                                kind = 'CTagsConstant'
                        if key in options['LanguageTagTypes']:
                            if m.group('kind') in options['LanguageTagTypes'][key]:
                                new_entry = keyword
                        elif m.group('kind') not in languages.GetLanguageHandler(key)['SkipList']:
                            new_entry = keyword

                        if new_entry is None:
                            continue

                        if m.group('scope') is None or options['IgnoreFileScope']:
                            ctags_entries[key][kind].add(new_entry)
                        else:
                            if m.group('filename') not in file_entries:
                                file_entries[m.group('filename')] = TagDB()
                            file_entries[key][m.group('filename')][kind].add(new_entry)

                    except KeyError:
                        Debug("Unrecognised kind '{kind}' for language {language}".format(kind=m.group('kind'), language=key), "Error")
    p.close()

    return ctags_entries, file_entries

def ExuberantGetCommandArgs(options):
    args = []

    ctags_languages = [l['CTagsName'] for l in options['LanguageHandler'].GetAllLanguageHandlers()]
    if 'c' in ctags_languages:
        ctags_languages.append('c++')
    args += ["--languages=" + ",".join(ctags_languages)]

    # Vim assumes that tags are relative to the tag file location,
    # so make sure they are!
    if options['TagRelative']:
        args += ['--tag-relative=yes']
    else:
        args += ['--tag-relative=no']

    if options['TagFileName']:
        args += ['-f', os.path.join(options['CtagsFileLocation'], options['TagFileName'])]

    if not options['IncludeDocs']:
        args += ["--exclude=docs", "--exclude=Documentation"]

    if options['IncludeLocals']:
        Debug("Including local variables in tag generation", "Information")
        kinds = options['LanguageHandler'].GetKindList()
        def FindLocalVariableKinds(language_kinds):
            """Finds the key associated with a value in a dictionary.

            Assumes presence has already been checked."""
            Debug("Finding local variable types from " + repr(language_kinds), "Information")
            return "".join(key[-1] for key,val in language_kinds.items() if val == 'CTagsLocalVariable')

        for language in ctags_languages:
            if language in kinds and 'CTagsLocalVariable' in kinds[language].values():
                Debug("Finding local variables for " + language, "Information")
                args += ['--{language}-kinds=+{kind}'.format(language=language,
                    kind=FindLocalVariableKinds(kinds[language]))]
            else:
                Debug("Skipping language: " + language, "Information")

    if options['Recurse']:
        args += ['--recurse']

    args += ['--fields=+iaSszt']
    args += ['--c-kinds=+p', '--c++-kinds=+p']
    args += ['--extra=+q']

    # If user specified extra arguments are required, add them
    # immediately before the file list
    if 'CtagsExtraArguments' in options:
        args += options['CtagsExtraArguments']

    # Must be last as it includes the file list:
    if options['Recurse']:
        args += ['.']
    else:
        args += glob.glob(os.path.join(options['SourceDir'],'*'))

    Debug("Command arguments: " + repr(args), "Information")

    return args

def JSCtagsGetCommandArgs(options):
    args = []
    if options['TagFileName']:
        args += ['-f', os.path.join(options['CtagsFileLocation'], options['TagFileName'])]

    # If user specified extra arguments are required, add them
    # immediately before the file list
    if 'CtagsExtraArguments' in options:
        args += options['CtagsExtraArguments']

    # jsctags isn't very ctags-compatible: if you give it a directory
    # and expect it to recurse, it fails on the first non-javascript
    # file.  Therefore, we have to assume all javascript files have .js
    # extensions and we have to find them ourselves.  This may well fail
    # on Windows if there are a lot of them due to the limited command
    # length on Windows.
    if options['Recurse']:
        args += rglob('.', '*.js')
    else:
        args += glob.glob('*.js')
    return args

ctags_variant_args = {
        'exuberant': ExuberantGetCommandArgs,
        'jsctags': JSCtagsGetCommandArgs,
        }

key_regexp = re.compile('^(?P<keyword>.*?)\t(?P<remainder>.*\t(?P<kind>[a-zA-Z])(?:\t|$).*)')

def ctags_key(ctags_line):
    match = key_regexp.match(ctags_line)
    if match is None:
        return ctags_line
    return match.group('keyword') + match.group('kind') + match.group('remainder')
