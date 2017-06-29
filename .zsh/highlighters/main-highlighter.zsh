#!/bin/zsh

ZSH_HIGHLIGHT_STYLES+=(
    default                         none
    unknown-token                   none
    suffix-alias                    fg=green,underline
    reserved-word                   fg=004
    alias                           fg=green
    builtin                         fg=green
    function                        fg=green,underline
    command                         fg=green

    precommand                      fg=green,underline 
    path                            fg=white
    path_prefix                     none
    path_approx                     fg=white
    # path_pathseparator
    # path_prefix_pathseparator

    hashed-command                  fg=green
    globbing                        fg=110
    history-expansion               fg=blue
    single-hyphen-option            fg=244
    double-hyphen-option            fg=244
    comment                         fg=221
    # redirection                   none
    # commandseparator              none

    back-quoted-argument            fg=024,bold
    single-quoted-argument          fg=024
    double-quoted-argument          fg=024
    dollar-double-quoted-argument   fg=004,bold
    back-double-quoted-argument     fg=024,bold
    back-dollar-quoted-argument     fg=024,bold
    assign                          fg=222,bold
)
ZSH_HIGHLIGHT_STYLES+=($(< ~/.zsh/highlighters/ft_list.zsh))

# Whether the highlighter should be called or not.
_zsh_highlight_highlighter_main_predicate()
{
  # may need to remove path_prefix highlighting when the line ends
  [[ $WIDGET == zle-line-finish ]] || _zsh_highlight_buffer_modified
}

