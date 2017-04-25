set background=dark
hi clear
if exists("syntax on")
    syntax reset
endif

hi! Normal ctermbg=NONE ctermfg=NONE cterm=NONE
hi! Ignore ctermbg=NONE ctermfg=8 cterm=NONE
hi! Comment ctermbg=NONE ctermfg=7 cterm=NONE
hi! SpecialComment ctermbg=NONE ctermfg=7 cterm=underline
hi! LineNr  ctermbg=233 ctermfg=8 cterm=NONE
hi! Float ctermbg=NONE ctermfg=3 cterm=NONE 
hi! Include ctermbg=NONE ctermfg=5 cterm=NONE 
hi! Define ctermbg=NONE ctermfg=2 cterm=NONE 
hi! Macro ctermbg=NONE ctermfg=13 cterm=NONE 
hi! PreProc ctermbg=NONE ctermfg=10 cterm=NONE 
hi! PreCondit ctermbg=NONE ctermfg=13 cterm=NONE 
hi! NonText ctermbg=NONE ctermfg=6 cterm=NONE 
hi! Directory ctermbg=NONE ctermfg=6 cterm=NONE 
hi! SpecialKey ctermbg=NONE ctermfg=11 cterm=NONE 
hi! Type ctermbg=NONE ctermfg=6 cterm=bold
hi! String ctermbg=NONE ctermfg=2 cterm=NONE 
hi! Constant ctermbg=NONE ctermfg=13 cterm=NONE 
hi! Special ctermbg=NONE ctermfg=10 cterm=NONE 
hi! SpecialChar ctermbg=NONE ctermfg=30 cterm=NONE 
hi! Number ctermbg=NONE ctermfg=14 cterm=NONE 
hi! Identifier ctermbg=NONE ctermfg=13 cterm=NONE 
hi! Conditional ctermbg=NONE ctermfg=14 cterm=NONE 
hi! Repeat ctermbg=NONE ctermfg=14 cterm=NONE 
hi! Statement ctermbg=NONE ctermfg=4 cterm=bold
hi! StatusLine ctermbg=NONE ctermfg=4 cterm=bold
hi! StatusLineNC cterm=NONE ctermfg=NONE ctermbg=NONE
hi! VertSplit cterm=NONE ctermfg=0 ctermbg=0
hi! Label ctermbg=NONE ctermfg=13 cterm=NONE 
hi! Operator ctermbg=NONE ctermfg=6 cterm=bold
hi! Keyword ctermbg=NONE ctermfg=6 cterm=NONE 
hi! StorageClass ctermbg=NONE ctermfg=31 cterm=NONE 
hi! Structure ctermbg=NONE ctermfg=5 cterm=NONE 
hi! Typedef ctermbg=NONE ctermfg=6 cterm=NONE 
hi! Function ctermbg=NONE ctermfg=222 cterm=NONE
hi! Exception ctermbg=NONE ctermfg=1 cterm=NONE 
hi! Underlined ctermbg=NONE ctermfg=4 cterm=NONE 
hi! Title ctermbg=NONE ctermfg=3 cterm=NONE 
hi! Tag ctermbg=NONE ctermfg=11 cterm=NONE 
hi! Delimiter ctermbg=NONE ctermfg=12 cterm=NONE 
hi! Boolean ctermbg=NONE ctermfg=3 cterm=NONE 
hi! Todo ctermbg=NONE ctermfg=9 cterm=NONE  
hi! MoreMsg ctermbg=NONE ctermfg=13 cterm=NONE 
hi! ModeMsg ctermbg=NONE ctermfg=13 cterm=NONE 
hi! Debug ctermbg=NONE ctermfg=1 cterm=NONE 
hi! MatchParen ctermbg=7 ctermfg=0 cterm=NONE 
hi! ErrorMsg ctermbg=NONE ctermfg=250 cterm=NONE 
hi! WildMenu ctermbg=15 ctermfg=5 cterm=NONE 
hi! Folded ctermbg=32 ctermfg=7 cterm=NONE 
hi! Search ctermbg=89 ctermfg=251 cterm=bold,underline
hi! IncSearch ctermbg=62 ctermfg=7 cterm=NONE 
hi! WarningMsg ctermbg=NONE ctermfg=250 cterm=NONE 
hi! Question ctermbg=NONE ctermfg=10 cterm=NONE 
hi! Visual ctermbg=62 ctermfg=7 cterm=NONE 
hi! TabLine ctermbg=0 ctermfg=7 cterm=NONE 
hi! TabLineFill ctermbg=NONE ctermfg=0 cterm=NONE 
hi! TabLineSel ctermbg=0 ctermfg=7 cterm=NONE 
hi! CursorLine ctermbg=234 ctermfg=NONE cterm=NONE
hi! CursorColumn ctermbg=0 ctermfg=NONE cterm=NONE 
hi! ColorColumn ctermbg=8 ctermfg=NONE cterm=NONE 
hi! FoldColumn ctermbg=NONE ctermfg=8 cterm=NONE 
hi! SignColumn ctermbg=NONE ctermfg=NONE cterm=NONE 
hi! CursorLineNr ctermbg=0 ctermfg=11 cterm=NONE 
hi! vimCommentTitle ctermbg=NONE ctermfg=10 cterm=NONE 
hi! vimFold ctermbg=15 ctermfg=0 cterm=NONE 
hi! helpHyperTextJump ctermbg=NONE ctermfg=11 cterm=NONE 
hi! javaScriptNumber ctermbg=NONE ctermfg=11 cterm=NONE 
hi! htmlTag ctermbg=NONE ctermfg=6 cterm=NONE 
hi! htmlEndTag ctermbg=NONE ctermfg=6 cterm=NONE 
hi! htmlTagName ctermbg=NONE ctermfg=11 cterm=NONE 
hi! perlSharpBang ctermbg=NONE ctermfg=10 cterm=standout
hi! perlStatement ctermbg=NONE ctermfg=13 cterm=NONE 
hi! perlStatementStorage ctermbg=NONE ctermfg=1 cterm=NONE 
hi! perlVarPlain ctermbg=NONE ctermfg=3 cterm=NONE 
hi! perlVarPlain2 ctermbg=NONE ctermfg=11 cterm=NONE 
hi! rubySharpBang ctermbg=NONE ctermfg=10 cterm=standout
hi! link Conceal Operator

