#!/usr/bin/env zsh
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2010-2011 zsh-syntax-highlighting contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted
# provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice, this list of conditions
#    and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice, this list of
#    conditions and the following disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of the zsh-syntax-highlighting contributors nor the names of its contributors
#    may be used to endorse or promote products derived from this software without specific prior
#    written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# -------------------------------------------------------------------------------------------------
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
# -------------------------------------------------------------------------------------------------


# # Define default styles.
# : ${ZSH_HIGHLIGHT_STYLES[default]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=fg=red,bold}
# : ${ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=yellow}
# : ${ZSH_HIGHLIGHT_STYLES[alias]:=fg=green}
# : ${ZSH_HIGHLIGHT_STYLES[builtin]:=fg=green}
# : ${ZSH_HIGHLIGHT_STYLES[function]:=fg=green}
# : ${ZSH_HIGHLIGHT_STYLES[command]:=fg=green}
# : ${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=green,underline}
# : ${ZSH_HIGHLIGHT_STYLES[commandseparator]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[hashed-command]:=fg=green}
# : ${ZSH_HIGHLIGHT_STYLES[path]:=underline}
# : ${ZSH_HIGHLIGHT_STYLES[path_prefix]:=underline}
# : ${ZSH_HIGHLIGHT_STYLES[path_approx]:=fg=yellow,underline}
# : ${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue}
# : ${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue}
# : ${ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=none}
# : ${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=yellow}
# : ${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=yellow}
# : ${ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=cyan}
# : ${ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=cyan}
# : ${ZSH_HIGHLIGHT_STYLES[assign]:=none}

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

#---------------------------------
#--[  scripts  ]------------------
#---------------------------------
  
  filetype-perl        'fg=214'
  filetype-sh          'fg=103'
  filetype-bash        'fg=103'
  filetype-zsh         'fg=103'
  filetype-py          'fg=41'
  filetype-awk         'fg=148,1'
  filetype-bat         'fg=108'
  filetype-BAT         'fg=108'
  filetype-rb          'fg=192'
  filetype-lua         'fg=23'
  filetype-PL          'fg=6'
  filetype-pl          'fg=6'
  filetype-zcompdump   'fg=240'
  filetype-zwc         'fg=240'
  filetype-tcl         'fg=64,bold'

#---------------------------------
#--[  development  ]--------------
#---------------------------------
  filetype-coffee      'fg=24'
  filetype-c           'fg=24'
  filetype-cc          'fg=24'
  filetype-cpp         'fg=24'
  filetype-cxx         'fg=24'
  filetype-cs          'fg=74,1'
  filetype-go          'fg=36,1'
  filetype-h           'fg=81'
  filetype-hs          'fg=73'
  filetype-jar         'fg=51'
  filetype-java        'fg=142,1'
  filetype-lisp        'fg=73'
  filetype-asm         'fg=240,1'
  filetype-diff        'fg=232,bg=7'
  filetype-patch       'fg=232,bold,bg=7'

#---------------------------------
#--[  archives  ]-----------------
#---------------------------------
  filetype-bz2         'fg=61'
  filetype-7z          'fg=61,bold'
  filetype-rar         'fg=61'
  filetype-gz          'fg=61'
  filetype-cdr         'fg=54'
  filetype-tar         'fg=61'
  filetype-tar.gz      'fg=61'
  filetype-tar.xz      'fg=61'
  filetype-tar.lrz     'fg=61'
  filetype-tbz         'fg=35;1'
  filetype-tgz         'fg=35;1'
  filetype-zip         'fg=61'
  filetype-xz          'fg=61'
  filetype-apk         'fg=61'
  filetype-part        'fg=240'

  filetype-iso         'fg=141'
  filetype-mdf         'fg=141'
  filetype-nrg         'fg=141'
  filetype-cdi         'fg=141'

#---------------------------------
#--[  audio  ]--------------------
#---------------------------------
  filetype-flac        'fg=108,1'
  filetype-mp3         'fg=108'
  filetype-ogv         'fg=108'
  filetype-cue         'fg=108,1'
  filetype-ogg         'fg=108'
  filetype-m3u         'fg=108'
  filetype-m4a         'fg=108'
  filetype-wmv         'fg=108'
