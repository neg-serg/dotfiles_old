set background=dark
highlight clear
let g:colors_name="c98color"

let save_cpo = &cpo
set cpo&vim

" Text {{{1
hi Normal       ctermfg=white       ctermbg=NONE        cterm=NONE

hi Folded       ctermfg=brown       ctermbg=black       cterm=NONE
hi Conceal      ctermfg=None        ctermbg=black       cterm=NONE

hi LineNr       ctermfg=darkgray    ctermbg=black       cterm=NONE
hi CursorLineNr ctermfg=yellow      ctermbg=black       cterm=bold

hi Directory    ctermfg=cyan        ctermbg=NONE        cterm=NONE
hi NonText      ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi SpecialKey   ctermfg=darkgray    ctermbg=NONE        cterm=NONE

hi SpellBad     ctermfg=white       ctermbg=darkred
hi SpellCap     ctermfg=white       ctermbg=darkblue
hi SpellLocal   ctermfg=black       ctermbg=cyan
hi SpellRare    ctermfg=white       ctermbg=darkmagenta

hi DiffAdd      ctermfg=white       ctermbg=darkblue    cterm=NONE
hi DiffChange   ctermfg=black       ctermbg=darkmagenta cterm=NONE
hi DiffDelete   ctermfg=black       ctermbg=red         cterm=bold
hi DiffText     ctermfg=white       ctermbg=green       cterm=bold

" Borders / separators / menus {{{1
hi FoldColumn   ctermfg=lightgray   ctermbg=darkgray    cterm=NONE
hi SignColumn   ctermfg=lightgray   ctermbg=darkgray    cterm=NONE

hi Pmenu        ctermfg=white       ctermbg=darkgray    cterm=NONE
hi PmenuSel     ctermfg=cyan        ctermbg=darkgray    cterm=bold
hi PmenuSbar    ctermfg=black       ctermbg=black       cterm=NONE
hi PmenuThumb   ctermfg=gray        ctermbg=gray        cterm=NONE

hi StatusLine   ctermfg=black       ctermbg=white       cterm=bold
hi StatusLineNC ctermfg=darkgray    ctermbg=white       cterm=NONE
hi WildMenu     ctermfg=white       ctermbg=darkblue    cterm=bold
hi VertSplit    ctermfg=white       ctermbg=white       cterm=NONE

hi TabLine      ctermfg=white       ctermbg=black       cterm=NONE
hi TabLineFill  ctermfg=NONE        ctermbg=black       cterm=NONE
hi TabLineSel   ctermfg=white       ctermbg=black       cterm=bold

" Cursor / dynamic / other {{{1
hi Cursor       ctermfg=black       ctermbg=white       cterm=NONE
hi CursorIM     ctermfg=black       ctermbg=white       cterm=reverse
hi CursorLine   ctermfg=NONE        ctermbg=black       cterm=NONE
hi CursorColumn ctermfg=NONE        ctermbg=black       cterm=NONE

hi Visual       ctermfg=NONE        ctermbg=NONE        cterm=reverse

hi IncSearch    ctermfg=cyan        ctermbg=NONE         cterm=underline,reverse
hi Search       ctermfg=NONE        ctermbg=NONE        cterm=underline

hi MatchParen   ctermfg=blue        ctermbg=NONE         cterm=NONE

" Listings / messages {{{1
hi ModeMsg      ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi Title        ctermfg=red         ctermbg=NONE        cterm=bold
hi Question     ctermfg=green       ctermbg=NONE        cterm=NONE
hi MoreMsg      ctermfg=green       ctermbg=NONE        cterm=NONE
hi ErrorMsg     ctermfg=white       ctermbg=red         cterm=bold
hi WarningMsg   ctermfg=yellow      ctermbg=NONE        cterm=bold

" Syntax highlighting groups {{{1
hi Comment      ctermfg=brown       ctermbg=NONE        cterm=NONE
hi Constant     ctermfg=red         ctermbg=NONE        cterm=NONE
hi Identifier   ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi Statement    ctermfg=green       ctermbg=NONE        cterm=bold
 hi Operator    ctermfg=magenta     ctermbg=NONE        cterm=NONE
hi PreProc      ctermfg=darkblue    ctermbg=NONE        cterm=NONE
hi Type         ctermfg=blue        ctermbg=NONE        cterm=bold
hi Special      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
 hi Delimiter   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Underlined   ctermfg=NONE        ctermbg=NONE        cterm=underline
hi Ignore       ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi Error        ctermfg=white       ctermbg=red         cterm=NONE
hi Todo         ctermfg=black       ctermbg=NONE        cterm=bold

" Manual overrides {{{1
hi link hsExprKeyword Statement
hi link hsStructure Operator
hi link shDerefSimple Identifier

" }}}
let &cpo = save_cpo
