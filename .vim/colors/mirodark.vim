" Name:        wim
" Version:     1.0
" Last Change: 06-02-2016
" Maintainer:  Sergey Miroshnichenko <serg.zorg@gmail.com>
" URL:         
" About:       wim extends Jason W Ryan's miromiro(1) Vim color file

let g:mirodark_enable_higher_contrast_mode=1

if !has("gui_running") && (!has('termguicolors') || (has('termguicolors') && !&termguicolors)) && empty($NVIM_TUI_ENABLE_TRUE_COLOR) &&
            \ ((&t_Co == 88 || &t_Co == 256) && !exists("g:mirodark_disable_color_approximation"))
    fun! s:rgb_color(x, y, z)
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endfun

    fun! s:color(r, g, b)
        return s:rgb_color(l:x, l:y, l:z)
    endfun

    fun! s:rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
        return s:color(l:r, l:g, l:b)
    endfun
endif

set background=dark
hi clear
if exists("syntax on")
    syntax reset
endif

if has("gui_running") || (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR) ||
            \ ((&t_Co == 88 || &t_Co == 256) && !exists("g:mirodark_disable_color_approximation"))
    if !exists("g:mirodark_enable_higher_contrast_mode")
        let s:conf_bclr_hex="121212" " configuration-based background color hexadecimal
        let s:conf_dblk_hex="3d3d3d" " configuration-based dark black hexadecimal
        let s:conf_lblk_hex="5e5e5e" " configuration-based light black hexadecimal
    else
        let s:conf_bclr_hex="000000"
        let s:conf_dblk_hex="121212"
        let s:conf_lblk_hex="3d3d3d"
    endif

    let s:bclr_hex=s:conf_bclr_hex " background color hexadecimal
    let s:fclr_hex="999999"        " foreground color hexadecimal
    let s:dblk_hex=s:conf_dblk_hex " dark black hexadecimal    (color 0)
    let s:lblk_hex=s:conf_lblk_hex " light black hexadecimal   (color 8)
    let s:dred_hex="8a2f58"        " dark red hexadecimal      (color 1)
    let s:lred_hex="cf4f88"        " light red hexadecimal     (color 9)
    let s:dgrn_hex="287373"        " dark green hexadecimal    (color 2)
    let s:lgrn_hex="53a6a6"        " light green hexadecimal   (color 10)
    let s:dylw_hex="914e89"        " dark yellow hexadecimal   (color 3)
    let s:lylw_hex="bf85cc"        " light yellow hexadecimal  (color 11)
    let s:dblu_hex="395573"        " dark blue hexadecimal     (color 4)
    let s:lblu_hex="4779b3"        " light blue hexadecimal    (color 12)
    let s:dmag_hex="5e468c"        " dark magentahexadecimal   (color 5)
    let s:lmag_hex="7f62b3"        " light magenta hexadecimal (color 13)
    let s:dcyn_hex="2b7694"        " dark cyan hexadecimal     (color 6)
    let s:lcyn_hex="47959e"        " light cyan hexadecimal    (color 14)
    let s:dwht_hex="899ca1"        " dark white hexadecimal    (color 7)
    let s:lwht_hex="c0c0c0"        " light white hexadecimal   (color 15)
    let s:culc_hex="272727"        " cursor line/column hexadecimal

    if has("gui_running") || (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR)
        let s:venv="gui" " vim environment (term, cterm, gui)
        let s:bclr="#".s:bclr_hex
        let s:fclr="#".s:fclr_hex
        let s:dblk="#".s:dblk_hex
        let s:lblk="#".s:lblk_hex
        let s:dred="#".s:dred_hex
        let s:lred="#".s:lred_hex
        let s:dgrn="#".s:dgrn_hex
        let s:lgrn="#".s:lgrn_hex
        let s:dylw="#".s:dylw_hex
        let s:lylw="#".s:lylw_hex
        let s:dblu="#".s:dblu_hex
        let s:lblu="#".s:lblu_hex
        let s:dmag="#".s:dmag_hex
        let s:lmag="#".s:lmag_hex
        let s:dcyn="#".s:dcyn_hex
        let s:lcyn="#".s:lcyn_hex
        let s:dwht="#".s:dwht_hex
        let s:lwht="#".s:lwht_hex
        let s:culc="#".s:culc_hex
    else
        let s:venv="cterm"
        let s:bclr=s:rgb(s:bclr_hex)
        let s:fclr=s:rgb(s:fclr_hex)
        let s:dblk=s:rgb(s:dblk_hex)
        let s:lblk=s:rgb(s:lblk_hex)
        let s:dred=s:rgb(s:dred_hex)
        let s:lred=s:rgb(s:lred_hex)
        let s:dgrn=s:rgb(s:dgrn_hex)
        let s:lgrn=s:rgb(s:lgrn_hex)
        let s:dylw=s:rgb(s:dylw_hex)
        let s:lylw=s:rgb(s:lylw_hex)
        let s:dblu=s:rgb(s:dblu_hex)
        let s:lblu=s:rgb(s:lblu_hex)
        let s:dmag=s:rgb(s:dmag_hex)
        let s:lmag=s:rgb(s:lmag_hex)
        let s:dcyn=s:rgb(s:dcyn_hex)
        let s:lcyn=s:rgb(s:lcyn_hex)
        let s:dwht=s:rgb(s:dwht_hex)
        let s:lwht=s:rgb(s:lwht_hex)
        let s:culc=s:rgb(s:culc_hex)
    endif
