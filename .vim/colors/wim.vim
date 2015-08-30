set background=dark
hi clear
if exists("syntax on")
    syntax reset
endif
let colors_name="wim"

let s:venv="cterm"
let s:bclr=""
let s:fclr=""
let s:dblk="0"
let s:lblk="8"
let s:dred="1"
let s:lred="9"
let s:dgrn="2"
let s:lgrn="10"
let s:dylw="3"
let s:lylw="11"
let s:dblu="4"
let s:lblu="12"
let s:dmag="5"
let s:lmag="13"
let s:dcyn="6"
let s:lcyn="14"
let s:dwht="7"
let s:lwht="15"

fun! s:HI(group, bg, fg, attr)
    exec "hi" a:group
                \ . " " . (a:bg   != "" ? s:venv . "bg=" . a:bg   : "")
                \ . " " . (a:fg   != "" ? s:venv . "fg=" . a:fg   : "")
                \ . " " . (a:attr != "" ? s:venv . "="   . a:attr : "")
endfun

call s:HI(         "Normal", s:bclr, s:lwht,     "" )
call s:HI(         "Ignore",     "", s:lblk,     "" )
call s:HI(        "Comment",     "", s:dwht,     "" )
call s:HI(         "LineNr",     "233", s:lblk,     "" )
call s:HI(          "Float",     "", s:dylw,     "" )
call s:HI(        "Include",     "", s:dmag,     "" )
call s:HI(         "Define",     "", s:dgrn,     "" )
call s:HI(          "Macro",     "", s:lmag,     "" )
call s:HI(        "PreProc",     "", s:lgrn,     "" )
call s:HI(      "PreCondit",     "", s:lmag,     "" )
call s:HI(        "NonText",     "", s:dcyn,     "" )
call s:HI(      "Directory",     "", s:dcyn,     "" )
call s:HI(     "SpecialKey",     "", s:lylw,     "" )
call s:HI(           "Type",     "", s:dcyn,     "bold" )
call s:HI(         "String",     "", s:dgrn,     "" )
call s:HI(       "Constant",     "", s:lmag,     "" )
call s:HI(        "Special",     "", s:lgrn,     "" )
call s:HI(    "SpecialChar",     "", s:lred,     "" )
call s:HI(         "Number",     "", s:lcyn,     "" )
call s:HI(     "Identifier",     "", s:lmag,     "" )
call s:HI(    "Conditional",     "", s:lcyn,     "" )
call s:HI(         "Repeat",     "", s:lcyn,     "" )
call s:HI(      "Statement",     "", s:dblu,     "bold" )
call s:HI(     "StatusLine",     "", s:dblu,     "bold" )
call s:HI(          "Label",     "", s:lmag,     "" )
call s:HI(       "Operator",     "", s:dylw,     "" )
call s:HI(        "Keyword",     "", s:dcyn,     "" )
call s:HI(   "StorageClass",     "", s:lylw,     "" )
call s:HI(      "Structure",     "", s:dmag,     "" )
call s:HI(        "Typedef",     "", s:dcyn,     "" )
call s:HI(       "Function",     "", s:lylw,     "" )
call s:HI(      "Exception",     "", s:dred,     "" )
call s:HI(     "Underlined",     "", s:dblu,     "" )
call s:HI(          "Title",     "", s:dylw,     "" )
call s:HI(            "Tag",     "", s:lylw,     "" )
call s:HI(      "Delimiter",     "", s:lblu,     "" )
call s:HI( "SpecialComment",     "", s:lred,     "" )
call s:HI(        "Boolean",     "", s:dylw,     "" )
call s:HI(           "Todo", "NONE", s:lred,     "" )
call s:HI(        "MoreMsg", "NONE", s:lmag,     "" )
call s:HI(        "ModeMsg", "NONE", s:lmag,     "" )
call s:HI(          "Debug", "NONE", s:dred,     "" )
call s:HI(     "MatchParen", s:dwht, s:dblk,     "" )
call s:HI(       "ErrorMsg", "NONE", 250,  "" )
call s:HI(       "WildMenu", s:lwht, s:dmag,     "" )
call s:HI(         "Folded", 32, s:dwht,     "" )
call s:HI(         "Search", 89,  251,     "bold,underline" )
call s:HI(      "IncSearch", 62, s:dwht,     "" )
call s:HI(     "WarningMsg", "NONE", 250,     "" )
call s:HI(       "Question", "NONE", s:lgrn,     "" )
call s:HI(         "Visual", 62, s:dwht,     "" )
call s:HI(      "VertSplit", s:lblk, s:dblk,     "" )
call s:HI(        "TabLine", s:dblk, s:dwht,     "" )
call s:HI(    "TabLineFill",     "", s:dblk,     "" )
call s:HI(     "TabLineSel", s:dblk, s:dwht,     "" )
call s:HI(     "CursorLine", 234,     "", "none" )
call s:HI(   "CursorColumn", s:dblk,     "",     "" )
call s:HI(    "ColorColumn", s:lblk,     "",     "" )
call s:HI(     "FoldColumn", "NONE", s:lblk,     "" )
call s:HI(     "SignColumn", "NONE",     "",     "" )
call s:HI(   "CursorLineNr", s:dblk,     s:lylw,     "" )

