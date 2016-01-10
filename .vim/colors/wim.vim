set background=dark
hi clear
if exists("syntax on")
    syntax reset
endif
let colors_name="wim"

hi Normal ctermbg=none ctermfg=15 cterm=none
hi Ignore ctermbg=none ctermfg=8 cterm=none
hi Comment ctermbg=none ctermfg=7 cterm=none
hi LineNr  ctermbg=233 ctermfg=8 cterm=none
hi Float ctermbg=none ctermfg=3 cterm=none 
hi Include ctermbg=none ctermfg=5 cterm=none 
hi Define ctermbg=none ctermfg=2 cterm=none 
hi Macro ctermbg=none ctermfg=13 cterm=none 
hi PreProc ctermbg=none ctermfg=10 cterm=none 
hi PreCondit ctermbg=none ctermfg=13 cterm=none 
hi NonText ctermbg=none ctermfg=6 cterm=none 
hi Directory ctermbg=none ctermfg=6 cterm=none 
hi SpecialKey ctermbg=none ctermfg=11 cterm=none 
hi Type ctermbg=none ctermfg=6 cterm=bold
hi String ctermbg=none ctermfg=2 cterm=none 
hi Constant ctermbg=none ctermfg=13 cterm=none 
hi Special ctermbg=none ctermfg=10 cterm=none 
hi SpecialChar ctermbg=none ctermfg=9 cterm=none 
hi Number ctermbg=none ctermfg=14 cterm=none 
hi Identifier ctermbg=none ctermfg=13 cterm=none 
hi Conditional ctermbg=none ctermfg=14 cterm=none 
hi Repeat ctermbg=none ctermfg=14 cterm=none 
hi Statement ctermbg=none ctermfg=4 cterm=bold
hi StatusLine ctermbg=none ctermfg=4 cterm=bold
hi Label ctermbg=none ctermfg=13 cterm=none 
hi Operator ctermbg=none ctermfg=3 cterm=bold 
hi Keyword ctermbg=none ctermfg=6 cterm=none 
hi StorageClass ctermbg=none ctermfg=11 cterm=none 
hi Structure ctermbg=none ctermfg=5 cterm=none 
hi Typedef ctermbg=none ctermfg=6 cterm=none 
hi Function ctermbg=none ctermfg=11 cterm=none 
hi Exception ctermbg=none ctermfg=1 cterm=none 
hi Underlined ctermbg=none ctermfg=4 cterm=none 
hi Title ctermbg=none ctermfg=3 cterm=none 
hi Tag ctermbg=none ctermfg=11 cterm=none 
hi Delimiter ctermbg=none ctermfg=12 cterm=none 
hi SpecialComment ctermbg=none ctermfg=9 cterm=none 
hi Boolean ctermbg=none ctermfg=3 cterm=none 
hi Todo ctermbg=none ctermfg=9 cterm=none  
hi MoreMsg ctermbg=none ctermfg=13 cterm=none 
hi ModeMsg ctermbg=none ctermfg=13 cterm=none 
hi Debug ctermbg=none ctermfg=1 cterm=none 
hi MatchParen ctermbg=7 ctermfg=0 cterm=none 
hi ErrorMsg ctermbg=none ctermfg=250 cterm=none 
hi WildMenu ctermbg=15 ctermfg=5 cterm=none 
hi Folded ctermbg=32 ctermfg=7 cterm=none 
hi Search ctermbg=89 ctermfg=251 cterm=bold,underline
hi IncSearch ctermbg=62 ctermfg=7 cterm=none 
hi WarningMsg ctermbg=none ctermfg=250 cterm=none 
hi Question ctermbg=none ctermfg=10 cterm=none 
hi Visual ctermbg=62 ctermfg=7 cterm=none 
hi VertSplit ctermbg=8 ctermfg=0 cterm=none 
hi TabLine ctermbg=0 ctermfg=7 cterm=none 
hi TabLineFill ctermbg=none ctermfg=0 cterm=none 
hi TabLineSel ctermbg=0 ctermfg=7 cterm=none 
hi CursorLine ctermbg=234 ctermfg=none cterm=none
hi CursorColumn ctermbg=0 ctermfg=none cterm=none 
hi ColorColumn ctermbg=8 ctermfg=none cterm=none 
hi FoldColumn ctermbg=none ctermfg=8 cterm=none 
hi SignColumn ctermbg=none ctermfg=none cterm=none 
hi CursorLineNr ctermbg=0 ctermfg=11 cterm=none 
hi vimCommentTitle ctermbg=none ctermfg=10 cterm=none 
hi vimFold ctermbg=15 ctermfg=0 cterm=none 
hi helpHyperTextJump ctermbg=none ctermfg=11 cterm=none 
hi javaScriptNumber ctermbg=none ctermfg=11 cterm=none 
hi htmlTag ctermbg=none ctermfg=6 cterm=none 
hi htmlEndTag ctermbg=none ctermfg=6 cterm=none 
hi htmlTagName ctermbg=none ctermfg=11 cterm=none 
hi perlSharpBang ctermbg=none ctermfg=10 cterm=standout
hi perlStatement ctermbg=none ctermfg=13 cterm=none 
hi perlStatementStorage ctermbg=none ctermfg=1 cterm=none 
hi perlVarPlain ctermbg=none ctermfg=3 cterm=none 
hi perlVarPlain2 ctermbg=none ctermfg=11 cterm=none 
hi rubySharpBang ctermbg=none ctermfg=10 cterm=standout
hi DiffAdd cterm=reverse ctermfg=15 ctermbg=227
hi DiffChange cterm=reverse ctermfg=15 ctermbg=228
hi DiffText cterm=reverse ctermfg=7 ctermbg=None
hi! link diffRemoved Constant
hi! link diffAdded String
hi DiffDelete cterm=reverse ctermfg=162 ctermbg=127
hi Error ctermfg=162 ctermbg=127
hi Pmenu ctermfg=253 ctermbg=234
hi PmenuSel ctermfg=255 ctermbg=200
hi PmenuSbar ctermbg=black guibg=black
hi PmenuThumb ctermbg=darkgreen guibg=darkgreen

if has("spell")
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellRare
    hi clear SpellLocal
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

hi Function     ctermfg=none ctermbg=none
hi cFunctionTag ctermfg=none ctermbg=none
hi link DeclRefExpr Normal