elseif $TERM == "linux"
    let s:venv="cterm"
    let s:bclr=""
    let s:fclr=""
    let s:dblk="Black"
    let s:lblk="DarkGray"
    let s:dred="DarkRed"
    let s:lred="LightRed"
    let s:dgrn="DarkGreen"
    let s:lgrn="LightGreen"
    let s:dylw="DarkYellow"
    let s:lylw="LightYellow"
    let s:dblu="DarkBlue"
    let s:lblu="LightBlue"
    let s:dmag="DarkMagenta"
    let s:lmag="LightMagenta"
    let s:dcyn="DarkCyan"
    let s:lcyn="LightCyan"
    let s:dwht="LightGray"
    let s:lwht="White"
    let s:culc=s:dblk
else
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
    if &t_Co == 88
        let s:culc="80" " #2e2e2e (xterm-88color)
    elseif &t_Co == 256
        let s:culc="235" " #262626 (xterm-256color)
    else
        let s:culc=s:dblk
    endif
endif

fun! s:HI(group, bg, fg, attr)
    exec "hi" a:group
                \ . " " . (a:bg   != "" ? s:venv . "bg=" . a:bg   : "")
                \ . " " . (a:fg   != "" ? s:venv . "fg=" . a:fg   : "")
                \ . " " . (a:attr != "" ? s:venv . "="   . a:attr : "")
endfun