call s:HI( "vimCommentTitle",     "", s:lgrn, "" )
call s:HI(         "vimFold", s:lwht, s:dblk, "" )

" help file colors {{{
call s:HI( "helpHyperTextJump", "", s:lylw, "" )

call s:HI( "javaScriptNumber", "", s:lylw, "" )

call s:HI(     "htmlTag", "", s:dcyn, "" )
call s:HI(  "htmlEndTag", "", s:dcyn, "" )
call s:HI( "htmlTagName", "", s:lylw, "" )

call s:HI(        "perlSharpBang", "", s:lgrn, "standout" )
call s:HI(        "perlStatement", "", s:lmag,         "" )
call s:HI( "perlStatementStorage", "", s:dred,         "" )
call s:HI(         "perlVarPlain", "", s:dylw,         "" )
call s:HI(        "perlVarPlain2", "", s:lylw,         "" )

call s:HI( "rubySharpBang", "", s:lgrn, "standout" )

call s:HI(    "diffLine", "", s:lgrn, "" )
call s:HI( "diffOldLine", "", s:dgrn, "" )
call s:HI( "diffOldFile", "", s:dgrn, "" )
call s:HI( "diffNewFile", "", s:dgrn, "" )
call s:HI(   "diffAdded", "", s:dblu, "" )
call s:HI( "diffRemoved", "", s:dred, "" )
call s:HI( "diffChanged", "", s:dcyn, "" )

if has("spell")
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellRare
    hi clear SpellLocal
    call s:HI(   "SpellBad", "", "", "underline" )
    call s:HI(   "SpellCap", "", "", "underline" )
    call s:HI(  "SpellRare", "", "", "underline" )
    call s:HI( "SpellLocal", "", "", "underline" )
endif

hi Error                 ctermfg=162 ctermbg=127

hi Pmenu    ctermfg=253 ctermbg=234
hi PmenuSel ctermfg=255 ctermbg=200
hi PmenuSbar ctermbg=black guibg=black
hi PmenuThumb ctermbg=darkgreen guibg=darkgreen

syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>" contains=@Spell
syn region texZone start="\\begin{minted}" end="\\end{minted}\|%stopzone\>" contains=@Spell

" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)
" vim: foldenable foldmethod=marker foldmarker={{{,}}} foldlevel=0:

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

hi Function     ctermfg=NONE ctermbg=NONE
hi cFunctionTag ctermfg=NONE ctermbg=NONE
hi link DeclRefExpr Normal