#---------------------------------
#--[  video  ]--------------------
#---------------------------------
  filetype-mp4         'fg=13'
  filetype-flv         'fg=13'
  filetype-avi         'fg=13'
  filetype-m4v         'fg=13'
  filetype-mkv         'fg=13'
  filetype-mov         'fg=13'
  filetype-MOV         'fg=13'
  filetype-mpeg        'fg=13'
  filetype-mpg         'fg=13'
  filetype-vob         'fg=13'
  filetype-webm        'fg=13'
#---------------------------------
#--[  images  ]-------------------
#---------------------------------
  filetype-xpm         'fg=24'
  filetype-ico         'fg=24'
  filetype-jpeg        'fg=24'
  filetype-jpg         'fg=24'
  filetype-JPG         'fg=24'
  filetype-bmp         'fg=24'
  filetype-svg         'fg=24'
  filetype-eps         'fg=24'
  filetype-gif         'fg=24'
  filetype-png         'fg=24'
  filetype-psf         'fg=25'
#---------------------------------
#--[ Docs ]-----------------------
#---------------------------------
  filetype-djvu        'fg=247'
  filetype-pdf         'fg=250'
  filetype-fb2         'fg=246'
  filetype-ps          'fg=250'
  filetype-epub        'fg=250'
  filetype-chm         'fg=250'
  filetype-markdown    'fg=245'
  filetype-mkd         'fg=110'
  filetype-md          'fg=245'
  filetype-txt         'fg=60'
  filetype-doc         'fg=29'
  filetype-docx        'fg=29'
  filetype-odt         'fg=29'
  filetype-xls         'fg=29'
  filetype-xlsm        'fg=29'
  filetype-xlsx        'fg=29'
  filetype-log         'fg=23'
  filetype-tex         'fg=245'
  filetype-textile     'fg=245'
  filetype-owl         'fg=245'
  filetype-n3          'fg=245'
  filetype-rc          'fg=245'

  filetype-bin         'fg=249'
  filetype-exe         'fg=249'

  filetype-1           'fg=196,bold'
  filetype-1p          'fg=160,bold'
  filetype-32x         'fg=137,bold'
  filetype-3p          'fg=160,bold'
  filetype-a00         'fg=11,bold'
  filetype-a52         'fg=112,bold'
  filetype-a64         'fg=82'
  filetype-A64         'fg=82'
  filetype-a78         'fg=112'
  filetype-adf         'fg=35'
  filetype-a           'fg=46'
  filetype-afm         'fg=58'
  filetype-am          'fg=242'
  filetype-arj         'fg=41'
  filetype-atr         'fg=213'
  filetype-bak         'fg=41;1'
  filetype-cbr         'fg=140'
  filetype-cbz         'fg=140'
  filetype-cfg         'fg=245'
  filetype-conf        'fg=238'
  filetype-csv         'fg=12'
  filetype-dat         'fg=245'
  filetype-db          'fg=60'
  filetype-def         'fg=136'
  filetype-dump        'fg=119'
  filetype-enc         'fg=192,3'
  filetype-err         'fg=160,1'
  filetype-error       'fg=160,1'
  filetype-etx         'fg=172'
  filetype-example     'fg=225,1'
  filetype-ex          'fg=148,1'
  filetype-fcm         'fg=41'
  filetype-fm2         'fg=35'
  filetype-gba         'fg=205'
  filetype-gbc         'fg=204'
  filetype-gb          'fg=203'
  filetype-gel         'fg=83'
  filetype-gg          'fg=138'
  filetype-ggl         'fg=83'
  filetype-git         'fg=15'
  filetype-gitignore   'fg=240'
