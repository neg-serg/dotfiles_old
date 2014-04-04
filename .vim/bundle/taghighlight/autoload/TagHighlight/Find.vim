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
	if &cp || v:version < 700 || (exists('g:loaded_TagHLFind') && (g:plugin_development_mode != 1))
		throw "Already loaded"
	endif
catch
	finish
endtry
let g:loaded_TagHLFind = 1

" Tools for finding files.  When generating the tags and types file, we need
" to decide where to place it.  If the user has configured the mode in which
" everything is based on the current directory (which works well with the
" project plugin), the current directory is what we use.  If the user wants to
" search up for a tags file, we can look for an existing tags file and stop
" when we find one, starting either from the current directory or source
" directory.  If we don't, either use the current directory or the source file
" directory (configuration).
"
" It should also be possible to place the tags file in a remote location and
" use either the current directory, source directory or explicitly set
" directory for the base of the scan.

" Option structure:
"
" [gb]:TagHighlightSettings:
"	DefaultDirModePriority:[Explicit,UpFromCurrent,UpFromFile,CurrentDirectory,FileDirectory]
"	TagFileDirModePriority:["Default"] or as above
"	TypesFileDirModePriority:As tag file
"	ConfigFileDirModePriority:As tag file
"	CscopeFileDirModePriority:As tag file
"	DefaultDirModeSearchWildcard:'' (look for tags file) or something specific (*.uvopt)?
"	MaxDirSearchLevels: (integer)
"
" Explicit Locations:
"
"  [gb]:TagHighlightSettings:
"    TagFileDirectory:str (NONE)
"    TagFileName:str (tags)
"    TypesFileDirectory:str (NONE)
"    TypesPrefix:str (types)
"    ProjectConfigFileName:str (taghl_config.txt)
"    ProjectConfigFileDirectory:str (NONE)
"    CscopeFileName: str (cscope.out)
"    CscopeFileDirectory: str (NONE)

