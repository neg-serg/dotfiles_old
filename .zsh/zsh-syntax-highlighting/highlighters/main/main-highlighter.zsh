#!/usr/bin/env zsh
# -------------------------------------------------------------------------------------------------
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
# -------------------------------------------------------------------------------------------------

# : ${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=green,underline}
# : ${ZSH_HIGHLIGHT_STYLES[commandseparator]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[path]:=underline}
# : ${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue}
# : ${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue}

ZSH_HIGHLIGHT_STYLES+=(
  default                        'none'
  #unknown-token                 'fg=88,bg=234'
  reserved-word                  'fg=004'
  alias                          'fg=green'
  builtin                        'fg=green'
  function                       'fg=green,underline'
  command                        'fg=green'
  hashed-command                 'fg=green'
  globbing                       'fg=110'
  history-expansion              'fg=blue'
  single-hyphen-option           'fg=242'
  double-hyphen-option           'fg=244'
  back-quoted-argument           'fg=024,bold'
  single-quoted-argument         'fg=024'
  double-quoted-argument         'fg=024'
  dollar-double-quoted-argument  'fg=004,bold'
  back-double-quoted-argument    'fg=024,bold'
  assign                         'fg=240,bold'

  # path_prefix                    'underline'
  # path_approx                    'fg=yellow,underline'
#---------------------------------
#--[  scripts  ]------------------
#---------------------------------
  fclass-bin        'fg=111'
  fclass-perl       'fg=067'
  ftype-t           'fg=038'
  ftype-pm          'fg=038,1'
  ftype-pod         'fg=023'

  fclass-sh         'fg=103'
  fclass-zshcompile 'fg=240'
  fclass-winsh      'fg=108'
  ftype-awk         'fg=148,1'
  ftype-sed         'fg=130,bold'

  ftype-py          'fg=030'
  ftype-rb          'fg=192'
  ftype-lua         'fg=023'
  ftype-tcl         'fg=064,bold'
#---------------------------------
#--[  system  ]-------------------
#---------------------------------
  ftype-service      'fg=081'
  ftype-service-link 'fg=045'
  ftype-socket       'fg=075'
  ftype-device       'fg=024'
  ftype-mount        'fg=115'
  ftype-automount    'fg=114'
  ftype-target       'fg=073'
  ftype-timer        'fg=111'
  ftype-snapshot     'fg=139'
  ftype-pacnew       'fg=033'
#---------------------------------
#--[  development  ]--------------
#---------------------------------
  fclass-c          'fg=024'
  fclass-header     'fg=029'
  fclass-lib        'fg=022'
  fclass-asm        'fg=012,1'
  fclass-fortran    'fg=029'
  fclass-java       'fg=023,1'
  ftype-cs          'fg=074,1'
  ftype-go          'fg=036,1'
  ftype-hs          'fg=073'
  ftype-jad         'fg=050'
  ftype-lisp        'fg=073'
  ftype-diff        'fg=232,bg=7'
  ftype-patch       'fg=232,bold,bg=7'
  ftype-qt          'fg=013'
  ftype-ts          'fg=039'
#---------------------------------
#--[  archives  ]-----------------
#---------------------------------
  fclass-archive    'fg=061'
  fclass-image      'fg=141'
  fclass-rom        'fg=141'
#---------------------------------
#--[  audio  ]--------------------
#---------------------------------
  fclass-lossymusic 'fg=108'
  fclass-lossless   'fg=108,1'
  fclass-musicinfo  'fg=036'
#---------------------------------
#--[  video  ]--------------------
#---------------------------------
  fclass-video       'fg=013'
#---------------------------------
#--[  images  ]-------------------
#---------------------------------
  fclass-raster     'fg=024'
  fclass-hiraster   'fg=025'
  fclass-vector     'fg=025'
#---------------------------------
#--[ Docs ]-----------------------
#---------------------------------
  fclass-reading    'fg=250'
  fclass-word       'fg=030'
  fclass-openoffice 'fg=029'
  fclass-excel      'fg=014'
  fclass-text       'fg=060'
  fclass-markdown   'fg=110'
  ftype-sty         'fg=058'
  fclass-trash      'fg=238'
  ftype-djvu        'fg=247'
  ftype-fb2         'fg=246'
  ftype-log         'fg=023'
  ftype-am          'fg=242'
  ftype-csv         'fg=012'
  ftype-enc         'fg=192,3'
  ftype-git         'fg=015'
  ftype-gitignore   'fg=240'
#---------------------------------
#--[ Info ]-----------------------
#---------------------------------
  ftype-1           'fg=196,bold'
  ftype-info        'fg=101'
  ftype-viminfo     'fg=240,1'
#---------------------------------
#--[  Web  ]----------------------
#---------------------------------
  fclass-webdoc     'fg=023'
  fclass-js         'fg=068'
  fclass-db         'fg=060'
  ftype-php         'fg=089'
  ftype-css         'fg=031'
  ftype-in          'fg=242'
  ftype-m4          'fg=196,3'
  ftype-out         'fg=046,1'
  ftype-properties  'fg=197,1'
  ftype-sample      'fg=130,bold'
  ftype-sav         'fg=220'
  ftype-sfv         'fg=197'
  ftype-sid         'fg=069,1'
  ftype-signature   'fg=206'
  ftype-srt         'fg=116'
  ftype-t           'fg=028;1'
  ftype-theme       'fg=109'
  ftype-torrent     'fg=245'
  ftype-typelib     'fg=060'
  ftype-ttl         'fg=245'
#---------------------------------
#--[ etc ]------------------------
#---------------------------------
  ftype-urlview     'fg=085'
  ftype-vim         'fg=053'
#---------------------------------
#--[ fonts ]----------------------
#---------------------------------
  fclass-font       'fg=065'
#--[ tmpdump  ]-------------------
fclass-tcpdump      'fg=029'
ftype-TODO          'fg=091'
)
# Whether the highlighter should be called or not.
_zsh_highlight_main_highlighter_predicate()
{
  _zsh_highlight_buffer_modified
}