#---------------------------------
#--[  Web  ]----------------------
#---------------------------------
  filetype-htm         'fg=23'
  filetype-html        'fg=23'
  filetype-jhtm        'fg=23'
  filetype-json        'fg=23'
  filetype-css         'fg=91'
  filetype-js          'fg=23'
  filetype-jsm         'fg=23'
  filetype-jsm         'fg=23'
  filetype-jsp         'fg=23'
  filetype-php         'fg=93'
  filetype-xml         'fg=245'
  filetype-yml         'fg=245'
  
  filetype-in          'fg=242'
  filetype-info        'fg=101'
  filetype-ini         'fg=245'
  filetype-j64         'fg=102'
  filetype-jad         'fg=50'
  filetype-m4          'fg=196,3'
  filetype-map         'fg=58,3'
  filetype-mfasl       'fg=73'
  filetype-mf          'fg=220,3'
  filetype-mi          'fg=124'
  filetype-mod         'fg=72'
  filetype-mtx         'fg=36,3'
  filetype-nds         'fg=193'
  filetype-nes         'fg=160'
  filetype-nfo         'fg=245'
  filetype-odb         'fg=161'
  filetype-odp         'fg=166'
  filetype-ods         'fg=112'
  filetype-oga         'fg=95'
  filetype-ogm         'fg=97'
  filetype-old         'fg=242'
  filetype-out         'fg=46,1'
  filetype-pacnew      'fg=33'
  filetype-pc          'fg=100'
  filetype-pfa         'fg=43'
  filetype-pfb         'fg=58'
  filetype-pfm         'fg=58'
  filetype-pid         'fg=160'
  filetype-pi          'fg=126'
  filetype-pm          'fg=197,1'
  filetype-pod         'fg=172,1'
  filetype-properties  'fg=197,1'
  filetype-qcow        'fg=141'
  filetype-rdf         'fg=245'
  filetype-rmvb        'fg=112'
  filetype-rom         'fg=59,bold'
  filetype-ru          'fg=142'
  filetype-s3m         'fg=71,bold'
  filetype-S3M         'fg=71,bold'
  filetype-sample      'fg=130,bold'
  filetype-sav         'fg=220'
  filetype-sed         'fg=130,bold'
  filetype-sfv         'fg=197'
  filetype-sid         'fg=69,1'
  filetype-signature   'fg=206'
  filetype-SKIP        'fg=244'
  filetype-sms         'fg=33'
  filetype-spl         'fg=173'
  filetype-sql         'fg=222'
  filetype-sqlite      'fg=60'
  filetype-srt         'fg=116'
  filetype-st          'fg=208,bold'
  filetype-sty         'fg=58'
  filetype-sug         'fg=44'
  filetype-swo         'fg=236'
  filetype-swp         'fg=241'
  filetype-tdy         'fg=214'
  filetype-t           'fg=28;1'
  filetype-tfm         'fg=64'
  filetype-tfnt        'fg=140'
  filetype-theme       'fg=109'
  filetype-tmp         'fg=244'
  filetype-torrent     'fg=245'
  filetype-ts          'fg=39'
  filetype-typelib     'fg=60'
  filetype-un~         'fg=240'
  filetype-urlview     'fg=85'
  filetype-vim         'fg=53'
  filetype-viminfo     'fg=240,1'
  filetype-wvc         'fg=149'
  filetype-wv          'fg=149'
  filetype-ttl         'fg=245'
