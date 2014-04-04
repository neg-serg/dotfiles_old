" Tag Highlighter:
"   Author:  A. S. Budden <abudden _at_ gmail _dot_ com>
" Copyright: Copyright (C) 2013 A. S. Budden
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
	if &cp || v:version < 700 || (exists('g:loaded_TagHLUtilities') && (g:plugin_development_mode != 1))
		throw "Already loaded"
	endif
catch
	finish
endtry
let g:loaded_TagHLUtilities = 1

function! TagHighlight#Utilities#FileIsIn(file, root)
	" Change to use forward slash paths
	let full_path = substitute(fnamemodify(a:file, ':p'), '\\', '/', 'g')
	let full_root = substitute(fnamemodify(a:root, ':p'), '\\', '/', 'g')

	" Win32 isn't case sensitive, so make lower case
	if has("win32")
		let full_path = tolower(full_path)
		let full_root = tolower(full_root)
	endif

	" Make sure root description doesn't end in / (unless it is the root
	" folder)
	while full_root =~ './$'
		let full_root = full_root[:-2]
	endwhile

	" Compare
	if full_root == full_path[:len(full_root)-1]
		return 1
	else
		return 0
	endif
endfunction
