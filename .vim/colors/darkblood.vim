" Author: meh.

hi clear

if exists("syntax on")
syntax reset
endif

let g:colors_name = "darkblood"

" make stuff more readable
set fillchars=stl:┴,stlnc:┴,vert:│,fold:\
set listchars=tab:·\ ,trail:░,extends:»,precedes:«
set list

if &term =~ "rxvt"
  silent !echo -ne "\033]12;\#404040\007"
  let &t_SI = "\033]12;\#b21818\007"
  let &t_EI = "\033]12;\#404040\007"
  autocmd VimLeave * :silent !echo -ne "\033]12;\#b21818\007"

  set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
endif

" General colors
hi Normal cterm=none ctermfg=251 ctermbg=none
hi Directory cterm=none ctermfg=red ctermbg=none
hi ErrorMsg cterm=none ctermfg=darkred ctermbg=none
hi NonText cterm=none ctermfg=darkgray ctermbg=none
hi SpecialKey cterm=none ctermfg=236 ctermbg=none
hi LineNr cterm=none ctermfg=darkgrey ctermbg=none
hi IncSearch cterm=bold ctermfg=232 ctermbg=darkred
hi Search cterm=bold ctermfg=232 ctermbg=darkred
hi Visual cterm=none ctermfg=white ctermbg=darkred
hi VisualNOS cterm=none ctermfg=white ctermbg=darkred
hi MoreMsg cterm=bold ctermfg=white ctermbg=none
hi Question cterm=bold ctermfg=white ctermbg=none
hi WarningMsg cterm=none ctermfg=darkred ctermbg=none
hi WildMenu cterm=none ctermfg=white ctermbg=none
hi TabLine cterm=underline ctermfg=white ctermbg=none
hi TabLineSel cterm=underline ctermfg=white ctermbg=darkred
hi TabLineFill cterm=underline ctermfg=white ctermbg=none
hi DiffAdd cterm=none ctermfg=white ctermbg=darkgreen
hi DiffChange cterm=underline ctermfg=none ctermbg=none
hi DiffDelete cterm=none ctermfg=white ctermbg=darkred
hi DiffText cterm=none ctermfg=white ctermbg=none
hi SignColumn cterm=none ctermfg=darkred ctermbg=none
hi VertSplit cterm=none ctermfg=darkred ctermbg=none
hi CursorColumn cterm=none ctermfg=none ctermbg=233
hi CursorLineNr cterm=none ctermfg=none ctermbg=233
hi CursorLine cterm=none ctermfg=none ctermbg=233
hi ColorColumn cterm=none ctermfg=none ctermbg=233
hi Cursor cterm=none ctermfg=white ctermbg=darkred
hi Title cterm=bold ctermfg=white ctermbg=none
hi Pmenu cterm=none ctermfg=none ctermbg=233
hi PmenuSel cterm=bold ctermfg=white ctermbg=darkred
hi PmenuSbar cterm=none ctermfg=233 ctermbg=233
hi PmenuThumb cterm=none ctermfg=darkred ctermbg=darkred
hi Folded cterm=none ctermfg=darkred ctermbg=none
hi FoldColumn cterm=none ctermfg=darkred ctermbg=none
hi MatchParen cterm=reverse ctermfg=none ctermbg=none

" Status line
hi StatusLine cterm=none ctermfg=darkred ctermbg=none
hi StatusLineNC cterm=none ctermfg=darkred ctermbg=black
hi ModeMsg cterm=bold ctermfg=white ctermbg=none

hi User1 cterm=bold ctermfg=white ctermbg=none
hi User2 cterm=none ctermfg=white ctermbg=none
hi User3 cterm=bold ctermfg=237 ctermbg=none
hi User4 cterm=bold ctermfg=220 ctermbg=none
hi User5 cterm=bold ctermfg=34 ctermbg=none
hi User6 cterm=bold ctermfg=160 ctermbg=none

" tty
if &term =~ "linux"
hi TabLine cterm=none ctermfg=white ctermbg=none
hi TabLineSel cterm=none ctermfg=white ctermbg=darkred
hi TabLineFill cterm=none ctermfg=white ctermbg=none
hi StatusLine cterm=none ctermfg=black ctermbg=darkred
hi StatusLineNC cterm=none ctermfg=white ctermbg=none
endif

" syntastic
hi SyntasticError cterm=none ctermfg=white ctermbg=darkred
hi SyntasticWarning cterm=underline ctermfg=white ctermbg=none

" Taglist
hi TagListFileName cterm=none ctermfg=darkred ctermbg=none

" Tagbar
hi TagbarVisibilityPublic cterm=bold ctermfg=white ctermbg=none

" ctrlp
hi CtrlPMatch cterm=underline ctermfg=white ctermbg=none
hi CtrlPStats cterm=none ctermfg=black ctermbg=darkred

" XML
hi link xmlEndTag Function

" Diff
hi diffIdentical cterm=none ctermfg=white ctermbg=none
hi diffAdded cterm=none ctermfg=darkgreen ctermbg=none

" Clojure
hi link clojureKeyword Constant
hi link clojureVariable Identifier
hi link clojureSpecial Keyword

" JavaScript
hi link jsIdentifier Normal

" C
hi link cStructure Keyword
hi link cStorageClass Keyword

" C++
hi link cppStructure Keyword
hi link cppStorageClass Keywords

" Haskell
hi link hsModuleName Type
hi link hsType Type
hi link hsStructure Keyword
hi link hsTypedef Keyword
hi link hsModuleStartLabel Keyword
hi link hsImportLabel Keyword

" gitgutter
hi GitGutterAdd cterm=none ctermfg=2 ctermbg=none
hi GitGutterChange cterm=none ctermfg=220 ctermbg=none
hi GitGutterDelete cterm=none ctermfg=1 ctermbg=none
hi GitGutterChangeDelete cterm=none ctermfg=1 ctermbg=none

let g:gitgutter_sign_added="+"
let g:gitgutter_sign_modified="~"
let g:gitgutter_sign_removed="-"
let g:gitgutter_sign_modified_removed="~"

" Signify
highlight SignifySignAdd cterm=none ctermbg=none ctermfg=2
highlight SignifySignDelete cterm=none ctermbg=none ctermfg=1
highlight SignifySignChange cterm=none ctermbg=none ctermfg=3

let g:signify_sign_add = '+'
let g:signify_sign_change = '±'
let g:signify_sign_delete = '-'
let g:signify_sign_delete_first_line = '^'

" syntax
hi Comment cterm=none ctermfg=darkgrey ctermbg=none
hi PreProc cterm=none ctermfg=white ctermbg=none
hi Constant cterm=none ctermfg=darkred ctermbg=none
hi Type cterm=none ctermfg=124 ctermbg=none
hi Statement cterm=bold ctermfg=white ctermbg=none
hi Identifier cterm=none ctermfg=124 ctermbg=none
hi Ignore cterm=none ctermfg=darkgray ctermbg=none
hi Special cterm=none ctermfg=darkred ctermbg=none
hi Error cterm=none ctermfg=white ctermbg=darkred
hi Todo cterm=none ctermfg=white ctermbg=darkred
hi Underlined cterm=none ctermfg=darkred ctermbg=none
hi Number cterm=none ctermfg=darkred ctermbg=none
hi Function cterm=none ctermfg=white ctermbg=none
hi Define cterm=bold ctermfg=white ctermbg=none

hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Number Constant
hi link Repeat Statement
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Operator Statement
hi link Include PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Normal
hi link SpecialComment Special
hi link Debug Special
hi link Conditional Statement
