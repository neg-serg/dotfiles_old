set background=dark
hi clear
if exists("syntax on")
    syntax reset
endif
let colors_name="wim"

let s:g_col0   = "#020202"
let s:g_col8   = "#5E5E5E"
let s:g_col1   = "#8A2F58"
let s:g_col9   = "#CF4F88"
let s:g_col2   = "#287373"
let s:g_col10  = "#53A6A6"
let s:g_col3   = "#914E89"
let s:g_col11  = "#BF85CC"
let s:g_col4   = "#395573"
let s:g_col12  = "#4779B3"
let s:g_col5   = "#5E468C"
let s:g_col13  = "#7F62B3"
let s:g_col6   = "#2B7694"
let s:g_col14  = "#47959E"
let s:g_col7   = "#899CA1"
let s:g_col15  = "#C0C0C0"
let s:g_col108 = "#4C407C"
let s:g_col17  = "#002b36"
let s:g_col18  = "#073642"
let s:g_col222 = "#5c9caa"
let s:g_col226 = "#6D0031"
let s:g_col227 = "#006D39"
let s:g_col228 = "#00406D"
let s:g_col229 = "#ED0022"
let s:g_col218 = "#00ED85"
let s:g_col219 = "#008BED"
let s:g_col17  = "#002b36"
let s:g_col18  = "#073642"
let s:g_col22  = "#2b768d"
let s:g_col30  = "#008686"
let s:g_col31  = "#0086ae"
let s:g_col32  = "#002b36"
let s:g_col62  = "#002B36"
let s:g_col64  = "#003623"
let s:g_col77  = "#2e8b57"
let s:g_col89  = "#232030"
let s:g_col124 = "#920000"
let s:g_col125 = "#680020"
let s:g_col126 = "#780000"
let s:g_col127 = "#5f0000"
let s:g_col162 = "#cc6666"
let s:g_col164 = "#4F4C75"
let s:g_col200 = "#315C70"
let s:g_col215 = "#184454"
let s:g_col220 = "#0f141a"
let s:g_col221 = "#265360"
let s:g_col222 = "#5c9caa"
let s:g_col223 = "#091f2c"
let s:g_col224 = "#10151b"
let s:g_col225 = "#25533f"
let s:g_col230 = "#eee8d5"
let s:g_col231 = "#fdfdfd"
let s:g_col232 = "#262626"
let s:g_col233 = "#040404"
let s:g_col234 = "#080808"
let s:g_col235 = "#373b41"
let s:g_col239 = "#121212"
let s:g_col240 = "#151515"
let s:g_col244 = "#586e75"
let s:g_col250 = "#666666"
let s:g_col251 = "#afa0f0"
let s:g_col253 = "#c5c8c6"