# Main syntax highlighting function.
_zsh_highlight_main_highlighter()
{
  emulate -L zsh
  setopt localoptions extendedglob bareglobqual
  local start_pos=0 end_pos highlight_glob=true new_expression=true arg style sudo=false sudo_arg=false
  typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
  typeset -a ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
  typeset -a ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS
  region_highlight=()

  ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
    '|' '||' ';' '&' '&&' '|&'
  )
  ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS=(
    'builtin' 'command' 'exec' 'nocorrect' 'noglob' 'sudo'
  )

  # Tokens that are always immediately followed by a command.
  ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS=(
    $ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR $ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
  )

  for arg in ${(z)BUFFER}; do
    local substr_color=0
    local style_override=""
    [[ $start_pos -eq 0 && $arg = 'noglob' ]] && highlight_glob=false
    ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]##[[:space:]]#}}))
    ((end_pos=$start_pos+${#arg}))
    # Parse the sudo command line
    if $sudo; then
      case "$arg" in
        # Flag that requires an argument
        '-'[Cgprtu]) sudo_arg=true;;
        # This prevents misbehavior with sudo -u -otherargument
        '-'*)        sudo_arg=false;;
        *)           if $sudo_arg; then
                       sudo_arg=false
                     else
                       sudo=false
                       new_expression=true
                     fi
                     ;;
      esac
    fi
    if $new_expression; then
      new_expression=false
     if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]]; then
      style=$ZSH_HIGHLIGHT_STYLES[precommand]
     elif [[ "$arg" = "sudo" ]]; then
      style=$ZSH_HIGHLIGHT_STYLES[precommand]
      sudo=true
     else
      res=$(LC_ALL=C builtin type -w $arg 2>/dev/null)
      case $res in
        *': reserved')  style=$ZSH_HIGHLIGHT_STYLES[reserved-word];;
        *': alias')     style=$ZSH_HIGHLIGHT_STYLES[alias]
                        local aliased_command="${"$(alias -- $arg)"#*=}"
                        [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS:#"$aliased_command"} && -z ${(M)ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS:#"$arg"} ]] && ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS+=($arg)
                        ;;
        *': builtin')   style=$ZSH_HIGHLIGHT_STYLES[builtin];;
        *': function')  style=$ZSH_HIGHLIGHT_STYLES[function];;
        *': command')   style=$ZSH_HIGHLIGHT_STYLES[command];;
        *': hashed')    style=$ZSH_HIGHLIGHT_STYLES[hashed-command];;
        *)              if _zsh_highlight_main_highlighter_check_assign; then
                          style=$ZSH_HIGHLIGHT_STYLES[assign]
                          new_expression=true
                        elif _zsh_highlight_main_highlighter_check_path; then
                          style=$ZSH_HIGHLIGHT_STYLES[path]
                        elif [[ $arg[0,1] == $histchars[0,1] || $arg[0,1] == $histchars[2,2] ]]; then
                          style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                        else
                          style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                        fi
                        ;;
      esac
     fi
    else
      case $arg in
        *.(bash|sh|zsh))   style=$ZSH_HIGHLIGHT_STYLES[fclass-sh];;
        *.(zcompdump|zwc))   style=$ZSH_HIGHLIGHT_STYLES[ftype-zcompdump];;
        *.awk)         style=$ZSH_HIGHLIGHT_STYLES[ftype-awk];;
        *.(mp4|flv|avi|AVI|m4v|mkv|mov|MOV|mpeg|mpg|vob|VOB|webm|flc|fli|gl|m2ts|divx|mp4v|m2v|ogm|nuv|asf|rm|rmvb)) style=$ZSH_HIGHLIGHT_STYLES[fclass-video];;
        *.(bz2|7z|rar|gz|tar|tar.gz|tar.xz|tar.lrz|zip|xz|apk|arj|deb|rpm|tgz|lzh|lzma|tlz|txz|ZIP|z|Z|dz|gem|jar|ace|zoo|cpio|rz)) style=$ZSH_HIGHLIGHT_STYLES[fclass-archive];;
        *.part)        style=$ZSH_HIGHLIGHT_STYLES[ftype-part];;
        *.(iso|img|mdf|nrg|cdi|qcow|qcow2|vmdk|vdi)) style=$ZSH_HIGHLIGHT_STYLES[fclass-image];;
        *.(rtf|doc|docx|odt)) style=$ZSH_HIGHLIGHT_STYLES[fclass-word];;
        *.(mp3|ogv|ogg|m3u|m4a|wmv)) style=$ZSH_HIGHLIGHT_STYLES[fclass-lossymusic];;
        *.(jpg|jpeg|JPG|bmp|png|xpm|xbm|pbm|pgm|ppm|tga|tif|tiff|mng|pcx|dl|xcf|xwd|yuv|cgm|emf|CR2)) style=$ZSH_HIGHLIGHT_STYLES[fclass-raster];;
        *.(js|jsm|jsm|jsp)) style=$ZSH_HIGHLIGHT_STYLES[fclass-js];;
        *.(c|cc|cpp|cxx|coffee|tcc)) style=$ZSH_HIGHLIGHT_STYLES[fclass-c];;
        *.cs)          style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
        *.(java|jnlp)) style=$ZSH_HIGHLIGHT_STYLES[fclass-java];;
        *.jad)         style=$ZSH_HIGHLIGHT_STYLES[ftype-jad];;
        *.qt)          style=$ZSH_HIGHLIGHT_STYLES[ftype-qt];;
        *.ts)          style=$ZSH_HIGHLIGHT_STYLES[ftype-ts];;
        *.patch)       style=$ZSH_HIGHLIGHT_STYLES[ftype-patch];;
        *.diff)        style=$ZSH_HIGHLIGHT_STYLES[ftype-diff];;
        *.gitignore)   style=$ZSH_HIGHLIGHT_STYLES[ftype-gitignore];;
        *.git)         style=$ZSH_HIGHLIGHT_STYLES[ftype-git];;
        *.go)          style=$ZSH_HIGHLIGHT_STYLES[ftype-go];;
        *.hs)          style=$ZSH_HIGHLIGHT_STYLES[ftype-hs];;
        *.(f|for|ftn))  style=$ZSH_HIGHLIGHT_STYLES[fclass-fortran];;
        *.(xls|xlsm|xlsx)) style=$ZSH_HIGHLIGHT_STYLES[fclass-excel];;
        *.(h|H|hpp|hxx|h++))  style=$ZSH_HIGHLIGHT_STYLES[fclass-header];;
        *.(htm|html|jhtm|json))  style=$ZSH_HIGHLIGHT_STYLES[fclass-webdoc];;
        *.css)         style=$ZSH_HIGHLIGHT_STYLES[ftype-css];;
        *.csv)         style=$ZSH_HIGHLIGHT_STYLES[ftype-csv];;
        *.(pcap|cap|dmp)) style=$ZSH_HIGHLIGHT_STYLES[fclass-tcpdump];;
        *.(ttf|pcf|bdf|otf|tfm)) style=$ZSH_HIGHLIGHT_STYLES[fclass-font];;
        *.(bin|exe|com|elf)) style=$ZSH_HIGHLIGHT_STYLES[fclass-bin];;
        *.(pdf|ps|epub|chm|cbr|cbz)) style=$ZSH_HIGHLIGHT_STYLES[fclass-reading];;
        *.fb2)         style=$ZSH_HIGHLIGHT_STYLES[ftype-fb2];;
        *.djvu)        style=$ZSH_HIGHLIGHT_STYLES[ftype-djvu];;
        *.(svg|svgz|eps|cdr)) style=$ZSH_HIGHLIGHT_STYLES[fclass-vector];;
        *.(tex|textile|owl|n3|rc|cfg|dat|xml|yml|ini|nfo|rdf|txt|etx|properties)) style=$ZSH_HIGHLIGHT_STYLES[fclass-text];;
        *.(ods|odp|odb)) style=$ZSH_HIGHLIGHT_STYLES[fclass-openoffice];;
        *.(mkd|markdown|md))  style=$ZSH_HIGHLIGHT_STYLES[fclass-markdown];;
        *.(pl|perl|PL)) style=$ZSH_HIGHLIGHT_STYLES[fclass-perl];;
        *.pm)          style=$ZSH_HIGHLIGHT_STYLES[ftype-pm];;
        *.pod)         style=$ZSH_HIGHLIGHT_STYLES[ftype-pod];;
        *.t)           style=$ZSH_HIGHLIGHT_STYLES[ftype-t];;
        *.(bat|BAT|cmd)) style=$ZSH_HIGHLIGHT_STYLES[fclass-winsh];;
        *.(conf|part|aux|bbl|blg|bak|dump|swp|swap|tmp|temp|incomplete|pyc|class|cache|old|un~)) style=$ZSH_HIGHLIGHT_STYLES[fclass-trash];;
        *.(sql|db|odb|sqlite)) style=$ZSH_HIGHLIGHT_STYLES[fclass-db];;
        *.(a|so|dll|ru)) style=$ZSH_HIGHLIGHT_STYLES[fclass-lib];;
        *.(ico|gif|psf)) style=$ZSH_HIGHLIGHT_STYLES[fclass-hiraster];;
        *.(asm|s|S))  style=$ZSH_HIGHLIGHT_STYLES[fclass-asm];;
        *.(32x|fm2|gbc|gb|ggl|gel|nes|nds|sms|rom|st|atr)) style=$ZSH_HIGHLIGHT_STYLES[fclass-rom];;
        *.(cue|s3m|S3M)) style=$ZSH_HIGHLIGHT_STYLES[fclass-musicinfo];;
        *.(flac|wv|alac)) style=$ZSH_HIGHLIGHT_STYLES[fclass-lossless];;
        *.socket)      style=$ZSH_HIGHLIGHT_STYLES[ftype-socket];;
        *.device)      style=$ZSH_HIGHLIGHT_STYLES[ftype-device];;
        *.mount)       style=$ZSH_HIGHLIGHT_STYLES[ftype-mount];;
        *.automount)   style=$ZSH_HIGHLIGHT_STYLES[ftype-automount];;
        *.target)      style=$ZSH_HIGHLIGHT_STYLES[ftype-target];;
        *.timer)       style=$ZSH_HIGHLIGHT_STYLES[ftype-timer];;
        *.snapshot)    style=$ZSH_HIGHLIGHT_STYLES[ftype-snapshot];;
        *@.service)    style=$ZSH_HIGHLIGHT_STYLES[ftype-service-link];;
        *.pacnew)      style=$ZSH_HIGHLIGHT_STYLES[ftype-pacnew];;
        *.enc)         style=$ZSH_HIGHLIGHT_STYLES[ftype-enc];;
        *.info)        style=$ZSH_HIGHLIGHT_STYLES[ftype-info];;
        *.in)          style=$ZSH_HIGHLIGHT_STYLES[ftype-in];;
        *.lisp)        style=$ZSH_HIGHLIGHT_STYLES[ftype-lisp];;
        *.py)          style=$ZSH_HIGHLIGHT_STYLES[ftype-py];;
        *.rb)          style=$ZSH_HIGHLIGHT_STYLES[ftype-rb];;
        *.log)         style=$ZSH_HIGHLIGHT_STYLES[ftype-log];;
        *.lua)         style=$ZSH_HIGHLIGHT_STYLES[ftype-lua];;
        *.m4)          style=$ZSH_HIGHLIGHT_STYLES[ftype-m4];;
        *.out)         style=$ZSH_HIGHLIGHT_STYLES[ftype-out];;
        *.php)         style=$ZSH_HIGHLIGHT_STYLES[ftype-php];;
        *.pid)         style=$ZSH_HIGHLIGHT_STYLES[ftype-pid];;
        *.sample)      style=$ZSH_HIGHLIGHT_STYLES[ftype-sample];;
        *.sav)         style=$ZSH_HIGHLIGHT_STYLES[ftype-sav];;
        *.sed)         style=$ZSH_HIGHLIGHT_STYLES[ftype-sed];;
        *.signature)   style=$ZSH_HIGHLIGHT_STYLES[ftype-signature];;
        *.sty)         style=$ZSH_HIGHLIGHT_STYLES[ftype-sty];;
        *.tcl)         style=$ZSH_HIGHLIGHT_STYLES[ftype-tcl];;
        *.theme)       style=$ZSH_HIGHLIGHT_STYLES[ftype-theme];;
        *.torrent)     style=$ZSH_HIGHLIGHT_STYLES[ftype-torrent];;
        *.t)           style=$ZSH_HIGHLIGHT_STYLES[ftype-t];;
        *.typelib)     style=$ZSH_HIGHLIGHT_STYLES[ftype-typelib];;
        *.urlview)     style=$ZSH_HIGHLIGHT_STYLES[ftype-urlview];;
        *.viminfo)     style=$ZSH_HIGHLIGHT_STYLES[ftype-viminfo];;
        *.vim)         style=$ZSH_HIGHLIGHT_STYLES[ftype-vim];;
        TODO)          style=$ZSH_HIGHLIGHT_STYLES[ftype-TODO];;
        '--'*)   style=$ZSH_HIGHLIGHT_STYLES[double-hyphen-option];;
        '-'*)    style=$ZSH_HIGHLIGHT_STYLES[single-hyphen-option];;
        "'"*"'") style=$ZSH_HIGHLIGHT_STYLES[single-quoted-argument];;
        '"'*'"') style=$ZSH_HIGHLIGHT_STYLES[double-quoted-argument]
                 region_highlight+=("$start_pos $end_pos $style")
                 _zsh_highlight_main_highlighter_highlight_string
                 substr_color=1
                 ;;
        '`'*'`') style=$ZSH_HIGHLIGHT_STYLES[back-quoted-argument];;
        *"*"*)   $highlight_glob && style=$ZSH_HIGHLIGHT_STYLES[globbing] || style=$ZSH_HIGHLIGHT_STYLES[default];;
        *)       if _zsh_highlight_main_highlighter_check_path; then
                   style=$ZSH_HIGHLIGHT_STYLES[path]
                 elif [[ $arg[0,1] = $histchars[0,1] ]]; then
                   style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                 elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                   style=$ZSH_HIGHLIGHT_STYLES[commandseparator]
                 else
                   style=$ZSH_HIGHLIGHT_STYLES[default]
                 fi
                 ;;
      esac
    fi
    # if a style_override was set (eg in _zsh_highlight_main_highlighter_check_path), use it
    [[ -n $style_override ]] && style=$ZSH_HIGHLIGHT_STYLES[$style_override]
    [[ $substr_color = 0 ]] && region_highlight+=("$start_pos $end_pos $style")
    [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_FOLLOWED_BY_COMMANDS:#"$arg"} ]] && new_expression=true
    start_pos=$end_pos
  done
}

