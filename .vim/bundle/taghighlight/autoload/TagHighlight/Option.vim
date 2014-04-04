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
	if &cp || v:version < 700 || (exists('g:loaded_TagHLOption') && (g:plugin_development_mode != 1))
		throw "Already loaded"
	endif
catch
	finish
endtry
let g:loaded_TagHLOption = 1

let s:log_defaults = 1
let g:TagHighlightOptionDefaults = {}

function! TagHighlight#Option#LoadOptionFileIfPresent()
	let option_file = TagHighlight#Find#LocateFile('CONFIG', '')

	" Check whether we've found the option file
	if ! option_file['Exists']
		call TagHLDebug("No project config file", "Information")
		return
	endif

	" Got an option file, load it in:
	let b:TagHighlightConfigFileOptions = TagHighlight#LoadDataFile#LoadFile(option_file['FullPath'])

	return option_file
endfunction

function! TagHighlight#Option#LoadOptions()
	if has_key(g:TagHighlightPrivate, 'PluginOptions')
		return
	endif

	let g:TagHighlightPrivate['PluginOptions'] = []
	let g:TagHighlightPrivate['FullOptionList'] = []
	let options = TagHighlight#LoadDataFile#LoadDataFile('options.txt')

	for option_dest in keys(options)
		if has_key(options[option_dest], 'PythonOnly')
			if (options[option_dest]['PythonOnly'] == 'True') || (options[option_dest]['PythonOnly'] == 1)
				" Skip this one
				continue
			endif
		else
			let option = deepcopy(options[option_dest])
			let option['Destination'] = option_dest
			let g:TagHighlightPrivate['PluginOptions'] += [option]
			let g:TagHighlightPrivate['FullOptionList'] += [option_dest]
		endif
	endfor

endfunction

function! TagHighlight#Option#GetOption(name, ...)
	" Check we've loaded the options
	call TagHighlight#Option#LoadOptions()

	" Optional arguments
	if len(a:000) > 0
		let force_project = a:000[0]
	else
		let force_project = ''
	endif

	" Check this option exists
	let opt_index = index(g:TagHighlightPrivate['FullOptionList'], a:name)
	if opt_index < 0
		throw "Unrecognised option:" .a:name
	endif
	let option = g:TagHighlightPrivate['PluginOptions'][opt_index]

	" Option priority (highest first):
	" * project options (if force_project specified)
	" * buffer dictionary,
	" * config file dictionary
	" * global dictionary,
	let option_priority = ["g:TagHighlightSettings","b:TagHighlightConfigFileOptions","b:TagHighlightSettings"]
	if len(force_project) > 0
		let project_options = TagHighlight#Projects#GetProject(force_project)
		let option_priority = ["project_options"] + option_priority
	endif
	for var in option_priority
		if exists(var)
			exe 'let present = has_key(' . var . ', a:name)'
			if present
				exe 'let opt = ' . var . '[a:name]'
			endif
		endif
	endfor

	if ! exists('opt')
		" We haven't found it, return the default
		" Special cases first
		if a:name == "DefaultDirModePriority"
			if TagHighlight#Option#GetOption("Recurse")
				let opt = ["Explicit","UpFromFile","CurrentDirectory"]
			else
				let opt = ["FileDirectory"]
			endif
		else
			" Normal case
			let opt = option['Default']
		endif
	else
	endif

	if option['Type'] =~ 'list'
		let result = []
		if type(opt) == type('')
			if opt == '[]' || opt == ''
				let parsed_opt = []
			else
				let parsed_opt = [opt]
			endif
		else
			let parsed_opt = opt
		endif
		for part in parsed_opt
			if part =~ '^OPT(\k\+)$'
				let value_name = part[4:len(part)-2]
				let result += [TagHighlight#Option#GetOption(value_name)]
			else
				let result += [part]
			endif
		endfor
	elseif option['Type'] == 'bool'
		if opt =~ 'True' || opt == 1
			let result = 1
		elseif opt =~ 'False' || opt == 0
			let result = 0
		else
			throw "Unrecognised bool value"
		endif
	elseif option['Type'] == 'string'
		if opt =~ '^OPT(\k\+)$'
			let value_name = opt[4:len(opt)-2]
			let result = TagHighlight#Option#GetOption(value_name)
		else
			let result = opt
		endif
	elseif option['Type'] == 'dict'
		" This is a complex one: just assume it's valid Vim script
		if type(opt) == type([])
			" Probably a multi-entry dict that has automatically been
			" split: rejoin
			let result = eval(join(opt, ', '))
		elseif type(opt) == type("")
			let result = eval(opt)
		else
			let result = opt
		endif
	elseif option['Type'] == 'int'
		let result = str2nr(opt)
	endif
	return result
endfunction

function! TagHighlight#Option#CopyOptions()
	let result = {}
	for var in ["g:TagHighlightSettings","b:TagHighlightConfigFileOptions","b:TagHighlightSettings"]
		if exists(var)
			for key in keys(eval(var))
				if type(eval(var)[key]) == type([])
					let result[key] = eval(var)[key][:]
				elseif type(eval(var)[key]) == type({})
					let result[key] = deepcopy(eval(var)[key])
				else
					let result[key] = eval(var)[key]
				endif
			endfor
		endif
	endfor
	return result
endfunction