hi! clear DiffAdd
hi! clear DiffAdded
hi! clear DiffRemoved
hi! clear DiffChange
hi! clear DiffDelete
hi! clear DiffText

hi! DiffAdd ctermfg=15 ctermbg=225 cterm=NONE 
hi! DiffChange cterm=NONE ctermfg=15 ctermbg=228  
hi! DiffText cterm=NONE ctermbg=NONE ctermfg=7 
hi! DiffDelete ctermfg=162 ctermbg=127 cterm=NONE 

hi! link DiffRemoved Constant
hi! link DiffAdded String

hi! Error ctermfg=162 ctermbg=127

if !has("ololo")
    hi! Pmenu ctermfg=253 ctermbg=234
    hi! PmenuSel ctermfg=255 ctermbg=200
    hi! PmenuSbar ctermbg=black
    hi! PmenuThumb ctermbg=darkgreen
else
    hi! Pmenu ctermfg=208 ctermbg=204
    hi! PmenuSel ctermfg=209 ctermbg=206
    hi! PmenuSbar ctermfg=NONE ctermbg=204
    hi! PmenuThumb ctermfg=206 ctermbg=NONE

endif

if has("spell")
    hi! clear SpellBad
    hi! clear SpellCap
    hi! clear SpellRare
    hi! clear SpellLocal
endif

syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>" contains=@Spell
syn region texZone start="\\begin{minted}" end="\\end{minted}\|%stopzone\>" contains=@Spell

if exists( 'g:loaded_operator_highlight' )
  finish
else
  let g:loaded_operator_highlight = 1
endif

if !exists( 'g:ophigh_color' )
  let g:ophigh_color = 22
endif

if !exists( 'g:ophigh_filetypes_to_ignore' )
  let g:ophigh_filetypes_to_ignore = {}
endif

fun! s:IgnoreFiletypeIfNotSet( file_type )
  if get( g:ophigh_filetypes_to_ignore, a:file_type, 1 )
    let g:ophigh_filetypes_to_ignore[ a:file_type ] = 1
  endif
endfunction

call s:IgnoreFiletypeIfNotSet('help')
call s:IgnoreFiletypeIfNotSet('markdown')
call s:IgnoreFiletypeIfNotSet('qf') " This is for the quickfix window
call s:IgnoreFiletypeIfNotSet('conque_term')
call s:IgnoreFiletypeIfNotSet('diff')
call s:IgnoreFiletypeIfNotSet('html')
call s:IgnoreFiletypeIfNotSet('css')
call s:IgnoreFiletypeIfNotSet('less')
call s:IgnoreFiletypeIfNotSet('xml')
call s:IgnoreFiletypeIfNotSet('tex')
call s:IgnoreFiletypeIfNotSet('notes')
call s:IgnoreFiletypeIfNotSet('jinja')
call s:IgnoreFiletypeIfNotSet('lua')
call s:IgnoreFiletypeIfNotSet('vidir-ls')
call s:IgnoreFiletypeIfNotSet('haskell')
call s:IgnoreFiletypeIfNotSet('text')
call s:IgnoreFiletypeIfNotSet('lisp')

fun! s:HighlightOperators()
  if get( g:ophigh_filetypes_to_ignore, &filetype, 0 )
    return
  endif
  " for the last element of the regex, see :h /\@!
  " basically, searching for "/" is more complex since we want to avoid
  " matching against "//" or "/*" which would break C++ comment highlighting
  syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|)\|(\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"
  exec "hi OperatorChars ctermfg=" . g:ophigh_color
endfunction

au Syntax * call s:HighlightOperators()

hi! Function ctermbg=NONE ctermfg=222 cterm=NONE
hi! cFunctionTag ctermbg=none ctermfg=30 cterm=none 
hi link DeclRefExpr Normal

set background=dark