# Helper to deal with tokens crossing line boundaries.
_zsh_highlight_main_add_region_highlight() {
  integer start=$1 end=$2
  shift 2

  if (( $+argv[2] )); then
    # Caller specified inheritance explicitly.
  else
    # Automate inheritance.
    typeset -A fallback_of; fallback_of=(
        alias arg0
        suffix-alias arg0
        builtin arg0
        function arg0
        command arg0
        precommand arg0
        hashed-command arg0
        
        path_prefix path
        # The path separator fallback won't ever be used, due to the optimisation
        # in _zsh_highlight_main_highlighter_highlight_path_separators().
        path_pathseparator path
        path_prefix_pathseparator path_prefix
    )
    local needle=$1 value
    while [[ -n ${value::=$fallback_of[$needle]} ]]; do
      unset "fallback_of[$needle]" # paranoia against infinite loops
      argv+=($value)
      needle=$value
    done
  fi

  # The calculation was relative to $PREBUFFER$BUFFER, but region_highlight is
  # relative to $BUFFER.
  (( start -= $#PREBUFFER ))
  (( end -= $#PREBUFFER ))

  (( end < 0 )) && return # having end<0 would be a bug
  (( start < 0 )) && start=0 # having start<0 is normal with e.g. multiline strings
  _zsh_highlight_add_highlight $start $end "$@"
}

# Get the type of a command.
#
# Uses the zsh/parameter module if available to avoid forks, and a
# wrapper around 'type -w' as fallback.
#
# Takes a single argument.
#
# The result will be stored in REPLY.
_zsh_highlight_main__type() {
  if (( $+_zsh_highlight_main__command_type_cache )); then
    REPLY=$_zsh_highlight_main__command_type_cache[(e)$1]
    if [[ -n "$REPLY" ]]; then
      return
    fi
  fi
  if (( $#options_to_set )); then
    setopt localoptions $options_to_set;
  fi
  unset REPLY
  if zmodload -e zsh/parameter; then
    if (( $+aliases[(e)$1] )); then
      REPLY=alias
    elif (( $+saliases[(e)${1##*.}] )); then
      REPLY='suffix alias'
    elif (( $reswords[(Ie)$1] )); then
      REPLY=reserved
    elif (( $+functions[(e)$1] )); then
      REPLY=function
    elif (( $+builtins[(e)$1] )); then
      REPLY=builtin
    elif (( $+commands[(e)$1] )); then
      REPLY=command
    # zsh 5.2 and older have a bug whereby running 'type -w ./sudo' implicitly
    # runs 'hash ./sudo=/usr/local/bin/./sudo' (assuming /usr/local/bin/sudo
    # exists and is in $PATH).  Avoid triggering the bug, at the expense of
    # falling through to the $() below, incurring a fork.  (Issue #354.)
    #
    # The first disjunct mimics the isrelative() C call from the zsh bug.
    elif {  [[ $1 != */* ]] || is-at-least 5.3 } &&
         ! builtin type -w -- $1 >/dev/null 2>&1; then
      REPLY=none
    fi
  fi
  if ! (( $+REPLY )); then
    REPLY="${$(LC_ALL=C builtin type -w -- $1 2>/dev/null)#*: }"
  fi
  if (( $+_zsh_highlight_main__command_type_cache )); then
    _zsh_highlight_main__command_type_cache[(e)$1]=$REPLY
  fi
}

# Check whether the first argument is a redirection operator token.
# Report result via the exit code.
_zsh_highlight_main__is_redirection() {
  # A redirection operator token:
  # - starts with an optional single-digit number;
  # - then, has a '<' or '>' character;
  # - is not a process substitution [<(...) or >(...)].
  [[ $1 == (<0-9>|)(\<|\>)* ]] && [[ $1 != (\<|\>)$'\x28'* ]]
}

# Resolve alias.
#
# Takes a single argument.
#
# The result will be stored in REPLY.
_zsh_highlight_main__resolve_alias() {
  if zmodload -e zsh/parameter; then
    REPLY=${aliases[$arg]}
  else
    REPLY="${"$(alias -- $arg)"#*=}"
  fi
}

# Check that the top of $braces_stack has the expected value.  If it does, set
# the style according to $2; otherwise, set style=unknown-token.
#
# $1: character expected to be at the top of $braces_stack
# $2: assignment to execute it if matches
_zsh_highlight_main__stack_pop() {
  if [[ $braces_stack[1] == $1 ]]; then
    braces_stack=${braces_stack:1}
    eval "$2"
  else
    style=unknown-token
  fi
}

# Main syntax highlighting function.
_zsh_highlight_highlighter_main_paint() 
{
  ## Before we even 'emulate -L', we must test a few options that would reset.
  if [[ -o interactive_comments ]]; then
    local interactive_comments= # set to empty
  fi
  if [[ -o ignore_braces ]] || eval '[[ -o ignore_close_braces ]] 2>/dev/null'; then
    local right_brace_is_recognised_everywhere=false
  else
    local right_brace_is_recognised_everywhere=true
  fi
  if [[ -o path_dirs ]]; then
    integer path_dirs_was_set=1
  else
    integer path_dirs_was_set=0
  fi
  if [[ -o multi_func_def ]]; then
    integer multi_func_def=1
  else
    integer multi_func_def=0
  fi
  emulate -L zsh
  setopt localoptions extendedglob bareglobqual

  # At the PS3 prompt and in vared, highlight nothing.
  #
  # (We can't check this in _zsh_highlight_highlighter_main_predicate because
  # if the predicate returns false, the previous value of region_highlight
  # would be reused.)
  if [[ $CONTEXT == (select|vared) ]]; then
    return
  fi

  ## Variable declarations and initializations
  local start_pos=0 end_pos highlight_glob=true arg style
  local in_array_assignment=false # true between 'a=(' and the matching ')'
  typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
  typeset -a ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
  typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
  local -a options_to_set # used in callees
  local buf="$PREBUFFER$BUFFER"
  integer len="${#buf}"
  integer pure_buf_len=$(( len - ${#PREBUFFER} ))   # == $#BUFFER, used e.g. in *_check_path

  # "R" for round
  # "Q" for square
  # "Y" for curly
  # "D" for do/done
  # "$" for 'end' (matches 'foreach' always; also used with cshjunkiequotes in repeat/while)
  local braces_stack

  if (( path_dirs_was_set )); then
    options_to_set+=( PATH_DIRS )
  fi
  unset path_dirs_was_set

  ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
    '|' '||' ';' '&' '&&'
    '|&'
    '&!' '&|'
    # ### 'case' syntax, but followed by a pattern, not by a command
    ';;' ';&' ';|'
  )
  ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS=(
    'builtin' 'command' 'exec' 'nocorrect' 'noglob' 'sudo' 's'
    'pkexec' # immune to #121 because it's usually not passed --option flags
  )
  ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
        '|' '||' ';' '&' '&&'
        '|&'
        '&!' '&|'
        # ### 'case' syntax, but followed by a pattern, not by a command
        ';;' ';&' ';|'
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

  local -a match mbegin mend

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
  # - :always:     The word 'always' in the «{ foo } always { bar }» syntax.
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
  # Processing buffer
  local proc_buf="$buf"
  for arg in ${interactive_comments-${(z)buf}} \
             ${interactive_comments+${(zZ+c+)buf}}; do
    # Initialize $next_word.
    if (( in_redirection )); then
      (( --in_redirection ))
    fi
    if (( in_redirection == 0 )); then
      # Initialize $next_word to its default value.
      next_word=':regular:'
    else
      # Stall $next_word.
    fi

    # Initialize per-"simple command" [zshmisc(1)] variables:
    #
    #   $already_added       (see next paragraph)
    #   $style               how to highlight $arg
    #   $in_array_assignment boolean flag for "between '(' and ')' of array assignment"
    #   $highlight_glob      boolean flag for "'noglob' is in effect"
    #
    # $already_added is set to 1 to disable adding an entry to region_highlight
    # for this iteration.  Currently, that is done for "" and $'' strings,
    # which add the entry early so escape sequences within the string override
    # the string's color.
    integer already_added=0
    style=unknown-token
    if [[ $this_word == *':start:'* ]]; then
      in_array_assignment=false
      if [[ $arg == 'noglob' ]]; then
        highlight_glob=false
      fi
    fi

    # Compute the new $start_pos and $end_pos, skipping over whitespace in $buf.
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
      integer offset=$(( ${proc_buf[(i)$needle]} - 1 ))
      (( start_pos += offset ))
      (( end_pos = start_pos + $#arg ))
    else
      # The line was:
      #
      # integer offset=$(((len-start_pos)-${#${proc_buf##([[:space:]]|\\[[:space:]])#}}))
      #
      # - len-start_pos is length of current proc_buf; basically: initial length minus where
      #   we are, and proc_buf is chopped to the "where we are" (compare the "previous value
      #   of start_pos" below, and the len-(start_pos-offset) = len-start_pos+offset)
      # - what's after main minus sign is: length of proc_buf without spaces at the beginning
      # - so what the line actually did, was computing length of the spaces!
      # - this can be done via (#b) flag, like below
      if [[ "$proc_buf" = (#b)(#s)(([[:space:]]|\\[[:space:]])##)* ]]; then
          # The first, outer parenthesis
          integer offset="${#match[1]}"
      else
          integer offset=0
      fi
      ((start_pos+=offset))
      ((end_pos=$start_pos+${#arg}))
    fi

    # Compute the new $proc_buf. We advance it
    # (chop off characters from the beginning)
    # beyond what end_pos points to, by skipping
    # as many characters as end_pos was advanced.
    #
    # end_pos was advanced by $offset (via start_pos)
    # and by $#arg. Note the `start_pos=$end_pos`
    # below.
    #
    # As for the [,len]. We could use [,len-start_pos+offset]
    # here, but to make it easier on eyes, we use len and
    # rely on the fact that Zsh simply handles that. The
    # length of proc_buf is len-start_pos+offset because
    # we're chopping it to match current start_pos, so its
    # length matches the previous value of start_pos.
    #
    # Why [,-1] is slower than [,length] isn't clear.
    proc_buf="${proc_buf[offset + $#arg + 1,len]}"

    # Handle the INTERACTIVE_COMMENTS option.
    #
    # We use the (Z+c+) flag so the entire comment is presented as one token in $arg.
    if [[ -n ${interactive_comments+'set'} && $arg[1] == $histchars[3] ]]; then
      if [[ $this_word == *(':regular:'|':start:')* ]]; then
        style=comment
      else
        style=unknown-token # prematurely terminated
      fi
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
      already_added=1
      continue
    fi

    # Analyse the current word.
    if _zsh_highlight_main__is_redirection $arg ; then
      # A '<' or '>', possibly followed by a digit
      in_redirection=2
    fi

    # Special-case the first word after 'sudo'.
    if (( ! in_redirection )); then
      if [[ $this_word == *':sudo_opt:'* ]] && [[ $arg != -* ]]; then
        this_word=${this_word//:sudo_opt:/}
      fi
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

   # The Great Fork: is this a command word?  Is this a non-command word?
   if [[ $this_word == *':always:'* && $arg == 'always' ]]; then
     # try-always construct
     style=reserved-word # de facto a reserved word, although not de jure
     next_word=':start:'
   elif [[ $this_word == *':start:'* ]] && (( in_redirection == 0 )); then # $arg is the command word
     if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]]; then
      style=precommand
     elif [[ "$arg" = "sudo" ]]; then
      style=precommand
      next_word=${next_word//:regular:/}
      next_word+=':sudo_opt:'
      next_word+=':start:'
     else
      _zsh_highlight_main_highlighter_expand_path $arg
      local expanded_arg="$REPLY"
      _zsh_highlight_main__type ${expanded_arg}
      local res="$REPLY"
      () {
        # Special-case: command word is '$foo', like that, without braces or anything.
        #
        # That's not entirely correct --- if the parameter's value happens to be a reserved
        # word, the parameter expansion will be highlighted as a reserved word --- but that
        # incorrectness is outweighed by the usability improvement of permitting the use of
        # parameters that refer to commands, functions, and builtins.
        local -a match mbegin mend
        local MATCH; integer MBEGIN MEND
        if [[ $res == none ]] && (( ${+parameters} )) &&
           [[ ${arg[1]} == \$ ]] && [[ ${arg:1} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+)$ ]] &&
           (( ${+parameters[${MATCH}]} ))
           then
          _zsh_highlight_main__type ${(P)MATCH}
          res=$REPLY
        fi
      }
      case $res in
        reserved)       # reserved word
                        style=reserved-word
                        case $arg in
                          ($'\x7b')
                            braces_stack='Y'"$braces_stack"
                            ;;
                          ($'\x7d')
                            # We're at command word, so no need to check $right_brace_is_recognised_everywhere
                            _zsh_highlight_main__stack_pop 'Y' style=reserved-word
                            if [[ $style == reserved-word ]]; then
                              next_word+=':always:'
                            fi
                            ;;
                          ('do')
                            braces_stack='D'"$braces_stack"
                            ;;
                          ('done')
                            _zsh_highlight_main__stack_pop 'D' style=reserved-word
                            ;;
                          ('foreach')
                            braces_stack='$'"$braces_stack"
                            ;;
                          ('end')
                            _zsh_highlight_main__stack_pop '$' style=reserved-word
                            ;;
                        esac
                        ;;
        'suffix alias') style=suffix-alias;;
        alias)          () {
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
                            style=unknown-token
                          else
                            style=alias
                            _zsh_highlight_main__resolve_alias $arg
                            local alias_target="$REPLY"
                            [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$alias_target"} && -z ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]] && ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS+=($arg)
                          fi
                        }
                        ;;
        builtin)        style=builtin;;
        function)       style=function;;
        command)        style=command;;
        hashed)         style=hashed-command;;
        none)           if _zsh_highlight_main_highlighter_check_assign; then
                          style=assign
                          if [[ $arg[-1] == '(' ]]; then
                            in_array_assignment=true
                          else
                            # assignment to a scalar parameter.
                            # (For array assignments, the command doesn't start until the ")" token.)
                            next_word+=':start:'
                          fi
                        elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                          style=history-expansion
                        elif [[ $arg[0,1] == $histchars[2,2] ]]; then
                          style=history-expansion
                        elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                          if [[ $this_word == *':regular:'* ]]; then
                            # This highlights empty commands (semicolon follows nothing) as an error.
                            # Zsh accepts them, though.
                            style=commandseparator
                          else
                            style=unknown-token
                          fi
                        elif (( in_redirection == 2 )); then
                          style=redirection
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
                          style=reserved-word
                          _zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) $style
                          already_added=1
                          if [[ $arg[-2,-1] == '))' ]]; then
                            _zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos $style
                            already_added=1
                          fi
                        elif [[ $arg == '()' ]]; then
                          # anonymous function
                          style=reserved-word
                        elif [[ $arg == $'\x28' ]]; then
                          # subshell
                          style=reserved-word
                          braces_stack='R'"$braces_stack"
                        elif [[ $arg == $'\x29' ]]; then
                          # end of subshell
                          _zsh_highlight_main__stack_pop 'R' style=reserved-word
                        else
                          if _zsh_highlight_main_highlighter_check_path; then
                            style=$REPLY
                          else
                            style=unknown-token
                          fi
                        fi
                        ;;
        *)              _zsh_highlight_main_add_region_highlight $start_pos $end_pos arg0_$res arg0
                        already_added=1
                        ;;
      esac
     fi
   fi
   if (( ! already_added )) && [[ $style == unknown-token ]] && # not handled by the 'command word' codepath
      { (( in_redirection )) || [[ $this_word == *':regular:'* ]] || [[ $this_word == *':sudo_opt:'* ]] || [[ $this_word == *':sudo_arg:'* ]] }
   then # $arg is a non-command word
      case $arg in
        $'\x29') # subshell or end of array assignment
                 if $in_array_assignment; then
                   style=assign
                   in_array_assignment=false
                   next_word+=':start:'
                 else
                   _zsh_highlight_main__stack_pop 'R' style=reserved-word
                 fi;;
        $'\x28\x29') # possibly a function definition
                 if (( multi_func_def )) || false # TODO: or if the previous word was a command word
                 then
                   next_word+=':start:'
                 fi
                 style=reserved-word
                 ;;
        $'\x7d') # right brace
                 #
                 # Parsing rule: # {
                 #
                 #     Additionally, `tt(})' is recognized in any position if neither the
                 #     tt(IGNORE_BRACES) option nor the tt(IGNORE_CLOSE_BRACES) option is set."""
                 if $right_brace_is_recognised_everywhere; then
                   _zsh_highlight_main__stack_pop 'Y' style=reserved-word
                   if [[ $style == reserved-word ]]; then
                     next_word+=':always:'
                   fi
                 else
                   # Fall through to the catchall case at the end.
                 fi
                 ;|
        #--[ Begining of ftype array ]------@@@@
        *.exe)                style=ftype-exe ;;
        *.com)                style=ftype-com ;;
        *.btm)                style=ftype-btm ;;
        *.bin)                style=ftype-bin ;;
        *.bat)                style=ftype-bat ;;
        *.cmd)                style=ftype-cmd ;;
        *.7z)                 style=ftype-7z ;;
        *.ace)                style=ftype-ace ;;
        *.alz)                style=ftype-alz ;;
        *.arc)                style=ftype-arc ;;
        *.arj)                style=ftype-arj ;;
        *.bz)                 style=ftype-bz ;;
        *.bz2)                style=ftype-bz2 ;;
        *.cpio)               style=ftype-cpio ;;
        *.dz)                 style=ftype-dz ;;
        *.gz)                 style=ftype-gz ;;
        *.lha)                style=ftype-lha ;;
        *.lrz)                style=ftype-lrz ;;
        *.lz)                 style=ftype-lz ;;
        *.lz4)                style=ftype-lz4 ;;
        *.lzh)                style=ftype-lzh ;;
        *.lzma)               style=ftype-lzma ;;
        *.rar)                style=ftype-rar ;;
        *.rz)                 style=ftype-rz ;;
        *.t7z)                style=ftype-t7z ;;
        *.tar)                style=ftype-tar ;;
        *.taz)                style=ftype-taz ;;
        *.tbz)                style=ftype-tbz ;;
        *.tbz2)               style=ftype-tbz2 ;;
        *.tgz)                style=ftype-tgz ;;
        *.tlz)                style=ftype-tlz ;;
        *.txz)                style=ftype-txz ;;
        *.tz)                 style=ftype-tz ;;
        *.tzo)                style=ftype-tzo ;;
        *.xz)                 style=ftype-xz ;;
        *.z)                  style=ftype-z ;;
        *.z)                  style=ftype-z ;;
        *.Z)                  style=ftype-Z ;;
        *.Z)                  style=ftype-Z ;;
        *.zip)                style=ftype-zip ;;
        *.ZIP)                style=ftype-ZIP ;;
        *.zoo)                style=ftype-zoo ;;
        *.apk)                style=ftype-apk ;;
        *.cab)                style=ftype-cab ;;
        *.deb)                style=ftype-deb ;;
        *.egg)                style=ftype-egg ;;
        *.gem)                style=ftype-gem ;;
        *.jad)                style=ftype-jad ;;
        *.msi)                style=ftype-msi ;;
        *.pkg)                style=ftype-pkg ;;
        *.rpm)                style=ftype-rpm ;;
        *.udeb)               style=ftype-udeb ;;
        *.xpi)                style=ftype-xpi ;;
        *.arj)                style=ftype-arj ;;
        *.ear)                style=ftype-ear ;;
        *.jar)                style=ftype-jar ;;
        *.sar)                style=ftype-sar ;;
        *.war)                style=ftype-war ;;
        *.qcow)               style=ftype-qcow ;;
        *.qcow2)              style=ftype-qcow2 ;;
        *.vmdk)               style=ftype-vmdk ;;
        *.vdi)                style=ftype-vdi ;;
        *.jpeg)               style=ftype-jpeg ;;
        *.jpg)                style=ftype-jpg ;;
        *.JPG)                style=ftype-JPG ;;
        *.bmp)                style=ftype-bmp ;;
        *.pbm)                style=ftype-pbm ;;
        *.pgm)                style=ftype-pgm ;;
        *.ppm)                style=ftype-ppm ;;
        *.psd)                style=ftype-psd ;;
        *.tga)                style=ftype-tga ;;
        *.xbm)                style=ftype-xbm ;;
        *.xpm)                style=ftype-xpm ;;
        *.tif)                style=ftype-tif ;;
        *.tiff)               style=ftype-tiff ;;
        *.cgm)                style=ftype-cgm ;;
        *.CR2)                style=ftype-CR2 ;;
        *.dl)                 style=ftype-dl ;;
        *.emf)                style=ftype-emf ;;
        *.eps)                style=ftype-eps ;;
        *.mng)                style=ftype-mng ;;
        *.pcx)                style=ftype-pcx ;;
        *.png)                style=ftype-png ;;
        *.bpg)                style=ftype-bpg ;;
        *.svg)                style=ftype-svg ;;
        *.svgz)               style=ftype-svgz ;;
        *.xcf)                style=ftype-xcf ;;
        *.xwd)                style=ftype-xwd ;;
        *.yuv)                style=ftype-yuv ;;
        *.gif)                style=ftype-gif ;;
        *.icns)               style=ftype-icns ;;
        *.ico)                style=ftype-ico ;;
        *.aux)                style=ftype-aux ;;
        *.bak)                style=ftype-bak ;;
        *.bbl)                style=ftype-bbl ;;
        *.blg)                style=ftype-blg ;;
        *.cache)              style=ftype-cache ;;
        *.class)              style=ftype-class ;;
        *.incomplete)         style=ftype-incomplete ;;
        *.log)                style=ftype-log ;;
        *.o)                  style=ftype-o ;;
        *.part)               style=ftype-part ;;
        *.pyc)                style=ftype-pyc ;;
        *.swp)                style=ftype-swp ;;
        *.temp)               style=ftype-temp ;;
        *.tmp)                style=ftype-tmp ;;
        *.chm)                style=ftype-chm ;;
        *.djv)                style=ftype-djv ;;
        *.djvu)               style=ftype-djvu ;;
        *.dvi)                style=ftype-dvi ;;
        *.epub)               style=ftype-epub ;;
        *.fb2)                style=ftype-fb2 ;;
        *.lit)                style=ftype-lit ;;
        *.mobi)               style=ftype-mobi ;;
        *.pdf)                style=ftype-pdf ;;
        *.markdown)           style=ftype-markdown ;;
        *.md)                 style=ftype-md ;;
        *.org)                style=ftype-org ;;
        *.mf)                 style=ftype-mf ;;
        *.mkd)                style=ftype-mkd ;;
        *.mfasl)              style=ftype-mfasl ;;
        *.txt)                style=ftype-txt ;;
        *.doc)                style=ftype-doc ;;
        *.docm)               style=ftype-docm ;;
        *.docx)               style=ftype-docx ;;
        *.dot)                style=ftype-dot ;;
        *.dotm)               style=ftype-dotm ;;
        *.odm)                style=ftype-odm ;;
        *.odt)                style=ftype-odt ;;
        *.pages)              style=ftype-pages ;;
        *.rtf)                style=ftype-rtf ;;
        *.gnumeric)           style=ftype-gnumeric ;;
        *.xla)                style=ftype-xla ;;
        *.xls)                style=ftype-xls ;;
        *.xlsm)               style=ftype-xlsm ;;
        *.xlsx)               style=ftype-xlsx ;;
        *.chrt)               style=ftype-chrt ;;
        *.ppt)                style=ftype-ppt ;;
        *.pptx)               style=ftype-pptx ;;
        *.odb)                style=ftype-odb ;;
        *.odp)                style=ftype-odp ;;
        *.ods)                style=ftype-ods ;;
        *.db)                 style=ftype-db ;;
        *.ldf)                style=ftype-ldf ;;
        *.mdb)                style=ftype-mdb ;;
        *.mdf)                style=ftype-mdf ;;
        *.odb)                style=ftype-odb ;;
        *.sql)                style=ftype-sql ;;
        *.sqlite)             style=ftype-sqlite ;;
        *.asm)                style=ftype-asm ;;
        *.asoundrc)           style=ftype-asoundrc ;;
        *.mutt)               style=ftype-mutt ;;
        *.awk)                style=ftype-awk ;;
        *.coffee)             style=ftype-coffee ;;
        *.cs)                 style=ftype-cs ;;
        *.css)                style=ftype-css ;;
        *.sass)               style=ftype-sass ;;
        *.scss)               style=ftype-scss ;;
        *.less)               style=ftype-less ;;
        *.csv)                style=ftype-csv ;;
        *.dir_colors)         style=ftype-dir_colors ;;
        *.enc)                style=ftype-enc ;;
        *.eps)                style=ftype-eps ;;
        *.eps2)               style=ftype-eps2 ;;
        *.eps3)               style=ftype-eps3 ;;
        *.epsf)               style=ftype-epsf ;;
        *.epsi)               style=ftype-epsi ;;
        *.ps)                 style=ftype-ps ;;
        *.etx)                style=ftype-etx ;;
        *.ex)                 style=ftype-ex ;;
        *.example)            style=ftype-example ;;
        *.fehbg)              style=ftype-fehbg ;;
        *.fonts)              style=ftype-fonts ;;
        *.git)                style=ftype-git ;;
        *.gitignore)          style=ftype-gitignore ;;
        *.htm)                style=ftype-htm ;;
        *.html)               style=ftype-html ;;
        *.jhtm)               style=ftype-jhtm ;;
        *.hgrc)               style=ftype-hgrc ;;
        *.hgignore)           style=ftype-hgignore ;;
        *.hs)                 style=ftype-hs ;;
        *.agda)               style=ftype-agda ;;
        *.htoprc)             style=ftype-htoprc ;;
        *.info)               style=ftype-info ;;
        *.java)               style=ftype-java ;;
        *.e)                  style=ftype-e ;;
        *.js)                 style=ftype-js ;;
        *.jsm)                style=ftype-jsm ;;
        *.jsp)                style=ftype-jsp ;;
        *.lisp)               style=ftype-lisp ;;
        *.scm)                style=ftype-scm ;;
        *.lam)                style=ftype-lam ;;
        *.lesshst)            style=ftype-lesshst ;;
        *.log)                style=ftype-log ;;
        *.lua)                style=ftype-lua ;;
        *.map)                style=ftype-map ;;
        *.mf)                 style=ftype-mf ;;
        *.mfasl)              style=ftype-mfasl ;;
        *.mi)                 style=ftype-mi ;;
        *.msmtprc)            style=ftype-msmtprc ;;
        *.mtx)                style=ftype-mtx ;;
        *.muttrc)             style=ftype-muttrc ;;
        *.netrc)              style=ftype-netrc ;;
        *.nfo)                style=ftype-nfo ;;
        *.offlineimaprc)      style=ftype-offlineimaprc ;;
        *.pacnew)             style=ftype-pacnew ;;
        *.patch)              style=ftype-patch ;;
        *.diff)               style=ftype-diff ;;
        *.pc)                 style=ftype-pc ;;
        *.pfa)                style=ftype-pfa ;;
        *.php)                style=ftype-php ;;
        *.pid)                style=ftype-pid ;;
        *.pl)                 style=ftype-pl ;;
        *.PL)                 style=ftype-PL ;;
        *.pm)                 style=ftype-pm ;;
        *.pod)                style=ftype-pod ;;
        *.py)                 style=ftype-py ;;
        *.rc)                 style=ftype-rc ;;
        *.erb)                style=ftype-erb ;;
        *.irb)                style=ftype-irb ;;
        *.rb)                 style=ftype-rb ;;
        *.ru)                 style=ftype-ru ;;
        *.sed)                style=ftype-sed ;;
        *.signature)          style=ftype-signature ;;
        *.sty)                style=ftype-sty ;;
        *.sug)                style=ftype-sug ;;
        *.t)                  style=ftype-t ;;
        *.tcl)                style=ftype-tcl ;;
        *.tk)                 style=ftype-tk ;;
        *.tdy)                style=ftype-tdy ;;
        *.tfm)                style=ftype-tfm ;;
        *.tfnt)               style=ftype-tfnt ;;
        *.theme)              style=ftype-theme ;;
        *.tdesktop-theme)     style=ftype-tdesktop-theme ;;
        *.tdesktop-pallete)   style=ftype-tdesktop-pallete ;;
        *.attheme)            style=ftype-attheme ;;
        *.vim)                style=ftype-vim ;;
        *.viminfo)            style=ftype-viminfo ;;
        *.vimp)               style=ftype-vimp ;;
        *.vimrc)              style=ftype-vimrc ;;
        *.bash)               style=ftype-bash ;;
        *.bash_history)       style=ftype-bash_history ;;
        *.csh)                style=ftype-csh ;;
        *.dash)               style=ftype-dash ;;
        *.ksh)                style=ftype-ksh ;;
        *.sh)                 style=ftype-sh ;;
        *.sh*)                style=ftype-sh* ;;
        *.tcsh)               style=ftype-tcsh ;;
        *.zsh)                style=ftype-zsh ;;
        *.bash_logout)        style=ftype-bash_logout ;;
        *.bash_profile)       style=ftype-bash_profile ;;
        *.profile)            style=ftype-profile ;;
        *.ttytterrc)          style=ftype-ttytterrc ;;
        *.urlview)            style=ftype-urlview ;;
        *.Xauthority)         style=ftype-Xauthority ;;
        *.xinitrc)            style=ftype-xinitrc ;;
        *.Xmodmap)            style=ftype-Xmodmap ;;
        *.Xresources)         style=ftype-Xresources ;;
        *.dmg)                style=ftype-dmg ;;
        *.img)                style=ftype-img ;;
        *.iso)                style=ftype-iso ;;
        *.ISO)                style=ftype-ISO ;;
        *.mdf)                style=ftype-mdf ;;
        *.nrg)                style=ftype-nrg ;;
        *.vcd)                style=ftype-vcd ;;
        *.allow)              style=ftype-allow ;;
        *.deny)               style=ftype-deny ;;
        *.icls)               style=ftype-icls ;;
        *.jidgo)              style=ftype-jidgo ;;
        *.tex)                style=ftype-tex ;;
        *.latex)              style=ftype-latex ;;
        *.n3)                 style=ftype-n3 ;;
        *.nfo)                style=ftype-nfo ;;
        *.nt)                 style=ftype-nt ;;
        *.owl)                style=ftype-owl ;;
        *.rc)                 style=ftype-rc ;;
        *.rdf)                style=ftype-rdf ;;
        *.aux)                style=ftype-aux ;;
        *.textile)            style=ftype-textile ;;
        *.torrent)            style=ftype-torrent ;;
        *.ttl)                style=ftype-ttl ;;
        *.xml)                style=ftype-xml ;;
        *.qml)                style=ftype-qml ;;
        *.yaml)               style=ftype-yaml ;;
        *.cfg)                style=ftype-cfg ;;
        *.conf)               style=ftype-conf ;;
        *.ini)                style=ftype-ini ;;
        *.toml)               style=ftype-toml ;;
        *.json)               style=ftype-json ;;
        *.yml)                style=ftype-yml ;;
        *.yml)                style=ftype-yml ;;
        *.ffp)                style=ftype-ffp ;;
        *.gpg)                style=ftype-gpg ;;
        *.md5)                style=ftype-md5 ;;
        *.par)                style=ftype-par ;;
        *.sfv)                style=ftype-sfv ;;
        *.sha1)               style=ftype-sha1 ;;
        *.st5)                style=ftype-st5 ;;
        *.alac)               style=ftype-alac ;;
        *.flac)               style=ftype-flac ;;
        *.ape)                style=ftype-ape ;;
        *.aac)                style=ftype-aac ;;
        *.au)                 style=ftype-au ;;
        *.axa)                style=ftype-axa ;;
        *.m4a)                style=ftype-m4a ;;
        *.m4b)                style=ftype-m4b ;;
        *.m4r)                style=ftype-m4r ;;
        *.mid)                style=ftype-mid ;;
        *.midi)               style=ftype-midi ;;
        *.mka)                style=ftype-mka ;;
        *.mp2)                style=ftype-mp2 ;;
        *.mp3)                style=ftype-mp3 ;;
        *.mpc)                style=ftype-mpc ;;
        *.oga)                style=ftype-oga ;;
        *.ogg)                style=ftype-ogg ;;
        *.ra)                 style=ftype-ra ;;
        *.spx)                style=ftype-spx ;;
        *.wav)                style=ftype-wav ;;
        *.wma)                style=ftype-wma ;;
        *.cue)                style=ftype-cue ;;
        *.m3u)                style=ftype-m3u ;;
        *.m3u8)               style=ftype-m3u8 ;;
        *.pls)                style=ftype-pls ;;
        *.xspf)               style=ftype-xspf ;;
        *.dat)                style=ftype-dat ;;
        *.fcm)                style=ftype-fcm ;;
        *.m4)                 style=ftype-m4 ;;
        *.mod)                style=ftype-mod ;;
        *.oga)                style=ftype-oga ;;
        *.s3m)                style=ftype-s3m ;;
        *.S3M)                style=ftype-S3M ;;
        *.sid)                style=ftype-sid ;;
        *.spl)                style=ftype-spl ;;
        *.wv)                 style=ftype-wv ;;
        *.wvc)                style=ftype-wvc ;;
        *.asf)                style=ftype-asf ;;
        *.avi)                style=ftype-avi ;;
        *.AVI)                style=ftype-AVI ;;
        *.divx)               style=ftype-divx ;;
        *.flc)                style=ftype-flc ;;
        *.fli)                style=ftype-fli ;;
        *.flv)                style=ftype-flv ;;
        *.gl)                 style=ftype-gl ;;
        *.m2ts)               style=ftype-m2ts ;;
        *.m2v)                style=ftype-m2v ;;
        *.m4v)                style=ftype-m4v ;;
        *.mkv)                style=ftype-mkv ;;
        *.mov)                style=ftype-mov ;;
        *.MOV)                style=ftype-MOV ;;
        *.mp4)                style=ftype-mp4 ;;
        *.mp4v)               style=ftype-mp4v ;;
        *.mpeg)               style=ftype-mpeg ;;
        *.mpg)                style=ftype-mpg ;;
        *.nuv)                style=ftype-nuv ;;
        *.ogm)                style=ftype-ogm ;;
        *.ogv)                style=ftype-ogv ;;
        *.qt)                 style=ftype-qt ;;
        *.rm)                 style=ftype-rm ;;
        *.rmvb)               style=ftype-rmvb ;;
        *.sample)             style=ftype-sample ;;
        *.ts)                 style=ftype-ts ;;
        *.vob)                style=ftype-vob ;;
        *.VOB)                style=ftype-VOB ;;
        *.webm)               style=ftype-webm ;;
        *.wmv)                style=ftype-wmv ;;
        *.anx)                style=ftype-anx ;;
        *.axv)                style=ftype-axv ;;
        *.ogx)                style=ftype-ogx ;;
        *.ass)                style=ftype-ass ;;
        *.srt)                style=ftype-srt ;;
        *.bdf)                style=ftype-bdf ;;
        *.dfont)              style=ftype-dfont ;;
        *.fon)                style=ftype-fon ;;
        *.gsf)                style=ftype-gsf ;;
        *.otf)                style=ftype-otf ;;
        *.pcf)                style=ftype-pcf ;;
        *.pfa)                style=ftype-pfa ;;
        *.pfb)                style=ftype-pfb ;;
        *.ttf)                style=ftype-ttf ;;
        *.adf)                style=ftype-adf ;;
        *.fm2)                style=ftype-fm2 ;;
        *.32x)                style=ftype-32x ;;
        *.a00)                style=ftype-a00 ;;
        *.a52)                style=ftype-a52 ;;
        *.a64)                style=ftype-a64 ;;
        *.A64)                style=ftype-A64 ;;
        *.a78)                style=ftype-a78 ;;
        *.atr)                style=ftype-atr ;;
        *.cdi)                style=ftype-cdi ;;
        *.gb)                 style=ftype-gb ;;
        *.gba)                style=ftype-gba ;;
        *.gbc)                style=ftype-gbc ;;
        *.gel)                style=ftype-gel ;;
        *.gg)                 style=ftype-gg ;;
        *.ggl)                style=ftype-ggl ;;
        *.j64)                style=ftype-j64 ;;
        *.nds)                style=ftype-nds ;;
        *.nes)                style=ftype-nes ;;
        *.rom)                style=ftype-rom ;;
        *.sav)                style=ftype-sav ;;
        *.sms)                style=ftype-sms ;;
        *.desktop)            style=ftype-desktop ;;
        *.automount)          style=ftype-automount ;;
        *.device)             style=ftype-device ;;
        *.mount)              style=ftype-mount ;;
        *.path)               style=ftype-path ;;
        *.service)            style=ftype-service ;;
        *.snapshot)           style=ftype-snapshot ;;
        *.socket)             style=ftype-socket ;;
        *.swap)               style=ftype-swap ;;
        *.target)             style=ftype-target ;;
        *.timer)              style=ftype-timer ;;
        *.c)                  style=ftype-c ;;
        *.c++)                style=ftype-c++ ;;
        *.C)                  style=ftype-C ;;
        *.cc)                 style=ftype-cc ;;
        *.cp)                 style=ftype-cp ;;
        *.cpp)                style=ftype-cpp ;;
        *.cs)                 style=ftype-cs ;;
        *.cxx)                style=ftype-cxx ;;
        *.erl)                style=ftype-erl ;;
        *.go)                 style=ftype-go ;;
        *.ii)                 style=ftype-ii ;;
        *.ml)                 style=ftype-ml ;;
        *.rs)                 style=ftype-rs ;;
        *.rst)                style=ftype-rst ;;
        *.swift)              style=ftype-swift ;;
        *.pas)                style=ftype-pas ;;
        *.scala)              style=ftype-scala ;;
        *.clj)                style=ftype-clj ;;
        *.el)                 style=ftype-el ;;
        *.f)                  style=ftype-f ;;
        *.for)                style=ftype-for ;;
        *.ftn)                style=ftype-ftn ;;
        *.h)                  style=ftype-h ;;
        *.h++)                style=ftype-h++ ;;
        *.H)                  style=ftype-H ;;
        *.hh)                 style=ftype-hh ;;
        *.hpp)                style=ftype-hpp ;;
        *.hxx)                style=ftype-hxx ;;
        *.s)                  style=ftype-s ;;
        *.S)                  style=ftype-S ;;
        *.sx)                 style=ftype-sx ;;
        *.tcc)                style=ftype-tcc ;;
        *.am)                 style=ftype-am ;;
        *.in)                 style=ftype-in ;;
        *.old)                style=ftype-old ;;
        *.cap)                style=ftype-cap ;;
        *.dmp)                style=ftype-dmp ;;
        *.dump)               style=ftype-dump ;;
        *.pcap)               style=ftype-pcap ;;
        *.am)                 style=ftype-am ;;
        *.in)                 style=ftype-in ;;
        *.old)                style=ftype-old ;;
        #--[ End of ftype array ]-----------@@@@
        '--'*)   style=double-hyphen-option;;
        '-'*)    style=single-hyphen-option;;
        "'"*)    style=single-quoted-argument;;
        '"'*)    style=double-quoted-argument
                 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                 _zsh_highlight_main_highlighter_highlight_string
                 already_added=1
                 ;;
        \$\'*)   style=dollar-quoted-argument
                 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                 _zsh_highlight_main_highlighter_highlight_dollar_string
                 already_added=1
                 ;;
        '`'*)    style=back-quoted-argument;;
        [*?]*|*[^\\][*?]*)
                 $highlight_glob && style=globbing || style=default;;
        *)       if false; then
                 elif [[ $arg = $'\x7d' ]] && $right_brace_is_recognised_everywhere; then
                   # was handled by the $'\x7d' case above
                 elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                   style=history-expansion
                 elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                   if [[ $this_word == *':regular:'* ]]; then
                     style=commandseparator
                   else
                     style=unknown-token
                   fi
                 elif (( in_redirection == 2 )); then
                   style=redirection
                 else
                   if _zsh_highlight_main_highlighter_check_path; then
                     style=$REPLY
                   else
                     style=default
                   fi
                 fi
                 ;;
      esac
    fi
    if ! (( already_added )); then
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
      [[ $style == path || $style == path_prefix ]] && _zsh_highlight_main_highlighter_highlight_path_separators
    fi
    if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
      if [[ $arg == ';' ]] && $in_array_assignment; then
        # literal newline inside an array assignment
        next_word=':regular:'
      else
        next_word=':start:'
        highlight_glob=true
      fi
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
      # That word can be a command word with shortloops (`repeat 2 ls`)
      # or a command separator (`repeat 2; ls` or `repeat 2; do ls; done`).
      #
      # The repeat-count word will be handled like a redirection target.
      this_word=':start::regular:'
    fi
    start_pos=$end_pos
    if (( in_redirection == 0 )); then
      # This is the default/common codepath.
      this_word=$next_word
    else
      # Stall $this_word.
    fi
  done
}

# Check if $arg is variable assignment
_zsh_highlight_main_highlighter_check_assign()
{
    setopt localoptions extended_glob
    [[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]] ||
      [[ $arg == [0-9]##(|[+])=* ]]
}

_zsh_highlight_main_highlighter_highlight_path_separators()
{
  local pos style_pathsep
  style_pathsep=${style}_pathseparator
  [[ -z "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" || "$ZSH_HIGHLIGHT_STYLES[$style]" == "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" ]] && return 0
  for (( pos = start_pos; $pos <= end_pos; pos++ )) ; do
    if [[ $BUFFER[pos] == / ]]; then
      _zsh_highlight_main_add_region_highlight $((pos - 1)) $pos $style_pathsep
    fi
  done
}

# Check if $arg is a path.
# If yes, return 0 and in $REPLY the style to use.
# Else, return non-zero (and the contents of $REPLY is undefined).
_zsh_highlight_main_highlighter_check_path()
{
  _zsh_highlight_main_highlighter_expand_path $arg;
  local expanded_path="$REPLY"

  REPLY=path

  [[ -d $expanded_path ]] && return 0

  # Search the path in CDPATH
  local cdpath_dir
  for cdpath_dir in $cdpath ; do
    [[ -d "$cdpath_dir/$expanded_path" ]] && return 0
  done

  # If dirname($arg) doesn't exist, neither does $arg.
  [[ ! -d ${expanded_path:h} ]] && return 1

  # If this word ends the buffer, check if it's the prefix of a valid path.
  if [[ ${BUFFER[1]} != "-" && $pure_buf_len == $end_pos ]] &&
     [[ $WIDGET != zle-line-finish ]]; then
    local -a tmp
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && REPLY=path_prefix && return 0
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
      '$' ) style=dollar-double-quoted-argument
            # Look for an alphanumeric parameter name.
            if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]] ; then
              (( k += $#MATCH )) # highlight the parameter name
              (( i += $#MATCH )) # skip past it
            elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]] ; then
              (( k += $#MATCH )) # highlight the parameter name and braces
              (( i += $#MATCH )) # skip past it
            elif [[ $arg[i+1] == '$' ]]; then
              # $$ - pid
              (( k += 1 )) # highlight both dollar signs
              (( i += 1 )) # don't consider the second one as introducing another parameter expansion
            elif [[ $arg[i+1] == [-#*@?] ]]; then
              # $#, $*, $@, $?, $- - like $$ above
              (( k += 1 )) # highlight both dollar signs
              (( i += 1 )) # don't consider the second one as introducing another parameter expansion
            elif [[ $arg[i+1] == $'\x28' ]]; then
              # Highlight just the '$'.
            else
              continue
            fi
            ;;
      "\\") style=back-double-quoted-argument
            if [[ \\\`\"\$${histchars[1]} == *$arg[$i+1]* ]]; then
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
      "\\") style=back-dollar-quoted-argument
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
                style=unknown-token
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
  (( $# == 1 )) || print -r -- >&2 "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument"

  # The $~1 syntax normally performs filename generation, but not when it's on the right-hand side of ${x:=y}.
  setopt localoptions nonomatch
  unset REPLY
  : ${REPLY:=${(Q)~1}}
}

# -------------------------------------------------------------------------------------------------
# Main highlighter initialization
# -------------------------------------------------------------------------------------------------

_zsh_highlight_main__precmd_hook() {
  _zsh_highlight_main__command_type_cache=()
}

autoload -U add-zsh-hook
if add-zsh-hook precmd _zsh_highlight_main__precmd_hook 2>/dev/null; then
  # Initialize command type cache
  typeset -gA _zsh_highlight_main__command_type_cache
else
  print -r -- >&2 'zsh-syntax-highlighting: Failed to load add-zsh-hook. Some speed optimizations will not be used.'
  # Make sure the cache is unset
  unset _zsh_highlight_main__command_type_cache
fi