#---------------------------------
#--[ fonts ]----------------------
#---------------------------------
  filetype-ttf         'fg=65'
  filetype-pcf         'fg=65'
  filetype-bdf         'fg=65'
  filetype-TODO        'fg=91'
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
                        elif [[ $arg[0,1] = $histchars[0,1] ]]; then
                          style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                        else
                          style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                        fi
                        ;;
      esac
     fi
    else
      case $arg in
        *.pl)          style=$ZSH_HIGHLIGHT_STYLES[filetype-perl];;
        *.bash)        style=$ZSH_HIGHLIGHT_STYLES[filetype-bash];;
        *.sh)          style=$ZSH_HIGHLIGHT_STYLES[filetype-sh];;
        *.1p)          style=$ZSH_HIGHLIGHT_STYLES[filetype-1p];;
        *.32x)         style=$ZSH_HIGHLIGHT_STYLES[filetype-32x];;
        *.3p)          style=$ZSH_HIGHLIGHT_STYLES[filetype-3p];;
        *.7z)          style=$ZSH_HIGHLIGHT_STYLES[filetype-7z];;
        *.a00)         style=$ZSH_HIGHLIGHT_STYLES[filetype-a00];;
        *.a52)         style=$ZSH_HIGHLIGHT_STYLES[filetype-a52];;
        *.a64)         style=$ZSH_HIGHLIGHT_STYLES[filetype-a64];;
        *.A64)         style=$ZSH_HIGHLIGHT_STYLES[filetype-A64];;
        *.a78)         style=$ZSH_HIGHLIGHT_STYLES[filetype-a78];;
        *.adf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-adf];;
        *.afm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-afm];;
        *.am)          style=$ZSH_HIGHLIGHT_STYLES[filetype-am];;
        *.arj)         style=$ZSH_HIGHLIGHT_STYLES[filetype-arj];;
        *.asm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-asm];;
        *.a)           style=$ZSH_HIGHLIGHT_STYLES[filetype-a];;
        *.atr)         style=$ZSH_HIGHLIGHT_STYLES[filetype-atr];;
        *.avi)         style=$ZSH_HIGHLIGHT_STYLES[filetype-avi];;
        *.awk)         style=$ZSH_HIGHLIGHT_STYLES[filetype-awk];;
        *.bak)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bak];;
        *.bash)        style=$ZSH_HIGHLIGHT_STYLES[filetype-bash];;
        *.bat)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bat];;
        *.BAT)         style=$ZSH_HIGHLIGHT_STYLES[filetype-BAT];;
        *.bin)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bin];;
        *.exe)         style=$ZSH_HIGHLIGHT_STYLES[filetype-exe];;
        *.bmp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bmp];;
        *.bz2)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bz2];;
        *.cbr)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cbr];;
        *.cbz)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cbz];;
        *.cdi)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cdi];;
        *.cdr)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cdr];;
        *.cfg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cfg];;
        *.chm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-chm];;
        *.coffee)      style=$ZSH_HIGHLIGHT_STYLES[filetype-coffee];;
        *.conf)        style=$ZSH_HIGHLIGHT_STYLES[filetype-conf];;
        *.cxx)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cxx];;
        *.cpp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cpp];;
        *.css)         style=$ZSH_HIGHLIGHT_STYLES[filetype-css];;
        *.cs)          style=$ZSH_HIGHLIGHT_STYLES[filetype-cs];;
        *.cc)          style=$ZSH_HIGHLIGHT_STYLES[filetype-cc];;
        *.c)           style=$ZSH_HIGHLIGHT_STYLES[filetype-c];;
        *.csv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-csv];;
        *.cue)         style=$ZSH_HIGHLIGHT_STYLES[filetype-cue];;
        *.dat)         style=$ZSH_HIGHLIGHT_STYLES[filetype-dat];;
        *.db)          style=$ZSH_HIGHLIGHT_STYLES[filetype-db];;
        *.def)         style=$ZSH_HIGHLIGHT_STYLES[filetype-def];;
        *.diff)        style=$ZSH_HIGHLIGHT_STYLES[filetype-diff];;
        *.djvu)        style=$ZSH_HIGHLIGHT_STYLES[filetype-djvu];;
        *.dump)        style=$ZSH_HIGHLIGHT_STYLES[filetype-dump];;
        *.enc)         style=$ZSH_HIGHLIGHT_STYLES[filetype-enc];;
        *.eps)         style=$ZSH_HIGHLIGHT_STYLES[filetype-eps];;
        *.error)       style=$ZSH_HIGHLIGHT_STYLES[filetype-error];;
        *.err)         style=$ZSH_HIGHLIGHT_STYLES[filetype-err];;
        *.etx)         style=$ZSH_HIGHLIGHT_STYLES[filetype-etx];;
        *.example)     style=$ZSH_HIGHLIGHT_STYLES[filetype-example];;
        *.ex)          style=$ZSH_HIGHLIGHT_STYLES[filetype-ex];;
        *.fcm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-fcm];;
        *.flac)        style=$ZSH_HIGHLIGHT_STYLES[filetype-flac];;
        *.flv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-flv];;
        *.fm2)         style=$ZSH_HIGHLIGHT_STYLES[filetype-fm2];;
        *.gba)         style=$ZSH_HIGHLIGHT_STYLES[filetype-gba];;
        *.gbc)         style=$ZSH_HIGHLIGHT_STYLES[filetype-gbc];;
        *.gb)          style=$ZSH_HIGHLIGHT_STYLES[filetype-gb];;
        *.gel)         style=$ZSH_HIGHLIGHT_STYLES[filetype-gel];;
        *.ggl)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ggl];;
        *.gg)          style=$ZSH_HIGHLIGHT_STYLES[filetype-gg];;
        *.gif)         style=$ZSH_HIGHLIGHT_STYLES[filetype-gif];;
        *.gitignore)   style=$ZSH_HIGHLIGHT_STYLES[filetype-gitignore];;
        *.git)         style=$ZSH_HIGHLIGHT_STYLES[filetype-git];;
        *.go)          style=$ZSH_HIGHLIGHT_STYLES[filetype-go];;
        *.hs)          style=$ZSH_HIGHLIGHT_STYLES[filetype-hs];;
        *.h)           style=$ZSH_HIGHLIGHT_STYLES[filetype-h];;
        *.html)        style=$ZSH_HIGHLIGHT_STYLES[filetype-html];;
        *.htm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-htm];;
        *.ico)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ico];;
        *.info)        style=$ZSH_HIGHLIGHT_STYLES[filetype-info];;
        *.ini)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ini];;
        *.in)          style=$ZSH_HIGHLIGHT_STYLES[filetype-in];;
        *.iso)         style=$ZSH_HIGHLIGHT_STYLES[filetype-iso];;
        *.mdf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mdf];;
        *.j64)         style=$ZSH_HIGHLIGHT_STYLES[filetype-j64];;
        *.jad)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jad];;
        *.jar)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jar];;
        *.java)        style=$ZSH_HIGHLIGHT_STYLES[filetype-java];;
        *.jhtm)        style=$ZSH_HIGHLIGHT_STYLES[filetype-jhtm];;
        *.jpeg)        style=$ZSH_HIGHLIGHT_STYLES[filetype-jpeg];;
        *.jpg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jpg];;
        *.JPG)         style=$ZSH_HIGHLIGHT_STYLES[filetype-JPG];;
        *.jsm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jsm];;
        *.jsm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jsm];;
        *.json)        style=$ZSH_HIGHLIGHT_STYLES[filetype-json];;
        *.jsp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-jsp];;
        *.js)          style=$ZSH_HIGHLIGHT_STYLES[filetype-js];;
        *.lisp)        style=$ZSH_HIGHLIGHT_STYLES[filetype-lisp];;
        *.log)         style=$ZSH_HIGHLIGHT_STYLES[filetype-log];;
        *.lua)         style=$ZSH_HIGHLIGHT_STYLES[filetype-lua];;
        *.m3u)         style=$ZSH_HIGHLIGHT_STYLES[filetype-m3u];;
        *.m4a)         style=$ZSH_HIGHLIGHT_STYLES[filetype-m4a];;
        *.m4)          style=$ZSH_HIGHLIGHT_STYLES[filetype-m4];;
        *.map)         style=$ZSH_HIGHLIGHT_STYLES[filetype-map];;
        *.markdown)    style=$ZSH_HIGHLIGHT_STYLES[filetype-markdown];;
        *.md)          style=$ZSH_HIGHLIGHT_STYLES[filetype-md];;
        *.mfasl)       style=$ZSH_HIGHLIGHT_STYLES[filetype-mfasl];;
        *.mf)          style=$ZSH_HIGHLIGHT_STYLES[filetype-mf];;
        *.mi)          style=$ZSH_HIGHLIGHT_STYLES[filetype-mi];;
        *.mkd)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mkd];;
        *.m4v)         style=$ZSH_HIGHLIGHT_STYLES[filetype-m4v];;
        *.mkv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mkv];;
        *.mod)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mod];;
        *.mov)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mov];;
        *.MOV)         style=$ZSH_HIGHLIGHT_STYLES[filetype-MOV];;
        *.mp3)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mp3];;
        *.mp4)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mp4];;
        *.mpeg)        style=$ZSH_HIGHLIGHT_STYLES[filetype-mpeg];;
        *.mpg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mpg];;
        *.mtx)         style=$ZSH_HIGHLIGHT_STYLES[filetype-mtx];;
        *.nds)         style=$ZSH_HIGHLIGHT_STYLES[filetype-nds];;
        *.nes)         style=$ZSH_HIGHLIGHT_STYLES[filetype-nes];;
        *.nfo)         style=$ZSH_HIGHLIGHT_STYLES[filetype-nfo];;
        *.nrg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-nrg];;
        *.odb)         style=$ZSH_HIGHLIGHT_STYLES[filetype-odb];;
        *.odp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-odp];;
        *.ods)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ods];;
        *.odt)         style=$ZSH_HIGHLIGHT_STYLES[filetype-odt];;
        *.oga)         style=$ZSH_HIGHLIGHT_STYLES[filetype-oga];;
        *.ogg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ogg];;
        *.ogm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ogm];;
        *.ogv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ogv];;
        *.old)         style=$ZSH_HIGHLIGHT_STYLES[filetype-old];;
        *.out)         style=$ZSH_HIGHLIGHT_STYLES[filetype-out];;
        *.pacnew)      style=$ZSH_HIGHLIGHT_STYLES[filetype-pacnew];;
        *.part)        style=$ZSH_HIGHLIGHT_STYLES[filetype-part];;
        *.patch)       style=$ZSH_HIGHLIGHT_STYLES[filetype-patch];;
        *.pcf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pcf];;
        *.bdf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-bdf];;
        *.pc)          style=$ZSH_HIGHLIGHT_STYLES[filetype-pc];;
        *.ps)          style=$ZSH_HIGHLIGHT_STYLES[filetype-ps];;
        *.pdf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pdf];;
        *.fb2)         style=$ZSH_HIGHLIGHT_STYLES[filetype-fb2];;
        *.epub)        style=$ZSH_HIGHLIGHT_STYLES[filetype-epub];;
        *.pfa)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pfa];;
        *.pfb)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pfb];;
        *.pfm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pfm];;
        *.php)         style=$ZSH_HIGHLIGHT_STYLES[filetype-php];;
        *.pid)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pid];;
        *.pi)          style=$ZSH_HIGHLIGHT_STYLES[filetype-pi];;
        *.pl)          style=$ZSH_HIGHLIGHT_STYLES[filetype-pl];;
        *.PL)          style=$ZSH_HIGHLIGHT_STYLES[filetype-PL];;
        *.pm)          style=$ZSH_HIGHLIGHT_STYLES[filetype-pm];;
        *.png)         style=$ZSH_HIGHLIGHT_STYLES[filetype-png];;
        *.pod)         style=$ZSH_HIGHLIGHT_STYLES[filetype-pod];;
        *.properties)  style=$ZSH_HIGHLIGHT_STYLES[filetype-properties];;
        *.psf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-psf];;
        *.py)          style=$ZSH_HIGHLIGHT_STYLES[filetype-py];;
        *.qcow)        style=$ZSH_HIGHLIGHT_STYLES[filetype-qcow];;
        *.gz)          style=$ZSH_HIGHLIGHT_STYLES[filetype-gz];;
        *.rar)         style=$ZSH_HIGHLIGHT_STYLES[filetype-rar];;
        *.rar)         style=$ZSH_HIGHLIGHT_STYLES[filetype-apk];;
        *.vob)         style=$ZSH_HIGHLIGHT_STYLES[filetype-vob];;
        *.webm)        style=$ZSH_HIGHLIGHT_STYLES[filetype-webm];;
        *.rb)          style=$ZSH_HIGHLIGHT_STYLES[filetype-rb];;
        *.rdf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-rdf];;
        *.rmvb)        style=$ZSH_HIGHLIGHT_STYLES[filetype-rmvb];;
        *.rom)         style=$ZSH_HIGHLIGHT_STYLES[filetype-rom];;
        *.ru)          style=$ZSH_HIGHLIGHT_STYLES[filetype-ru];;
        *.s3m)         style=$ZSH_HIGHLIGHT_STYLES[filetype-s3m];;
        *.S3M)         style=$ZSH_HIGHLIGHT_STYLES[filetype-S3M];;
        *.sample)      style=$ZSH_HIGHLIGHT_STYLES[filetype-sample];;
        *.sav)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sav];;
        *.sed)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sed];;
        *.sfv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sfv];;
        *.sh)          style=$ZSH_HIGHLIGHT_STYLES[filetype-sh];;
        *.sid)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sid];;
        *.signature)   style=$ZSH_HIGHLIGHT_STYLES[filetype-signature];;
        *.SKIP)        style=$ZSH_HIGHLIGHT_STYLES[filetype-SKIP];;
        *.sms)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sms];;
        *.spl)         style=$ZSH_HIGHLIGHT_STYLES[filetype-spl];;
        *.sqlite)      style=$ZSH_HIGHLIGHT_STYLES[filetype-sqlite];;
        *.sql)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sql];;
        *.srt)         style=$ZSH_HIGHLIGHT_STYLES[filetype-srt];;
        *.st)          style=$ZSH_HIGHLIGHT_STYLES[filetype-st];;
        *.sty)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sty];;
        *.sug)         style=$ZSH_HIGHLIGHT_STYLES[filetype-sug];;
        *.svg)         style=$ZSH_HIGHLIGHT_STYLES[filetype-svg];;
        *.swo)         style=$ZSH_HIGHLIGHT_STYLES[filetype-swo];;
        *.swp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-swp];;
        *.tar.lrz)      style=$ZSH_HIGHLIGHT_STYLES[filetype-tar.lrz];;
        *.tar.xz)      style=$ZSH_HIGHLIGHT_STYLES[filetype-tar.xz];;
        *.tar.gz)      style=$ZSH_HIGHLIGHT_STYLES[filetype-tar.gz];;
        *.tar)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tar];;
        *.tcl)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tcl];;
        *.tdy)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tdy];;
        *.tex)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tex];;
        *.textile)     style=$ZSH_HIGHLIGHT_STYLES[filetype-textile];;
        *.tfm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tfm];;
        *.tfnt)        style=$ZSH_HIGHLIGHT_STYLES[filetype-tfnt];;
        *.tbz)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tbz];;
        *.tgz)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tgz];;
        *.theme)       style=$ZSH_HIGHLIGHT_STYLES[filetype-theme];;
        *.tmp)         style=$ZSH_HIGHLIGHT_STYLES[filetype-tmp];;
        *.torrent)     style=$ZSH_HIGHLIGHT_STYLES[filetype-torrent];;
        *.ttl)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ttl];;
        *.ts)          style=$ZSH_HIGHLIGHT_STYLES[filetype-ts];;
        *.t)           style=$ZSH_HIGHLIGHT_STYLES[filetype-t];;
        *.ttf)         style=$ZSH_HIGHLIGHT_STYLES[filetype-ttf];;
        *.txt)         style=$ZSH_HIGHLIGHT_STYLES[filetype-txt];;
        *.typelib)     style=$ZSH_HIGHLIGHT_STYLES[filetype-typelib];;
        *.un~)         style=$ZSH_HIGHLIGHT_STYLES[filetype-un~];;
        *.urlview)     style=$ZSH_HIGHLIGHT_STYLES[filetype-urlview];;
        *.viminfo)     style=$ZSH_HIGHLIGHT_STYLES[filetype-viminfo];;
        *.vim)         style=$ZSH_HIGHLIGHT_STYLES[filetype-vim];;
        *.wmv)         style=$ZSH_HIGHLIGHT_STYLES[filetype-wmv];;
        *.wvc)         style=$ZSH_HIGHLIGHT_STYLES[filetype-wvc];;
        *.wv)          style=$ZSH_HIGHLIGHT_STYLES[filetype-wv];;
        *.rc)         style=$ZSH_HIGHLIGHT_STYLES[filetype-rc];;
        *.xml)         style=$ZSH_HIGHLIGHT_STYLES[filetype-xml];;
        *.xpm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-xpm];;
        *.xz)          style=$ZSH_HIGHLIGHT_STYLES[filetype-xz];;
        *.yml)         style=$ZSH_HIGHLIGHT_STYLES[filetype-yml];;
        *.zcompdump)   style=$ZSH_HIGHLIGHT_STYLES[filetype-zcompdump];;
        *.zip)         style=$ZSH_HIGHLIGHT_STYLES[filetype-zip];;
        *.zsh)         style=$ZSH_HIGHLIGHT_STYLES[filetype-zsh];;
        *.doc)         style=$ZSH_HIGHLIGHT_STYLES[filetype-doc];;
        *.docx)         style=$ZSH_HIGHLIGHT_STYLES[filetype-docx];;
        *.xls)         style=$ZSH_HIGHLIGHT_STYLES[filetype-xls];;
        *.xlsm)         style=$ZSH_HIGHLIGHT_STYLES[filetype-xlsm];;
        *.xlsx)         style=$ZSH_HIGHLIGHT_STYLES[filetype-xlsm];;
        *.n3)          style=$ZSH_HIGHLIGHT_STYLES[filetype-n3];;
        *.owl)         style=$ZSH_HIGHLIGHT_STYLES[filetype-owl];;
        TODO)          style=$ZSH_HIGHLIGHT_STYLES[filetype-TODO];;
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
