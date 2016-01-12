#!/usr/bin/env zsh
# -------------------------------------------------------------------------------------------------
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
# -------------------------------------------------------------------------------------------------


ZSH_HIGHLIGHT_STYLES+=(
  default                        'none'
  #unknown-token                 'fg=88,bg=234'
  suffix-alias                    fg=green,underline
  reserved-word                  'fg=004'
  alias                          'fg=green'
  builtin                        'fg=green'
  function                       'fg=green,underline'
  command                        'fg=green'

  #precommand                    'fg=green,underline'
  path                           'underline'
  #path_prefix                   'fg=underline'
  #path_approx                   'fg=yellow,underline'

  hashed-command                 'fg=green'
  globbing                       'fg=110'
  history-expansion              'fg=blue'
  single-hyphen-option           'fg=242'
  double-hyphen-option           'fg=244'
  # comment                      'fg=222'
  # redirection                  'none'
  # commandseparator             'none'
  
  back-quoted-argument           'fg=024,bold'
  single-quoted-argument         'fg=024'
  double-quoted-argument         'fg=024'
  dollar-double-quoted-argument  'fg=004,bold'
  back-double-quoted-argument    'fg=024,bold'
  back-dollar-quoted-argument    'fg=024,bold'
  assign                         'fg=240,bold'
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
  ftype-rb          'fg=31'
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
  ftype-torrent     'fg=60'
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
  # accept-* may trigger removal of path_prefix highlighting
  [[ $WIDGET == accept-* ]] ||
    _zsh_highlight_buffer_modified
}