function! TagHighlight#Find#LocateFile(which, suffix, ...)
	call TagHLDebug("Locating file " . a:which . " with suffix " . a:suffix, 'Information')
	
	" Optional arguments
	if len(a:000) > 0
		let force_project = a:000[0]
	else
		let force_project = ''
	endif

	" a:which is 'TAGS', 'TYPES', 'CONFIG'
	let default_priority = TagHighlight#Option#GetOption('DefaultDirModePriority', force_project)
	call TagHLDebug("Priority: " . string(default_priority), "Information")
	let default_search_wildcards = TagHighlight#Option#GetOption('DefaultDirModeSearchWildcards', force_project)

	if len(force_project) > 0
		let file = TagHighlight#Option#GetOption('SourceDir', force_project) . '/dummy.txt'
	else
		let file = expand('<afile>')
		if len(file) == 0
			let file = expand('%')
		endif
	endif

	if a:which == 'TAGS'
		" Suffix is ignored here
		let filename = TagHighlight#Option#GetOption('TagFileName', force_project)
		let search_priority = TagHighlight#Option#GetOption('TagFileDirModePriority', force_project)
		let explicit_location = TagHighlight#Option#GetOption('TagFileDirectory', force_project)
		let search_wildcards = TagHighlight#Option#GetOption('TagFileSearchWildcards', force_project)
	elseif a:which == 'TYPES'
		if tolower(a:suffix) == 'all'
			let search_suffix = '*'
		else
			let search_suffix = a:suffix
		endif
		let filename = TagHighlight#Option#GetOption('TypesFilePrefix', force_project) . '_' .
					\ search_suffix . "." .
					\ TagHighlight#Option#GetOption('TypesFileExtension', force_project)
		let search_priority = TagHighlight#Option#GetOption('TypesFileDirModePriority', force_project)
		let explicit_location = TagHighlight#Option#GetOption('TypesFileDirectory', force_project)
		let search_wildcards = TagHighlight#Option#GetOption('TypesFileSearchWildcards', force_project)
	elseif a:which == 'CONFIG'
		" Suffix is ignored here
		let filename = TagHighlight#Option#GetOption('ProjectConfigFileName', force_project)
		let search_priority = TagHighlight#Option#GetOption('ProjectConfigFileDirModePriority', force_project)
		let explicit_location = TagHighlight#Option#GetOption('ProjectConfigFileDirectory', force_project)
		let search_wildcards = TagHighlight#Option#GetOption('ProjectConfigFileSearchWildcards', force_project)
	elseif a:which == 'CSCOPE'
		" Suffix is ignored here
		let filename = TagHighlight#Option#GetOption('CscopeFileName', force_project)
		let search_priority = TagHighlight#Option#GetOption('CscopeFileDirModePriority', force_project)
		let explicit_location = TagHighlight#Option#GetOption('CscopeFileDirectory', force_project)
		let search_wildcards = TagHighlight#Option#GetOption('CscopeFileSearchWildcards', force_project)
	else
		throw "Unrecognised file"
	endif

	if search_wildcards[0] == 'Default'
		let search_wildcards = default_search_wildcards
	endif

	if search_priority[0] == 'Default'
		let search_priority = default_priority
	endif

	" Ensure there's no trailing slash on 'explicit location'
	if explicit_location[len(explicit_location)-1] == '/'
		let explicit_location = explicit_location[:len(explicit_location)-2]
	endif

	" Result contains 'Found','FullPath','Directory','Filename','Exists']
	let result = {}

	if TagHighlight#Option#GetOption('UseProjectRepository', force_project)
		call TagHLDebug("UseProjectRepository is set", "Information")
		let repository = TagHighlight#Option#GetOption('ProjectRepository', force_project)
		if len(repository) > 0 && tolower(repository) != "none"
			if len(force_project) > 0 || (has_key(b:TagHighlightPrivate, 'InProject') && b:TagHighlightPrivate['InProject'])
				if len(force_project) > 0
					let project_name = force_project
				else
					let project_name = b:TagHighlightPrivate['ProjectName']
				endif
				let project_folder = repository
							\ . '/'
							\ . s:SanitiseName(project_name)
				if ! isdirectory(project_folder)
					" At the moment, if the repository setting is garbage,
					" this will throw up an error message, but I'm not sure
					" whether it can be caught with try...catch...endtry
					call mkdir(project_folder, 'p')
				endif
				let search_priority = ['Explicit']
				let explicit_location = project_folder
			endif
		endif
	endif

	for search_mode in search_priority
		if search_mode == 'Explicit' && explicit_location != 'None'
			" Use explicit location, overriding everything else
			call TagHLDebug('Using explicit location', 'Information')
			let result['Directory'] = explicit_location
			let result['Filename'] = filename
		elseif search_mode == 'UpFromCurrent'
			" Start in the current directory and search up
			let dir = fnamemodify('.',':p:h')
			let result = s:ScanUp(dir, search_wildcards)
			if has_key(result, 'Directory')
				call TagHLDebug('Found location with UpFromCurrent', 'Information')
				let result['Filename'] = filename
			endif
		elseif search_mode == 'UpFromFile'
			" Start in the directory containing the current file and search up
			let dir = fnamemodify(file,':p:h')
			let result = s:ScanUp(dir, search_wildcards)
			if has_key(result, 'Directory')
				call TagHLDebug('Found location with UpFromFile', 'Information')
				let result['Filename'] = filename
			endif
		elseif search_mode == 'CurrentDirectory'
			call TagHLDebug('Using current directory: ' . fnamemodify('.', ':p:h'), 'Information')
			let result['Directory'] = fnamemodify('.',':p:h')
			let result['Filename'] = filename
		elseif search_mode == 'FileDirectory'
			call TagHLDebug('Using file directory: ' . fnamemodify(file, ':p:h'), 'Information')
			let result['Directory'] = fnamemodify(file,':p:h')
			let result['Filename'] = filename
		endif
		if has_key(result, 'Directory')
			let result['FullPath'] = result['Directory'] . '/' . result['Filename']
			let result['Found'] = 1
			call TagHLDebug('Found file location: ' . result['FullPath'], 'Information')
			if filereadable(result['FullPath'])
				call TagHLDebug('File exists', 'Information')
				let result['Exists'] = 1
			else
				" Handle wildcards
				let expansion = split(glob(result['FullPath'], 1), '\n')
				let wildcard_match = 0
				if len(expansion) > 0
					for entry in expansion
						if filereadable(entry)
							let result['FullPath'] = entry
							let result['Exists'] = 1
							let result['AllEntries'] = expansion
							let wildcard_match = 1
							break
						endif
					endfor
				endif

				if wildcard_match == 0
					call TagHLDebug('File does not exist', 'Information')
					let result['Exists'] = 0
				endif
			endif
			break
		endif
	endfor

	if ! has_key(result, 'Directory')
		call TagHLDebug("Couldn't find path", 'Warning')
		let result = {'Found': 0, 'Exists': 0}
	endif

	return result
endfunction

function! s:ScanUp(dir, wildcards)
	let result = {}
	let max_levels = TagHighlight#Option#GetOption('MaxDirSearchLevels')
	let levels = 0
	let new_dir = a:dir
	let dir = ''
	let found = 0

	call TagHLDebug("Searching up from " . a:dir . " for " . string(a:wildcards), 'Information')

	" new_dir != dir check looks for the root directory
	while new_dir != dir
		let dir = new_dir
		let new_dir = fnamemodify(dir, ':h')
		
		call TagHLDebug("Trying " . dir, "Information")
		for wildcard in a:wildcards
			let glob_pattern = dir
			if glob_pattern[len(glob_pattern)-1] != '/'
				let glob_pattern .= '/'
			endif
			let glob_pattern .= wildcard
			let glob_result = split(glob(glob_pattern), "\n")
			if len(glob_result) > 0
				for r in glob_result
					if filereadable(r)
						let found = 1
					endif
				endfor
				if found
					call TagHLDebug("Found match: " . dir . " (" . glob_pattern . ")", "Information")
					let result['Directory'] = dir
					let found = 1
					break
				else
					call TagHLDebug("Wildcard matches were not readable (directory?)", "Information")
				endif
			endif
		endfor
		if found
			break
		endif

		" Check for recursion limit
		let levels += 1
		if (max_levels > 0) && (levels >= max_levels)
			call TagHLDebug("Hit recursion limit", "Information")
			break
		endif
	endwhile
	if new_dir == dir
		" Must have reached root directory
		call TagHLDebug("Reached root directory and stopped", "Information")
	endif
	return result
endfunction

function! s:SanitiseName(name)
	let validChars = '-a-zA-Z0-9_'
	return substitute(a:name, '[^'.validChars.']', '_', 'g')
endfunction
