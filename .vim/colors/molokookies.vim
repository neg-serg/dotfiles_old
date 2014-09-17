" Vim color file
"
" Author:   Kanakarakis c00kiemon5ter Ivan
" URL:      https://github.com/c00kiemon5ter
"

hi clear
set background=dark

if exists("syntax on")
	syntax reset
endif

let g:colors_name="c00kiez"



" ========== Default Groups ==========

hi Normal            cterm=none          ctermfg=none         ctermbg=none
if &t_Co > 16
	hi Normal        cterm=none          ctermfg=none         ctermbg=235
endif
" Conceal
" Cursor
" CursorIM
hi ColorColumn       cterm=none          ctermfg=none         ctermbg=0
hi CursorColumn      cterm=none          ctermfg=none         ctermbg=0
hi CursorLine        cterm=none          ctermfg=none         ctermbg=236
hi CursorLineNr      cterm=none          ctermfg=3            ctermbg=0
hi SignColumn        cterm=none          ctermfg=none         ctermbg=0
hi LineNr            cterm=none          ctermfg=none         ctermbg=0
hi DiffAdd           cterm=none          ctermfg=7            ctermbg=4
hi DiffDelete        cterm=none          ctermfg=5            ctermbg=5
hi DiffChange        cterm=none          ctermfg=1            ctermbg=3
hi DiffText          cterm=none          ctermfg=0            ctermbg=3
hi ErrorMsg          cterm=none          ctermfg=none         ctermbg=1
hi Directory         cterm=none          ctermfg=6            ctermbg=none
hi VertSplit         cterm=none          ctermfg=3            ctermbg=none
hi Folded            cterm=none          ctermfg=3            ctermbg=0
hi FoldColumn        cterm=none          ctermfg=3            ctermbg=0
hi IncSearch         cterm=none          ctermfg=7            ctermbg=3
hi Search            cterm=none          ctermfg=0            ctermbg=3
hi MatchParen        cterm=none          ctermfg=7            ctermbg=6
hi ModeMsg           cterm=none          ctermfg=3            ctermbg=none
hi MoreMsg           cterm=none          ctermfg=3            ctermbg=none
hi NonText           cterm=none          ctermfg=6            ctermbg=none
hi Pmenu             cterm=none          ctermfg=none         ctermbg=4
hi PmenuSel          cterm=none          ctermfg=0            ctermbg=2
hi PmenuSbar         cterm=none          ctermfg=none         ctermbg=4
hi PmenuThumb        cterm=none          ctermfg=0            ctermbg=3
hi Question          cterm=none          ctermfg=3            ctermbg=none
hi SpecialKey        cterm=none          ctermfg=6            ctermbg=none
hi TabLine           cterm=none          ctermfg=none         ctermbg=4
hi TabLineFill       cterm=none          ctermfg=none         ctermbg=4
hi TabLineSel        cterm=none          ctermfg=3            ctermbg=4
hi Title             cterm=none          ctermfg=2            ctermbg=none
hi StatusLine        cterm=none          ctermfg=3            ctermbg=4
hi StatusLineNC      cterm=none          ctermfg=none         ctermbg=4
hi WildMenu          cterm=none          ctermfg=none         ctermbg=5
hi Visual            cterm=none          ctermfg=7            ctermbg=1
hi VisualNOS         cterm=none          ctermfg=7            ctermbg=5
hi WarningMsg        cterm=bold          ctermfg=none         ctermbg=1

if has("spell")
	hi clear SpellBad
	hi clear SpellCap
	hi clear SpellRare
	hi clear SpellLocal
	hi SpellBad      cterm=underline     ctermfg=1            ctermbg=none
	hi SpellCap      cterm=underline     ctermfg=6            ctermbg=none
	hi SpellLocal    cterm=underline     ctermfg=6            ctermbg=none
	hi SpellRare     cterm=underline     ctermfg=3            ctermbg=none
endif



" ========== Major / Minor Groups ==========

hi Constant          cterm=none       ctermfg=3
high String          cterm=bold       ctermfg=2
high Boolean         cterm=bold       ctermfg=5
high Character       cterm=bold       ctermfg=1
" high Number          cterm=none       ctermfg=3
" high Float           cterm=none       ctermfg=3

hi Identifier        cterm=none       ctermfg=6
high Function        cterm=none       ctermfg=3

hi Statement         cterm=bold       ctermfg=5
" high Conditional     cterm=none       ctermfg=2
high Repeat          cterm=none       ctermfg=1
high Label           cterm=bold       ctermfg=3
high Operator        cterm=bold       ctermfg=3
high Exception       cterm=bold       ctermfg=1
" high Keyword         cterm=bold       ctermfg=3

hi PreProc           cterm=none       ctermfg=2
high Macro           cterm=bold       ctermfg=6
" high Include         cterm=bold       ctermfg=0
" high Define          cterm=none       ctermfg=6
" high PreCondit       cterm=bold       ctermfg=6

hi Type              cterm=none       ctermfg=6
high StorageClass    cterm=none       ctermfg=3
high Structure       cterm=none       ctermfg=5
high Typedef         cterm=bold       ctermfg=5

hi Special           cterm=bold       ctermfg=1
" high Tag             cterm=bold       ctermfg=1
" high SpecialChar     cterm=bold       ctermfg=1
" high SpecialComment  cterm=bold       ctermfg=1
" high Delimiter       cterm=none       ctermfg=1
" high Debug           cterm=none       ctermfg=1

hi Error             cterm=underline  ctermfg=1               ctermbg=none
hi Comment           cterm=bold       ctermfg=DarkGray
if &t_Co > 16
	hi Comment           cterm=bold       ctermfg=59
endif
hi Ignore            cterm=none       ctermfg=0
hi Underlined        cterm=underline  ctermfg=3               ctermbg=none
hi Todo              cterm=none       ctermfg=5               ctermbg=3