# Helper to deal with tokens crossing line boundaries.
_zsh_highlight_main_add_region_highlight() {
  integer start=$1 end=$2
  local style=$3

  # The calculation was relative to $PREBUFFER$BUFFER, but region_highlight is
  # relative to $BUFFER.
  (( start -= $#PREBUFFER ))
  (( end -= $#PREBUFFER ))

  (( end < 0 )) && return # having end<0 would be a bug
  (( start < 0 )) && start=0 # having start<0 is normal with e.g. multiline strings
  region_highlight+=("$start $end $style")
}

# Wrapper around 'type -w'.
#
# Takes a single argument and outputs the output of 'type -w $1'.
#
# NOTE: This runs 'setopt', but that should be safe since it'll only ever be
# called inside a $(...) subshell, so the effects will be local.
_zsh_highlight_main__type() {
  if (( $#options_to_set )); then
    setopt $options_to_set;
  fi
  LC_ALL=C builtin type -w -- $1 2>/dev/null
}

# Main syntax highlighting function.
_zsh_highlight_main_highlighter()
{
  ## Before we even 'emulate -L', we must test a few options that would reset.
  if [[ -o interactive_comments ]]; then
    local interactive_comments= # set to empty
  fi
  if [[ -o path_dirs ]]; then
    integer path_dirs_was_set=1
  else
    integer path_dirs_was_set=0
  fi
  emulate -L zsh
  setopt localoptions extendedglob bareglobqual

  ## Variable declarations and initializations
  local start_pos=0 end_pos highlight_glob=true arg style
  local in_array_assignment=false # true between 'a=(' and the matching ')'
  typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
  typeset -a ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
  typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
  local -a options_to_set # used in callees
  local buf="$PREBUFFER$BUFFER"
  region_highlight=()

  if (( path_dirs_was_set )); then
    options_to_set+=( PATH_DIRS )
  fi
  unset path_dirs_was_set

  ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
    '|' '||' ';' '&' '&&'
    '|&'
    '&!' '&|'
    # ### 'case' syntax, but followed by a pattern, not by a command
    # ';;' ';&' ';|'
  )
  ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS=(
    'builtin' 'command' 'exec' 'nocorrect' 'noglob'
    'pkexec' # immune to #121 because it's usually not passed --option flags
  )

  # Tokens that, at (naively-determined) "command position", are followed by
  # a de jure command position.  All of these are reserved words.
  ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW=(
    $'\x7b' # block
    $'\x28' # subshell
    '()' # anonymous function
    'while'
    'until'
    'if'
    'then'
    'elif'
    'else'
    'do'
    'time'
    'coproc'
    '!' # reserved word; unrelated to $histchars[1]
  )


  # State machine
  #
  # The states are:
  # - :start:      Command word
  # - :sudo_opt:   A leading-dash option to sudo (such as "-u" or "-i")
  # - :sudo_arg:   The argument to a sudo leading-dash option that takes one,
  #                when given as a separate word; i.e., "foo" in "-u foo" (two
  #                words) but not in "-ufoo" (one word).
  # - :regular:    "Not a command word", and command delimiters are permitted.
  #                Mainly used to detect premature termination of commands.
  #
  # When the kind of a word is not yet known, $this_word / $next_word may contain
  # multiple states.  For example, after "sudo -i", the next word may be either
  # another --flag or a command name, hence the state would include both :start:
  # and :sudo_opt:.
  #
  # The tokens are always added with both leading and trailing colons to serve as
  # word delimiters (an improvised array); [[ $x == *:foo:* ]] and x=${x//:foo:/} 
  # will DTRT regardless of how many elements or repetitions $x has..
  #
  # Handling of redirections: upon seeing a redirection token, we must stall
  # the current state --- that is, the value of $this_word --- for two iterations
  # (one for the redirection operator, one for the word following it representing
  # the redirection target).  Therefore, we set $in_redirection to 2 upon seeing a
  # redirection operator, decrement it each iteration, and stall the current state
  # when it is non-zero.  Thus, upon reaching the next word (the one that follows
  # the redirection operator and target), $this_word will still contain values
  # appropriate for the word immediately following the word that preceded the
  # redirection operator.
  #
  # The "the previous word was a redirection operator" state is not communicated
  # to the next iteration via $next_word/$this_word as usual, but via
  # $in_redirection.  The value of $next_word from the iteration that processed
  # the operator is discarded.
  #
  local this_word=':start:' next_word
  integer in_redirection
  for arg in ${interactive_comments-${(z)buf}} \
             ${interactive_comments+${(zZ+c+)buf}}; do
    if (( in_redirection )); then
      (( --in_redirection ))
    fi
    if (( in_redirection == 0 )); then
      # Initialize $next_word to its default value.
      next_word=':regular:'
    else
      # Stall $next_word.
    fi
    # $already_added is set to 1 to disable adding an entry to region_highlight
    # for this iteration.  Currently, that is done for "" and $'' strings,
    # which add the entry early so escape sequences within the string override
    # the string's color.
    integer already_added=0
    local style_override=""
    if [[ $this_word == *':start:'* ]]; then
      in_array_assignment=false
      if [[ $arg == 'noglob' ]]; then
        highlight_glob=false
      fi
    fi

    # advance $start_pos, skipping over whitespace in $buf.
    if [[ $arg == ';' ]] ; then
      # We're looking for either a semicolon or a newline, whichever comes
      # first.  Both of these are rendered as a ";" (SEPER) by the ${(z)..}
      # flag.
      #
      # We can't use the (Z+n+) flag because that elides the end-of-command
      # token altogether, so 'echo foo\necho bar' (two commands) becomes
      # indistinguishable from 'echo foo echo bar' (one command with three
      # words for arguments).
      local needle=$'[;\n]'
      integer offset=${${buf[start_pos+1,-1]}[(i)$needle]}
      (( start_pos += offset - 1 ))
      (( end_pos = start_pos + $#arg ))
    else
      ((start_pos+=${#buf[$start_pos+1,-1]}-${#${buf[$start_pos+1,-1]##([[:space:]]|\\[[:space:]])#}}))
      ((end_pos=$start_pos+${#arg}))
    fi

    if [[ -n ${interactive_comments+'set'} && $arg[1] == $histchars[3] ]]; then
      if [[ $this_word == *(':regular:'|':start:')* ]]; then
        style=$ZSH_HIGHLIGHT_STYLES[comment]
      else
        style=$ZSH_HIGHLIGHT_STYLES[unknown-token] # prematurely terminated
      fi
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
      already_added=1
      continue
    fi

    # Parse the sudo command line
    if (( ! in_redirection )); then
      if [[ $this_word == *':sudo_opt:'* ]]; then
        case "$arg" in
          # Flag that requires an argument
          '-'[Cgprtu]) this_word=${this_word//:start:/};
                       next_word=':sudo_arg:';;
          # This prevents misbehavior with sudo -u -otherargument
          '-'*)        this_word=${this_word//:start:/};
                       next_word+=':start:';
                       next_word+=':sudo_opt:';;
          *)           ;;
        esac
      elif [[ $this_word == *':sudo_arg:'* ]]; then
        next_word+=':sudo_opt:'
        next_word+=':start:'
      fi
    fi

    if [[ $this_word == *':start:'* ]] && (( in_redirection == 0 )); then # $arg is the command word
     if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]]; then
      style=$ZSH_HIGHLIGHT_STYLES[precommand]
     elif [[ "$arg" = "sudo" ]]; then
      style=$ZSH_HIGHLIGHT_STYLES[precommand]
      next_word=${next_word//:regular:/}
      next_word+=':sudo_opt:'
      next_word+=':start:'
     else
      _zsh_highlight_main_highlighter_expand_path $arg
      local expanded_arg="$REPLY"
      local res="$(_zsh_highlight_main__type ${expanded_arg})"
      () {
        # Special-case: command word is '$foo', like that, without braces or anything.
        #
        # That's not entirely correct --- if the parameter's value happens to be a reserved
        # word, the parameter expansion will be highlighted as a reserved word --- but that
        # incorrectness is outweighed by the usability improvement of permitting the use of
        # parameters that refer to commands, functions, and builtins.
        local -a match mbegin mend
        local MATCH; integer MBEGIN MEND
        if [[ $res == *': none' ]] && (( ${+parameters} )) &&
           [[ ${arg[1]} == \$ ]] && [[ ${arg:1} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+)$ ]]; then
          res="$(_zsh_highlight_main__type ${(P)MATCH})"
        fi
      }
      case $res in
        *': reserved')  style=$ZSH_HIGHLIGHT_STYLES[reserved-word];;
        *': suffix alias')
                        style=$ZSH_HIGHLIGHT_STYLES[suffix-alias]
                        ;;
        *': alias')     () {
                          integer insane_alias
                          case $arg in 
                            # Issue #263: aliases with '=' on their LHS.
                            #
                            # There are three cases:
                            #
                            # - Unsupported, breaks 'alias -L' output, but invokable:
                            ('='*) :;;
                            # - Unsupported, not invokable:
                            (*'='*) insane_alias=1;;
                            # - The common case:
                            (*) :;;
                          esac
                          if (( insane_alias )); then
                            style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                          else
                            style=$ZSH_HIGHLIGHT_STYLES[alias]
                            local aliased_command="${"$(alias -- $arg)"#*=}"
                            [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$aliased_command"} && -z ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]] && ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS+=($arg)
                          fi
                        }
                        ;;
        *': builtin')   style=$ZSH_HIGHLIGHT_STYLES[builtin];;
        *': function')  style=$ZSH_HIGHLIGHT_STYLES[function];;
        *': command')   style=$ZSH_HIGHLIGHT_STYLES[command];;
        *': hashed')    style=$ZSH_HIGHLIGHT_STYLES[hashed-command];;
        *)              if _zsh_highlight_main_highlighter_check_assign; then
                          style=$ZSH_HIGHLIGHT_STYLES[assign]
                          if [[ $arg[-1] == '(' ]]; then
                            in_array_assignment=true
                          else
                            # assignment to a scalar parameter.
                            # (For array assignments, the command doesn't start until the ")" token.)
                            next_word+=':start:'
                          fi
                        elif [[ $arg[0,1] == $histchars[0,1] || $arg[0,1] == $histchars[2,2] ]]; then
                          style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                        elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                          if [[ $this_word == *':regular:'* ]]; then
                            # This highlights empty commands (semicolon follows nothing) as an error.
                            # Zsh accepts them, though.
                            style=$ZSH_HIGHLIGHT_STYLES[commandseparator]
                          else
                            style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                          fi
                        elif [[ $arg == (<0-9>|)(\<|\>)* ]]; then
                          # A '<' or '>', possibly followed by a digit
                          style=$ZSH_HIGHLIGHT_STYLES[redirection]
                          (( in_redirection=2 ))
                        elif [[ $arg[1,2] == '((' ]]; then
                          # Arithmetic evaluation.
                          #
                          # Note: prior to zsh-5.1.1-52-g4bed2cf (workers/36669), the ${(z)...}
                          # splitter would only output the '((' token if the matching '))' had
                          # been typed.  Therefore, under those versions of zsh, BUFFER="(( 42"
                          # would be highlighted as an error until the matching "))" are typed.
                          #
                          # We highlight just the opening parentheses, as a reserved word; this
                          # is how [[ ... ]] is highlighted, too.
                          style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                          _zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) $style
                          already_added=1
                          if [[ $arg[-2,-1] == '))' ]]; then
                            _zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos $style
                            already_added=1
                          fi
                        elif [[ $arg == '()' || $arg == $'\x28' ]]; then
                          # anonymous function
                          # subshell
                          style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                        else
                          if _zsh_highlight_main_highlighter_check_path; then
                            style=$ZSH_HIGHLIGHT_STYLES[path]
                          else
                            style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                          fi
                        fi
                        ;;
      esac
     fi
    else # $arg is a non-command word
      case $arg in
        $'\x29') # subshell or end of array assignment
                 if $in_array_assignment; then
                   style=$ZSH_HIGHLIGHT_STYLES[assign]
                   in_array_assignment=false
                 else
                   style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                 fi;;
        $'\x7d') style=$ZSH_HIGHLIGHT_STYLES[reserved-word];; # block
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
        *.(cs|rs))     style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
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
        "'"*)    style=$ZSH_HIGHLIGHT_STYLES[single-quoted-argument];;
        '"'*)    style=$ZSH_HIGHLIGHT_STYLES[double-quoted-argument]
                 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                 _zsh_highlight_main_highlighter_highlight_string
                 already_added=1
                 ;;
        \$\'*)   style=$ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]
                 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                 _zsh_highlight_main_highlighter_highlight_dollar_string
                 already_added=1
                 ;;
        '`'*)    style=$ZSH_HIGHLIGHT_STYLES[back-quoted-argument];;
        [*?]*|*[^\\][*?]*)
                 $highlight_glob && style=$ZSH_HIGHLIGHT_STYLES[globbing] || style=$ZSH_HIGHLIGHT_STYLES[default];;
        *)       if false; then
                 elif [[ $arg[0,1] = $histchars[0,1] ]]; then
                   style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                 elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                   if [[ $this_word == *':regular:'* ]]; then
                     style=$ZSH_HIGHLIGHT_STYLES[commandseparator]
                   else
                     style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                   fi
                 elif [[ $arg == (<0-9>|)(\<|\>)* ]]; then
                   style=$ZSH_HIGHLIGHT_STYLES[redirection]
                   (( in_redirection=2 ))
                 else
                   if _zsh_highlight_main_highlighter_check_path; then
                     style=$ZSH_HIGHLIGHT_STYLES[path]
                   else
                     style=$ZSH_HIGHLIGHT_STYLES[default]
                   fi
                 fi
                 ;;
      esac
    fi
    # if a style_override was set (eg in _zsh_highlight_main_highlighter_check_path), use it
    [[ -n $style_override ]] && style=$ZSH_HIGHLIGHT_STYLES[$style_override]
    (( already_added )) || _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
    if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
      next_word=':start:'
      highlight_glob=true
    elif
       [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} && $this_word == *':start:'* ]] ||
       [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} && $this_word == *':start:'* ]]; then
      next_word=':start:'
    elif [[ $arg == "repeat" && $this_word == *':start:'* ]]; then
      # skip the repeat-count word
      in_redirection=2
      # The redirection mechanism assumes $this_word describes the word
      # following the redirection.  Make it so.
      #
      # The repeat-count word will be handled like a redirection target.
      this_word=':start:'
    fi
    start_pos=$end_pos
    (( in_redirection == 0 )) && this_word=$next_word
  done
}