exe "hi! Normal ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=".s:g_col15." gui=NONE"
exe "hi! Ignore ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE  guifg=".s:g_col8." gui=NONE"
exe "hi! Comment ctermbg=NONE  ctermfg=7 cterm=NONE guibg=NONE guifg=".s:g_col7." gui=NONE"
exe "hi! SpecialComment ctermbg=NONE  ctermfg=7 cterm=underline guibg=NONE guifg=".s:g_col7." gui=underline"
exe "hi! LineNr ctermbg=233 ctermfg=8 cterm=NONE guibg=".s:g_col223." guifg=".s:g_col8." gui=NONE"
exe "hi! Float ctermbg=NONE  ctermfg=3 cterm=NONE guibg=NONE guifg=".s:g_col3 . " gui=NONE"
exe "hi! Include ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=".s:g_col5 . " gui=NONE"
exe "hi! Define ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=".s:g_col2 . " gui=NONE"
exe "hi! Macro ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! PreProc ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=".s:g_col10 . " gui=NONE"
exe "hi! PreCondit ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! NonText ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! Directory ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! SpecialKey ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=bold"
exe "hi! Type ctermbg=NONE ctermfg=6 cterm=bold guibg=NONE guifg=".s:g_col6." gui=bold"
exe "hi! String ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=".s:g_col2 . " gui=NONE"
exe "hi! Constant ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! Special ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=".s:g_col10 . " gui=NONE"
exe "hi! SpecialChar ctermbg=NONE ctermfg=30 cterm=NONE guibg=NONE guifg=".s:g_col30 . " gui=NONE"
exe "hi! Number ctermbg=NONE ctermfg=14 cterm=NONE  guibg=NONE guifg=".s:g_col14 . " gui=NONE"
exe "hi! Identifier ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! Conditional ctermbg=NONE ctermfg=14 cterm=NONE  guibg=NONE guifg=".s:g_col14 . " gui=NONE"
exe "hi! Repeat ctermbg=NONE ctermfg=14 cterm=NONE guibg=NONE guifg=".s:g_col14 . " gui=NONE"
exe "hi! Statement ctermbg=NONE ctermfg=4 cterm=bold guibg=NONE guifg=".s:g_col4 . " gui=bold"
exe "hi! StatusLine ctermbg=NONE ctermfg=4 cterm=bold guibg=NONE guifg=".s:g_col4 . " gui=bold"
exe "hi! StatusLineNC cterm=NONE ctermfg=NONE ctermbg=NONE guibg=NONE guifg=NONE gui=NONE"
exe "hi! VertSplit cterm=NONE ctermfg=0 ctermbg=0 guibg=".s:g_col0 ." guifg=".s:g_col0 . " gui=NONE"
exe "hi! Label ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! Operator ctermbg=NONE ctermfg=6 cterm=bold guibg=NONE guifg=".s:g_col6 . " gui=bold"
exe "hi! Keyword  ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! StorageClass ctermbg=NONE  ctermfg=31 cterm=NONE  guibg=NONE guifg=".s:g_col31 . " gui=NONE"
exe "hi! Structure ctermbg=NONE  ctermfg=5 cterm=NONE guibg=NONE guifg=".s:g_col5 . " gui=NONE"
exe "hi! Typedef ctermbg=NONE  ctermfg=6 cterm=NONE  guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! Function ctermbg=NONE  ctermfg=222 cterm=NONE  guibg=NONE  guifg=".s:g_col222 . " gui=NONE"
exe "hi! Exception ctermbg=NONE  ctermfg=1 cterm=NONE guibg=NONE guifg=".s:g_col1 . " gui=NONE"
exe "hi! Underlined ctermbg=NONE  ctermfg=4 cterm=NONE guibg=NONE guifg=".s:g_col4 . " gui=NONE"
exe "hi! Title ctermbg=NONE  ctermfg=3 cterm=NONE guibg=NONE guifg=".s:g_col3 . " gui=NONE"
exe "hi! Tag ctermbg=NONE  ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=NONE"
exe "hi! Delimiter ctermbg=NONE  ctermfg=12 cterm=NONE guibg=NONE guifg=".s:g_col12 . " gui=NONE"
exe "hi! Boolean ctermbg=NONE  ctermfg=3 cterm=NONE guibg=NONE guifg=".s:g_col3 . " gui=NONE"
exe "hi! Todo ctermbg=NONE  ctermfg=9 cterm=NONE guibg=NONE guifg=".s:g_col9 . " gui=NONE"
exe "hi! MoreMsg ctermbg=NONE  ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! ModeMsg ctermbg=NONE  ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! Debug ctermbg=NONE  ctermfg=1 cterm=NONE  guibg=NONE guifg=".s:g_col1 . " gui=NONE"
exe "hi! MatchParen ctermbg=7 ctermfg=0 cterm=NONE  guibg=".s:g_col7." guifg=".s:g_col0 . " gui=NONE"
exe "hi! ErrorMsg ctermbg=NONE ctermfg=250 cterm=NONE guibg=NONE guifg=".s:g_col250 . " gui=NONE"
exe "hi! WildMenu ctermbg=15 ctermfg=5 cterm=NONE guibg=".s:g_col15. " guifg=".s:g_col5 . " gui=NONE"
exe "hi! Folded ctermbg=32 ctermfg=7 cterm=NONE guibg=".s:g_col32. " guifg=".s:g_col7 . " gui=NONE"
exe "hi! Search ctermbg=89 ctermfg=251 cterm=bold,underline guibg=".s:g_col89 . " guifg=".s:g_col251 . " gui=bold,underline"
exe "hi! IncSearch ctermbg=62 ctermfg=7 cterm=NONE guibg=".s:g_col62." guifg=".s:g_col7 . " gui=NONE"
exe "hi! WarningMsg ctermbg=NONE ctermfg=250 cterm=NONE guibg=NONE guifg=".s:g_col250 . " gui=NONE"
exe "hi! Question ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=".s:g_col10 . " gui=NONE"
exe "hi! Visual ctermbg=62 ctermfg=7 cterm=NONE guibg=".s:g_col62. " guifg=".s:g_col7 . " gui=NONE"
exe "hi! VertSplit ctermbg=8 ctermfg=0 cterm=NONE guibg=".s:g_col8. " guifg=".s:g_col0 . " gui=NONE"
exe "hi! TabLine ctermbg=0 ctermfg=7 cterm=NONE guibg=".s:g_col0.  " guifg=".s:g_col7 . " gui=NONE"
exe "hi! TabLineFill ctermbg=NONE ctermfg=0 cterm=NONE guibg=NONE guifg=".s:g_col0 . " gui=NONE"
exe "hi! TabLineSel ctermbg=0 ctermfg=7 cterm=NONE guibg=".s:g_col0." guifg=".s:g_col7 . " gui=NONE"
exe "hi! CursorColumn ctermbg=0 ctermfg=NONE cterm=NONE guibg=".s:g_col0 ." guifg=NONE gui=NONE"
exe "hi! ColorColumn ctermbg=8 ctermfg=NONE cterm=NONE guibg=".s:g_col8." guifg=NONE gui=NONE"
exe "hi! FoldColumn ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=".s:g_col8." gui=NONE"
exe "hi! SignColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE"
exe "hi! CursorLineNr ctermbg=0 ctermfg=11 cterm=NONE guibg=".s:g_col0 ."  guifg=".s:g_col11 . " gui=NONE"
exe "hi! CursorLine  ctermbg=234 ctermfg=NONE cterm=NONE guibg=".s:g_col234." guifg=NONE gui=NONE"
exe "hi! vimCommentTitle ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=" . s:g_col11 . " gui=NONE"
exe "hi! vimFold ctermbg=15 ctermfg=0 cterm=NONE guibg=" . s:g_col15 . " guifg=".s:g_col0 . " gui=NONE"
exe "hi! helpHyperTextJump ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=NONE"
exe "hi! javaScriptNumber ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=NONE"
exe "hi! htmlTag ctermbg=NONE ctermfg=6 cterm=NONE  guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! htmlEndTag ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=".s:g_col6 . " gui=NONE"
exe "hi! htmlTagName ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=NONE"
exe "hi! perlSharpBang ctermbg=NONE ctermfg=10 cterm=standout guibg=NONE guifg=".s:g_col10 . " gui=standout"
exe "hi! perlStatement ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=".s:g_col13 . " gui=NONE"
exe "hi! perlStatementStorage  ctermbg=NONE  ctermfg=1 cterm=NONE  guibg=NONE guifg=". s:g_col1 . " gui=NONE"
exe "hi! perlVarPlain  ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=".s:g_col3 . " gui=NONE"
exe "hi! perlVarPlain2 ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=".s:g_col11 . " gui=NONE"
exe "hi! rubySharpBang ctermbg=NONE ctermfg=10 cterm=standout guibg=NONE guifg=".s:g_col10 . " gui=standout"
exe "hi! link Conceal Operator"

