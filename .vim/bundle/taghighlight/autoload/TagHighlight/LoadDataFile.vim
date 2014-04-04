" Tag Highlighter:
"   Author:  A. S. Budden <abudden _at_ gmail _dot_ com>
" Copyright: Copyright (C) 2009-2013 A. S. Budden
"            Permission is hereby granted to use and distribute this code,
"            with or without modifications, provided that this copyright
"            notice is copied with it. Like anything else that's free,
"            the TagHighlight plugin is provided *as is* and comes with no
"            warranty of any kind, either expressed or implied. By using
"            this plugin, you agree that in no event will the copyright
"            holder be liable for any damages resulting from the use
"            of this software.

" ---------------------------------------------------------------------
try
	if &cp || v:version < 700 || (exists('g:loaded_TagHLLoadDataFile') && (g:plugin_development_mode != 1))
		throw "Already loaded"
	endif
catch
	finish
endtry
let g:loaded_TagHLLoadDataFile = 1

function! TagHighlight#LoadDataFile#LoadDataFile(filename)
	let filename = g:TagHighlightPrivate['PluginPath'] . '/data/' . a:filename
	return TagHighlight#LoadDataFile#LoadFile(filename)
endfunction

function! s:SingleSplit(string, pattern)
	let parts = split(a:string, a:pattern)
	if len(parts) > 1
		let parts[1] = join(parts[1:], a:pattern)
	endif
	if len(parts) > 1 && stridx(parts[1], ',') != -1
		" List
		let results = [parts[0], split(parts[1], ',')]
	else
		let results = parts[0:1]
	endif
	return results
endfunction

function! s:ParseEntries(entries, indent_level)
	let index = 0
	while index < len(a:entries)
		let entry = a:entries[index]
		let this_indent_level = len(substitute(entry, '^\t*\zs.*', '', ''))
		let unindented = substitute(entry, '^'.repeat('\t',a:indent_level), '', '')
		if len(substitute(entry, '^\s*\(.\{-}\)\s*$', '\1', '')) == 0
			" Empty line
		elseif substitute(entry, '^\s*\(.\).*$', '\1', '') == '#'
			" Comment
		elseif this_indent_level < a:indent_level
			" End of indented section
			return {'Index': index, 'Result': result}
		elseif this_indent_level == a:indent_level
			if stridx(unindented, ':') != -1
				let parts = s:SingleSplit(unindented, ':')
				let key = parts[0]
				if ! exists('result')
					let result = {}
				elseif type(result) != type({})
					echoerr type(result)
					echoerr entry
					throw "Dictionary/List mismatch"
				endif
				if len(parts) > 1
					let result[key] = parts[1]
				endif
			else
				if ! exists('result')
					let result = []
				elseif type(result) != type([])
					echoerr entry
					echoerr type(result)
					throw "Dictionary/List mismatch"
				endif
				let result += [unindented]
			endif
		else
			let sublist = a:entries[index :]
			let subindent = a:indent_level + 1
			let parse_results = s:ParseEntries(sublist, subindent)
			if ! exists('result')
				let result = {}
			endif
			if has_key(result, key) &&
						\ (type(result[key]) == type({})) &&
						\ (type(parse_results['Result']) == type({}))
				let result[key] = extend(result[key], parse_results['Result'])
			else
				let result[key] = parse_results['Result']
			endif
			let index += parse_results['Index'] - 1
		endif
		let index += 1
	endwhile
	if ! exists('result')
		let result = {}
	endif
	return {'Index': index, 'Result': result}
endfunction

function! TagHighlight#LoadDataFile#LoadFile(filename)
	let entries = readfile(a:filename)
	let index = match(entries, '^%INCLUDE ')
	while index > -1
		let filename = matchstr(entries[index], '^%INCLUDE\s\+\zs.*')
		let filename = substitute(filename, '\${\(\k\+\)}', '\=eval("$".submatch(1))', 'g')
		let new_entries = entries[:index-1] + readfile(filename) + entries[index+1:]
		let entries = new_entries
		let index = match(entries, '^%INCLUDE ')
	endwhile
	return s:ParseEntries(entries, 0)['Result']
endfunction