# Check if the argument is variable assignment
_zsh_highlight_main_highlighter_check_assign()
{
    setopt localoptions extended_glob
    [[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])=* ]]
}

# Check if the argument is a path.
_zsh_highlight_main_highlighter_check_path()
{
  setopt localoptions nonomatch
  local expanded_path; : ${expanded_path:=${(Q)~arg}}
  [[ -z $expanded_path ]] && return 1
  [[ -e $expanded_path ]] && return 0
  # Search the path in CDPATH
  local cdpath_dir
  for cdpath_dir in $cdpath ; do
    [[ -e "$cdpath_dir/$expanded_path" ]] && return 0
  done
  [[ ! -e ${expanded_path:h} ]] && return 1
  if [[ ${BUFFER[1]} != "-" && ${#BUFFER} == $end_pos ]]; then
    local -a tmp
    # got a path prefix?
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && style_override=path_prefix && return 0
    # or maybe an approximate path?
    tmp=( (#a1)${expanded_path}*(N) )
    (( $#tmp > 0 )) && style_override=path_approx && return 0
  fi
  return 1
}

# Highlight special chars inside double-quoted strings
_zsh_highlight_main_highlighter_highlight_string()
{
  setopt localoptions noksharrays
  local i j k style varflag
  # Starting quote is at 1, so start parsing at offset 2 in the string.
  for (( i = 2 ; i < end_pos - start_pos ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      '$' ) style=$ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]
            (( varflag = 1))
            ;;
      "\\") style=$ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]
            for (( c = i + 1 ; c < end_pos - start_pos ; c += 1 )); do
              [[ "$arg[$c]" != ([0-9,xX,a-f,A-F]) ]] && break
            done
            AA=$arg[$i+1,$c-1]
            # Matching for HEX and OCT values like \0xA6, \xA6 or \012
            if [[ "$AA" =~ "^(0*(x|X)[0-9,a-f,A-F]{1,2})" || "$AA" =~ "^(0[0-7]{1,3})" ]];then
              (( k += $#MATCH ))
              (( i += $#MATCH ))
            else
              (( k += 1 )) # Color following char too.
              (( i += 1 )) # Skip parsing the escaped char.
            fi
              (( varflag = 0 )) # End of variable
            ;;
      ([^a-zA-Z0-9_]))
            (( varflag = 0 )) # End of variable
            continue
            ;;
      *) [[ $varflag -eq 0 ]] && continue ;;

    esac
    region_highlight+=("$j $k $style")
  done
}