hi! clear DiffAdd
hi! clear DiffAdded
hi! clear DiffRemoved
hi! clear DiffChange
hi! clear DiffDelete
hi! clear DiffText

exe "hi! DiffAdd ctermfg=15 ctermbg=225 cterm=NONE guifg=".s:g_col15." guibg=".s:g_col225 ." gui=NONE"
exe "hi! DiffChange cterm=NONE ctermfg=15 ctermbg=228 guifg=".s:g_col15." guibg=".s:g_col228 ." gui=NONE"
exe "hi! DiffText cterm=NONE ctermbg=NONE ctermfg=7 guibg=NONE guifg=".s:g_col7." gui=NONE"
exe "hi! DiffDelete ctermfg=162 ctermbg=127 cterm=NONE guifg=".s:g_col162." guibg=".s:g_col127." gui=NONE"

exe "hi! link DiffRemoved Constant"
exe "hi! link DiffAdded String"
exe "hi! Error ctermfg=162 ctermbg=127 guifg=".s:g_col162." guibg=".s:g_col127
exe "hi! Pmenu ctermfg=253 ctermbg=234 guifg=".s:g_col253." guibg=".s:g_col234
exe "hi! PmenuSel ctermfg=255 ctermbg=200 guifg=#ffffff guibg=".s:g_col200
exe "hi! PmenuSbar ctermbg=black guibg=#000000"
exe "hi! PmenuThumb ctermbg=darkgreen guibg=".s:g_col2

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
