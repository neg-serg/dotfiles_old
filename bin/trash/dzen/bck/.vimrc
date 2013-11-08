"	set number 				" turn on line numbers and highlight colors
	set ruler 				" Always show current positions along the bottom
	set showcmd 				" show the command being typed
	set autoindent 				" autoindent spaces
	set cursorline
"	inoremap ;; <esc>			" fbind ;; to esecape key 
	set t_Co=256				" 256 colors 
	nmap <C-h> <C-w>h			" control h, j, k, l tab navigation
	nmap <C-j> <C-w>j
	nmap <C-k> <C-w>k
	nmap <C-l> <C-w>l
	syntax enable
	set background=dark
	"let g:solarized_termcolors=256
	"let g:solarized_termtrans=1
	colorscheme default
"	colors darkspectrum
"	set nowrap
"	set mouse=a 				" use mouse anywhere
	set autoread 				" Set to auto read when a file is changed from the outside

	filetype plugin indent on
	call pathogen#infect()
	call pathogen#helptags()
"}

" COLORS {
	" syntax highlighting groups
	hi Comment      ctermfg=12
	hi Constant     ctermfg=1 
	hi Identifier   ctermfg=4
	hi Statement    ctermfg=2
	hi PreProc      ctermfg=6
	hi Type         ctermfg=3
	hi Special      ctermfg=5
	hi Underlined   ctermfg=7
	hi Ignore       ctermfg=9
	hi Error        ctermfg=11
	hi Todo         ctermfg=1
	hi Normal ctermfg=none ctermbg=none
	hi NonText ctermfg=0 ctermbg=none
	hi Directory	ctermfg=12

	hi VertSplit	ctermfg=black
	hi StatusLine	ctermfg=white
	hi StatusLineNC	ctermfg=0 

	hi Pmenu ctermfg=10 ctermbg=0
	hi PmenuSel ctermfg=0 ctermbg=14
	hi LineNr ctermfg=0 ctermbg=none
	hi CursorLine ctermfg=none ctermbg=none cterm=none
	hi CursorLineNr ctermfg=none ctermbg=0 
	hi CursorColumn ctermfg=none ctermbg=0
"}


" WORD PROCESSING {
	set formatoptions=1
	set lbr
	set linebreak
	set wrap
	au BufRead,BufNewFile *.todo setfiletype todo


	cabbr wp call Wp()
	fun! Wp()
		set formatoptions=1
		set lbr
		set linebreak
		set wrap
		set nonumber
		nnoremap j gj
		nnoremap k gk
		nnoremap 0 g0
		nnoremap $ g$
		set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:[+],fb:[x],fb:[-]
		set comments +=fb:-
"		set spell spelllang=en_us

	endfu

	" Search for selected text, forwards or backwards.
	vnoremap <silent> * :<C-U>
	  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	  \gvy/<C-R><C-R>=substitute(
	  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	  \gV:call setreg('"', old_reg, old_regtype)<CR>
	vnoremap <silent> # :<C-U>
	  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	  \gvy?<C-R><C-R>=substitute(
	  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	  \gV:call setreg('"', old_reg, old_regtype)<CR>
"}
