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
import sys
import re
from .utilities import GenerateValidKeywordRange, IsValidKeyword
from .debug import Debug

vim_synkeyword_arguments = [
        'contains',
        'oneline',
        'fold',
        'display',
        'extend',
        'contained',
        'containedin',
        'nextgroup',
        'transparent',
        'skipwhite',
        'skipnl',
        'skipempty'
        ]

def write(fh, value):
    fh.write(value.encode('ascii'))

def CreateTypesFile(options, language, unscoped_tags, file_tags):
    Debug("Writing types file", "Information")

    entry_sets = {}

    for source_file in [None] + list(file_tags.keys()):
        if source_file is None:
            tags = unscoped_tags
        else:
            tags = file_tags[source_file]

        tag_types = list(tags.keys())
        tag_types.sort()

        language_handler = options['LanguageHandler'].GetLanguageHandler(language)

        if options['CheckKeywords']:
            iskeyword = GenerateValidKeywordRange(language_handler['IsKeyword'])
            Debug("Is Keyword is {0!r}".format(iskeyword), "Information")

        matchEntries = set()
        vimtypes_entries = []

        typesUsedByLanguage = list(options['LanguageHandler'].GetKindList(language).values())
        # TODO: This may be included elsewhere, but we'll leave it in for now
        #clear_string = 'silent! syn clear ' + " ".join(typesUsedByLanguage)

        vimtypes_entries = []
        #vimtypes_entries.append(clear_string)

        # Get the priority list from the language handler
        # Highest priority is first
        priority = language_handler['Priority'][:]

        fullTypeList = list(sorted(tags.keys()))
        # Reorder type list according to priority sort order
        allTypes = []
        for thisType in priority:
            if thisType in fullTypeList:
                allTypes.append(thisType)
                fullTypeList.remove(thisType)
        # Add the ones not specified in priority
        allTypes += fullTypeList

        Debug("Type priority list: " + repr(allTypes), "Information")

        patternREs = []
        for pattern in options['SkipPatterns']:
            patternREs.append(re.compile(pattern))

        all_keywords = []
        for thisType in allTypes:
            keystarter = 'syn keyword ' + thisType
            keycommand = keystarter
            for keyword in tags[thisType]:
                skip_this = False

                if not options['DisableDuplicateCheck']:
                    if keyword in all_keywords:
                        # Duplicate: skip
                        continue
                    all_keywords.append(keyword)

                if options['SkipReservedKeywords']:
                    if keyword in language_handler['ReservedKeywords']:
                        Debug('Skipping reserved word ' + keyword, 'Information')
                        # Ignore this keyword
                        continue
                for pattern in patternREs:
                    if pattern.search(keyword) != None:
                        skip_this = True
                        break
                if skip_this:
                    continue

                if options['CheckKeywords']:
                    # In here we should check that the keyword only matches
                    # vim's \k parameter (which will be different for different
                    # languages).  This is quite slow so is turned off by
                    # default; however, it is useful for some things where the
                    # default generated file contains a lot of rubbish.  It may
                    # be worth optimising IsValidKeyword at some point.
                    if not IsValidKeyword(keyword, iskeyword):
                        matchDone = False
                        if options['IncludeSynMatches']:

                            patternCharacters = "/@#':"
                            charactersToEscape = '\\' + '~[]*.$^'

                            for patChar in patternCharacters:
                                if keyword.find(patChar) == -1:
                                    escapedKeyword = keyword
                                    for ch in charactersToEscape:
                                        escapedKeyword = escapedKeyword.replace(ch, '\\' + ch)
                                    if options['IncludeSynMatches']:
                                        matchEntries.add('syn match ' + thisType + ' ' + patChar + r'\<' + escapedKeyword + r'\>' + patChar)
                                    matchDone = True
                                    break

                        if not matchDone:
                            Debug("Skipping keyword '" + keyword + "'", "Information")

                        continue


                if keyword.lower() in vim_synkeyword_arguments:
                    if not options['SkipVimKeywords']:
                        matchEntries.add('syn match ' + thisType + r' /\<' + keyword + r'\>/')
                    continue

                temp = keycommand + " " + keyword
                if len(temp) >= 512:
                    vimtypes_entries.append(keycommand)
                    keycommand = keystarter
                keycommand = keycommand + " " + keyword
            if keycommand != keystarter:
                vimtypes_entries.append(keycommand)

        # Sort the matches
        matchEntries = sorted(list(matchEntries))

        if (len(matchEntries) + len(vimtypes_entries)) == 0:
            # All keywords have been filtered out, give up
            return

        vimtypes_entries.reverse()

        vimtypes_entries.append('')
        vimtypes_entries += matchEntries

        if source_file is None:
            unscoped_entries = vimtypes_entries[:]
        else:
            entry_sets[source_file] = vimtypes_entries[:]

    if options['IncludeLocals']:
        LocalTagType = ',CTagsLocalVariable'
    else:
        LocalTagType = ''

    if options['TypesFileNameForce'] is not None and options['TypesFileNameForce'] != 'None':
        type_file_name = options['TypesFileNameForce']
    else:
        type_file_name = options['TypesFilePrefix'] + '_' + language_handler['Suffix'] + '.' + options['TypesFileExtension']
    filename = os.path.join(options['TypesFileLocation'], type_file_name)
    Debug("Filename is {0}\n".format(filename), "Information")

    try:
        # Have to open in binary mode as we want to write with Unix line endings
        # The resulting file will then work with any Vim (Windows, Linux, Cygwin etc)
        fh = open(filename, 'wb')
    except IOError:
        Debug("ERROR: Couldn't create {file}\n".format(file=outfile), "Error")
        sys.exit(1)

    try:
        for source_file in [None] + list(entry_sets.keys()):
            if source_file is None:
                vimtypes_entries = unscoped_entries
                prefix = ''
            else:
                prefix = '\t'
                vimtypes_entries = entry_sets[source_file]

            if source_file is not None and not options['IgnoreFileScope']:
                formatted_file = os.path.normpath(source_file).replace(os.path.sep, '/')
                write(fh, '" Matches for file %s:\n' % source_file)
                write(fh, 'if (has_key(b:TagHighlightPrivate, "NormalisedPath") && b:TagHighlightPrivate["NormalisedPath"] == "%s") || TagHighlight#Option#GetOption("IgnoreFileScope")\n' % formatted_file)
            for line in vimtypes_entries:
                try:
                    write(fh, prefix + line)
                except UnicodeDecodeError:
                    Debug("Error decoding line '{0!r}'".format(line), "Error")
                    write(fh, 'echoerr "Types generation error"\n')
                write(fh, '\n')
            if source_file is not None and not options['IgnoreFileScope']:
                write(fh, 'endif\n')
    except IOError:
        Debug("ERROR: Couldn't write {file} contents\n".format(file=outfile), "Error")
        sys.exit(1)
    finally:
        fh.close()