call s:HI(         "Normal", s:bclr, s:lwht,     "" )
call s:HI(         "Ignore",     "", s:lblk,     "" )
call s:HI(        "Comment",     "", s:dwht,     "" )
call s:HI(         "LineNr",     "", s:lblk,     "" )
call s:HI(          "Float",     "", s:dylw,     "" )
call s:HI(        "Include",     "", s:dmag,     "" )
call s:HI(         "Define",     "", s:dgrn,     "" )
call s:HI(          "Macro",     "", s:lmag,     "" )
call s:HI(        "PreProc",     "", s:lgrn,     "" )
call s:HI(      "PreCondit",     "", s:lmag,     "" )
call s:HI(        "NonText",     "", s:dcyn,     "" )
call s:HI(      "Directory",     "", s:dcyn,     "" )
call s:HI(     "SpecialKey",     "", s:lylw,     "" )
call s:HI(           "Type",     "", s:dcyn,     "" )
call s:HI(         "String",     "", s:dgrn,     "" )
call s:HI(       "Constant",     "", s:lmag,     "" )
call s:HI(        "Special",     "", s:lgrn,     "" )
call s:HI(    "SpecialChar",     "", s:lred,     "" )
call s:HI(         "Number",     "", s:lcyn,     "" )
call s:HI(     "Identifier",     "", s:lmag,     "" )
call s:HI(    "Conditional",     "", s:lcyn,     "" )
call s:HI(         "Repeat",     "", s:lred,     "" )
call s:HI(      "Statement",     "", s:dblu,     "" )
call s:HI(          "Label",     "", s:lmag,     "" )
call s:HI(       "Operator",     "", s:dylw,     "" )
call s:HI(        "Keyword",     "", s:lred,     "" )
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
call s:HI(       "ErrorMsg", "NONE", s:dred,     "" )
call s:HI(       "WildMenu", s:lwht, s:dmag,     "" )
call s:HI(         "Folded", s:dblk, s:dwht,     "" )
call s:HI(         "Search", s:lwht, s:dred,     "" )
call s:HI(      "IncSearch", s:lwht, s:dred,     "" )
call s:HI(     "WarningMsg", s:lwht, s:dred,     "" )
call s:HI(       "Question", s:lwht, s:lgrn,     "" )
call s:HI(          "Pmenu", s:lwht, s:dgrn,     "" )
call s:HI(       "PmenuSel", s:lwht, s:dred,     "" )
call s:HI(         "Visual", s:lwht, s:lblk,     "" )
call s:HI(     "StatusLine", s:dblk, s:dwht, "none" )
call s:HI(   "StatusLineNC", s:lblk, s:dblk,     "" )
call s:HI(      "VertSplit", s:lblk, s:dblk,     "" )
call s:HI(        "TabLine", s:dblk, s:dwht,     "" )
call s:HI(    "TabLineFill",     "", s:dblk,     "" )
call s:HI(     "TabLineSel", s:dblk, s:dwht,     "" )
call s:HI(         "Cursor", s:lred, s:bclr,     "" )
call s:HI(     "CursorLine", s:culc,     "", "none" )
call s:HI(   "CursorLineNr", s:culc, s:dwht, "none" )
call s:HI(   "CursorColumn", s:culc,     "",     "" )
call s:HI(    "ColorColumn", s:culc,     "",     "" )
call s:HI(     "FoldColumn", "NONE", s:lblk,     "" )
call s:HI(     "SignColumn", "NONE",     "",     "" )

call s:HI( "vimCommentTitle",     "", s:lgrn, "" )
call s:HI(         "vimFold", s:lwht, s:dblk, "" )

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

call s:HI(   "SyntasticErrorSign", s:culc, s:lred, "" )
call s:HI( "SyntasticWarningSign", s:culc, s:lmag, "" )

call s:HI(   "TermCursor",     "", s:lred, "" )
call s:HI( "TermCursorNC", s:lblk,     "", "" )

if (has('termguicolors') && &termguicolors) || !empty($NVIM_TUI_ENABLE_TRUE_COLOR)
    let g:terminal_color_0=s:dblk
    let g:terminal_color_8=s:lblk
    let g:terminal_color_1=s:dred
    let g:terminal_color_9=s:lred
    let g:terminal_color_2=s:dgrn
    let g:terminal_color_10=s:lgrn
    let g:terminal_color_3=s:dylw
    let g:terminal_color_11=s:lylw
    let g:terminal_color_4=s:dblu
    let g:terminal_color_12=s:lblu
    let g:terminal_color_5=s:dmag
    let g:terminal_color_13=s:lmag
    let g:terminal_color_6=s:dcyn
    let g:terminal_color_14=s:lcyn
    let g:terminal_color_7=s:dwht
    let g:terminal_color_15=s:lwht
endif
