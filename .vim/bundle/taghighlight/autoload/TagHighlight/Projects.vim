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
	if &cp || v:version < 700 || (exists('g:loaded_TagHLProjects') && (g:plugin_development_mode != 1))
		throw "Already loaded"
	endif
catch
	finish
endtry
let g:loaded_TagHLProjects = 1

function! TagHighlight#Projects#GetProjects()
	let projects = TagHighlight#Option#GetOption('Projects')
	call TagHLDebug("Projects option set to ".string(projects), "Information")
	for project in keys(projects)
		if type(projects[project]) == type("")
			projects[project] = {'SourceDir': projects[project]}
		elseif type(projects[project]) == type({}) && 
					\ has_key(projects[project], 'SourceDir')
			" Okay
		else
			call TagHLDebug("Invalid entry '".project."' in Projects list (no SourceDir)", "Warning")
			call remove(projects, project)
		endif
	endfor
	return projects
endfunction

function! TagHighlight#Projects#IsProject(name)
	let projects = TagHighlight#Projects#GetProjects()
	return has_key(projects, a:name)
endfunction

function! TagHighlight#Projects#GetProject(name)
	let projects = TagHighlight#Projects#GetProjects()
	return projects[a:name]
endfunction

function! TagHighlight#Projects#LoadProjectOptions(file)
	call TagHLDebug("Looking for project options for " . a:file, "Information")
	let full_path = fnamemodify(a:file, ':p')
	let projects = TagHighlight#Projects#GetProjects()
	if ! exists('b:TagHighlightSettings')
		let b:TagHighlightSettings = {}
	endif

	let b:TagHighlightPrivate['InProject'] = 0
	for name in keys(projects)
		let project = projects[name]
		if TagHighlight#Utilities#FileIsIn(full_path, project['SourceDir'])
			call TagHLDebug("Found project: '".name."'", "Information")
			let b:TagHighlightSettings = extend(b:TagHighlightSettings, project)
			let b:TagHighlightPrivate['InProject'] = 1
			let b:TagHighlightPrivate['ProjectName'] = name
			break
		endif
	endfor
	if ! b:TagHighlightPrivate['InProject']
		call TagHLDebug("Not in project: '".a:file."'", "Information")
		let npo = TagHighlight#Option#GetOption("NonProjectOptions")
		let b:TagHighlightSettings = extend(b:TagHighlightSettings, npo)
	endif
endfunction