# Check if $arg is variable assignment
_zsh_highlight_main_highlighter_check_assign()
{
    setopt localoptions extended_glob
    [[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]]
}

# Check if $arg is a path.
_zsh_highlight_main_highlighter_check_path()
{
  _zsh_highlight_main_highlighter_expand_path $arg;
  local expanded_path="$REPLY"

  [[ -z $expanded_path ]] && return 1
  [[ -e $expanded_path ]] && return 0

  # Search the path in CDPATH
  local cdpath_dir
  for cdpath_dir in $cdpath ; do
    [[ -e "$cdpath_dir/$expanded_path" ]] && return 0
  done

  # If dirname($arg) doesn't exist, neither does $arg.
  [[ ! -e ${expanded_path:h} ]] && return 1

  # If this word ends the buffer, check if it's the prefix of a valid path.
  if [[ ${BUFFER[1]} != "-" && ${#BUFFER} == $end_pos ]] &&
     [[ $WIDGET != accept-* ]]; then
    local -a tmp
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && style_override=path_prefix && return 0
  fi

  # It's not a path.
  return 1
}

# Highlight special chars inside double-quoted strings
_zsh_highlight_main_highlighter_highlight_string()
{
  setopt localoptions noksharrays
  local -a match mbegin mend
  local MATCH; integer MBEGIN MEND
  local i j k style
  # Starting quote is at 1, so start parsing at offset 2 in the string.
  for (( i = 2 ; i < end_pos - start_pos ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      '$' ) style=$ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]
            # Look for an alphanumeric parameter name.
            if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]] ; then
              (( k += $#MATCH )) # highlight the parameter name
              (( i += $#MATCH )) # skip past it
            elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]] ; then
              (( k += $#MATCH )) # highlight the parameter name and braces
              (( i += $#MATCH )) # skip past it
            else
              continue
            fi
            ;;
      "\\") style=$ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]
            if [[ \\\`\"\$ == *$arg[$i+1]* ]]; then
              (( k += 1 )) # Color following char too.
              (( i += 1 )) # Skip parsing the escaped char.
            else
              continue
            fi
            ;;
      *) continue ;;

    esac
    _zsh_highlight_main_add_region_highlight $j $k $style
  done
}

# Highlight special chars inside dollar-quoted strings
_zsh_highlight_main_highlighter_highlight_dollar_string()
{
  setopt localoptions noksharrays
  local -a match mbegin mend
  local MATCH; integer MBEGIN MEND
  local i j k style
  local AA
  integer c
  # Starting dollar-quote is at 1:2, so start parsing at offset 3 in the string.
  for (( i = 3 ; i < end_pos - start_pos ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      "\\") style=$ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]
            for (( c = i + 1 ; c <= end_pos - start_pos ; c += 1 )); do
              [[ "$arg[$c]" != ([0-9xXuUa-fA-F]) ]] && break
            done
            AA=$arg[$i+1,$c-1]
            # Matching for HEX and OCT values like \0xA6, \xA6 or \012
            if [[    "$AA" =~ "^(x|X)[0-9a-fA-F]{1,2}"
                  || "$AA" =~ "^[0-7]{1,3}"
                  || "$AA" =~ "^u[0-9a-fA-F]{1,4}"
                  || "$AA" =~ "^U[0-9a-fA-F]{1,8}"
               ]]; then
              (( k += $#MATCH ))
              (( i += $#MATCH ))
            else
              if (( $#arg > $i+1 )) && [[ $arg[$i+1] == [xXuU] ]]; then
                # \x not followed by hex digits is probably an error
                style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
              fi
              (( k += 1 )) # Color following char too.
              (( i += 1 )) # Skip parsing the escaped char.
            fi
            ;;
      *) continue ;;

    esac
    _zsh_highlight_main_add_region_highlight $j $k $style
  done
}

# Called with a single positional argument.
# Perform filename expansion (tilde expansion) on the argument and set $REPLY to the expanded value.
#
# Does not perform filename generation (globbing).
_zsh_highlight_main_highlighter_expand_path()
{
  (( $# == 1 )) || echo "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument" >&2

  # The $~1 syntax normally performs filename generation, but not when it's on the right-hand side of ${x:=y}.
  setopt localoptions nonomatch
  unset REPLY
  : ${REPLY:=${(Q)~1}}
}
