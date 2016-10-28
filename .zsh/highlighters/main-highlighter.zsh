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
    path_prefix                     none
    path                            fg=white
    path_approx                     fg=white

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
                 *.exe)             style=$ZSH_HIGHLIGHT_STYLES[ftype-exe];;
                 *.com)             style=$ZSH_HIGHLIGHT_STYLES[ftype-com];;
                 *.btm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-btm];;
                 *.bin)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bin];;
                 *.bat)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bat];;
                 *.cmd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cmd];;
                 *.tar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tar];;
                 *.tgz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tgz];;
                 *.taz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-taz];;
                 *.lzh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lzh];;
                 *.lzma)            style=$ZSH_HIGHLIGHT_STYLES[ftype-lzma];;
                 *.tlz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tlz];;
                 *.txz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-txz];;
                 *.zip)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zip];;
                 *.ZIP)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ZIP];;
                 *.z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-z];;
                 *.Z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-Z];;
                 *.dz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-dz];;
                 *.gz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gz];;
                 *.lz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-lz];;
                 *.xz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-xz];;
                 *.bz2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bz2];;
                 *.bz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-bz];;
                 *.tbz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tbz];;
                 *.tbz2)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tbz2];;
                 *.tz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-tz];;
                 *.rar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rar];;
                 *.ace)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ace];;
                 *.zoo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zoo];;
                 *.cpio)            style=$ZSH_HIGHLIGHT_STYLES[ftype-cpio];;
                 *.7z)              style=$ZSH_HIGHLIGHT_STYLES[ftype-7z];;
                 *.lrz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lrz];;
                 *.rz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rz];;
                 *.z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-z];;
                 *.Z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-Z];;
                 *.jar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jar];;
                 *.arj)             style=$ZSH_HIGHLIGHT_STYLES[ftype-arj];;
                 *.rpm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rpm];;
                 *.cab)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cab];;
                 *.deb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-deb];;
                 *.udeb)            style=$ZSH_HIGHLIGHT_STYLES[ftype-udeb];;
                 *.apk)             style=$ZSH_HIGHLIGHT_STYLES[ftype-apk];;
                 *.xpi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xpi];;
                 *.egg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-egg];;
                 *.pkg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pkg];;
                 *.jad)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jad];;
                 *.gem)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gem];;
                 *.msi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-msi];;
                 *.qcow)            style=$ZSH_HIGHLIGHT_STYLES[ftype-qcow];;
                 *.qcow2)           style=$ZSH_HIGHLIGHT_STYLES[ftype-qcow2];;
                 *.vmdk)            style=$ZSH_HIGHLIGHT_STYLES[ftype-vmdk];;
                 *.vdi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vdi];;
                 *.jpg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jpg];;
                 *.JPG)             style=$ZSH_HIGHLIGHT_STYLES[ftype-JPG];;
                 *.jpeg)            style=$ZSH_HIGHLIGHT_STYLES[ftype-jpeg];;
                 *.bmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bmp];;
                 *.pbm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pbm];;
                 *.pgm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pgm];;
                 *.ppm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ppm];;
                 *.tga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tga];;
                 *.psd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-psd];;
                 *.xbm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xbm];;
                 *.xpm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xpm];;
                 *.tif)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tif];;
                 *.tiff)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tiff];;
                 *.png)             style=$ZSH_HIGHLIGHT_STYLES[ftype-png];;
                 *.mng)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mng];;
                 *.pcx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pcx];;
                 *.dl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-dl];;
                 *.xcf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xcf];;
                 *.xwd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xwd];;
                 *.yuv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yuv];;
                 *.cgm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cgm];;
                 *.emf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-emf];;
                 *.eps)             style=$ZSH_HIGHLIGHT_STYLES[ftype-eps];;
                 *.CR2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-CR2];;
                 *.svg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-svg];;
                 *.svgz)            style=$ZSH_HIGHLIGHT_STYLES[ftype-svgz];;
                 *.gif)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gif];;
                 *.ico)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ico];;
                 *.icns)            style=$ZSH_HIGHLIGHT_STYLES[ftype-icns];;
                 *.log)             style=$ZSH_HIGHLIGHT_STYLES[ftype-log];;
                 *.bak)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bak];;
                 *.aux)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aux];;
                 *.bbl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bbl];;
                 *.blg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-blg];;
                 *.part)            style=$ZSH_HIGHLIGHT_STYLES[ftype-part];;
                 *.incomplete)      style=$ZSH_HIGHLIGHT_STYLES[ftype-incomplete];;
                 *.swp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-swp];;
                 *.tmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tmp];;
                 *.temp)            style=$ZSH_HIGHLIGHT_STYLES[ftype-temp];;
                 *.o)               style=$ZSH_HIGHLIGHT_STYLES[ftype-o];;
                 *.pyc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pyc];;
                 *.class)           style=$ZSH_HIGHLIGHT_STYLES[ftype-class];;
                 *.cache)           style=$ZSH_HIGHLIGHT_STYLES[ftype-cache];;
                 *.djvu)            style=$ZSH_HIGHLIGHT_STYLES[ftype-djvu];;
                 *.djv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-djv];;
                 *.pdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pdf];;
                 *.epub)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epub];;
                 *.mobi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mobi];;
                 *.lit)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lit];;
                 *.fb2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fb2];;
                 *.dvi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dvi];;
                 *.chm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-chm];;
                 *.markdown)        style=$ZSH_HIGHLIGHT_STYLES[ftype-markdown];;
                 *.mkd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mkd];;
                 *.md)              style=$ZSH_HIGHLIGHT_STYLES[ftype-md];;
                 *.mf)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mf];;
                 *.mfasl)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mfasl];;
                 *.txt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-txt];;
                 *.rtf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rtf];;
                 *.doc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-doc];;
                 *.docx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-docx];;
                 *.docm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-docm];;
                 *.dot)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dot];;
                 *.dotm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-dotm];;
                 *.odt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odt];;
                 *.odm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odm];;
                 *.pages)           style=$ZSH_HIGHLIGHT_STYLES[ftype-pages];;
                 *.xla)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xla];;
                 *.xls)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xls];;
                 *.xlsx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xlsx];;
                 *.xlsm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xlsm];;
                 *.gnumeric)        style=$ZSH_HIGHLIGHT_STYLES[ftype-gnumeric];;
                 *.chrt)            style=$ZSH_HIGHLIGHT_STYLES[ftype-chrt];;
                 *.ppt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ppt];;
                 *.pptx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-pptx];;
                 *.ods)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ods];;
                 *.odp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odp];;
                 *.odb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odb];;
                 *.sql)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sql];;
                 *.sqlite)          style=$ZSH_HIGHLIGHT_STYLES[ftype-sqlite];;
                 *.db)              style=$ZSH_HIGHLIGHT_STYLES[ftype-db];;
                 *.mdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdf];;
                 *.ldf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ldf];;
                 *.mdb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdb];;
                 *.odb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odb];;
                 *.asm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-asm];;
                 *.asoundrc)        style=$ZSH_HIGHLIGHT_STYLES[ftype-asoundrc];;
                 *.awk)             style=$ZSH_HIGHLIGHT_STYLES[ftype-awk];;
                 *.coffee)          style=$ZSH_HIGHLIGHT_STYLES[ftype-coffee];;
                 *.cs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
                 *.css)             style=$ZSH_HIGHLIGHT_STYLES[ftype-css];;
                 *.scss)            style=$ZSH_HIGHLIGHT_STYLES[ftype-scss];;
                 *.sass)            style=$ZSH_HIGHLIGHT_STYLES[ftype-sass];;
                 *.csv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-csv];;
                 *.dir_colors)      style=$ZSH_HIGHLIGHT_STYLES[ftype-dir_colors];;
                 *.enc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-enc];;
                 *.ps)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ps];;
                 *.eps)             style=$ZSH_HIGHLIGHT_STYLES[ftype-eps];;
                 *.epsi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epsi];;
                 *.epsf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epsf];;
                 *.eps2)            style=$ZSH_HIGHLIGHT_STYLES[ftype-eps2];;
                 *.eps3)            style=$ZSH_HIGHLIGHT_STYLES[ftype-eps3];;
                 *.etx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-etx];;
                 *.ex)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ex];;
                 *.example)         style=$ZSH_HIGHLIGHT_STYLES[ftype-example];;
                 *.fehbg)           style=$ZSH_HIGHLIGHT_STYLES[ftype-fehbg];;
                 *.fonts)           style=$ZSH_HIGHLIGHT_STYLES[ftype-fonts];;
                 *.git)             style=$ZSH_HIGHLIGHT_STYLES[ftype-git];;
                 *.gitignore)       style=$ZSH_HIGHLIGHT_STYLES[ftype-gitignore];;
                 *.htm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-htm];;
                 *.html)            style=$ZSH_HIGHLIGHT_STYLES[ftype-html];;
                 *.jhtm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-jhtm];;
                 *.hgrc)            style=$ZSH_HIGHLIGHT_STYLES[ftype-hgrc];;
                 *.hgignore)        style=$ZSH_HIGHLIGHT_STYLES[ftype-hgignore];;
                 *.hs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-hs];;
                 *.htoprc)          style=$ZSH_HIGHLIGHT_STYLES[ftype-htoprc];;
                 *.info)            style=$ZSH_HIGHLIGHT_STYLES[ftype-info];;
                 *.java)            style=$ZSH_HIGHLIGHT_STYLES[ftype-java];;
                 *.js)              style=$ZSH_HIGHLIGHT_STYLES[ftype-js];;
                 *.jsm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jsm];;
                 *.jsp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jsp];;
                 *.lisp)            style=$ZSH_HIGHLIGHT_STYLES[ftype-lisp];;
                 *.lesshst)         style=$ZSH_HIGHLIGHT_STYLES[ftype-lesshst];;
                 *.log)             style=$ZSH_HIGHLIGHT_STYLES[ftype-log];;
                 *.lua)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lua];;
                 *.map)             style=$ZSH_HIGHLIGHT_STYLES[ftype-map];;
                 *.mf)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mf];;
                 *.mfasl)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mfasl];;
                 *.mi)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mi];;
                 *.msmtprc)         style=$ZSH_HIGHLIGHT_STYLES[ftype-msmtprc];;
                 *.mtx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mtx];;
                 *.muttrc)          style=$ZSH_HIGHLIGHT_STYLES[ftype-muttrc];;
                 *.nfo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nfo];;
                 *.netrc)           style=$ZSH_HIGHLIGHT_STYLES[ftype-netrc];;
                 *.offlineimaprc)   style=$ZSH_HIGHLIGHT_STYLES[ftype-offlineimaprc];;
                 *.pacnew)          style=$ZSH_HIGHLIGHT_STYLES[ftype-pacnew];;
                 *.patch)           style=$ZSH_HIGHLIGHT_STYLES[ftype-patch];;
                 *.diff)            style=$ZSH_HIGHLIGHT_STYLES[ftype-diff];;
                 *.pc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pc];;
                 *.pfa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfa];;
                 *.php)             style=$ZSH_HIGHLIGHT_STYLES[ftype-php];;
                 *.pid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pid];;
                 *.pl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pl];;
                 *.PL)              style=$ZSH_HIGHLIGHT_STYLES[ftype-PL];;
                 *.pm)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pm];;
                 *.pod)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pod];;
                 *.py)              style=$ZSH_HIGHLIGHT_STYLES[ftype-py];;
                 *.rc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rc];;
                 *.rb)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rb];;
                 *.ru)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ru];;
                 *.sed)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sed];;
                 *.signature)       style=$ZSH_HIGHLIGHT_STYLES[ftype-signature];;
                 *.sty)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sty];;
                 *.sug)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sug];;
                 *.t)               style=$ZSH_HIGHLIGHT_STYLES[ftype-t];;
                 *.tcl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tcl];;
                 *.tk)              style=$ZSH_HIGHLIGHT_STYLES[ftype-tk];;
                 *.tdy)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tdy];;
                 *.tfm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tfm];;
                 *.tfnt)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tfnt];;
                 *.theme)           style=$ZSH_HIGHLIGHT_STYLES[ftype-theme];;
                 *.viminfo)         style=$ZSH_HIGHLIGHT_STYLES[ftype-viminfo];;
                 *.vim)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vim];;
                 *.vimrc)           style=$ZSH_HIGHLIGHT_STYLES[ftype-vimrc];;
                 *.sh)              style=$ZSH_HIGHLIGHT_STYLES[ftype-sh];;
                 *.sh*)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sh*];;
                 *.bash)            style=$ZSH_HIGHLIGHT_STYLES[ftype-bash];;
                 *.dash)            style=$ZSH_HIGHLIGHT_STYLES[ftype-dash];;
                 *.bash_history)    style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_history];;
                 *.zsh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zsh];;
                 *.csh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-csh];;
                 *.ksh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ksh];;
                 *.tcsh)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tcsh];;
                 *.profile)         style=$ZSH_HIGHLIGHT_STYLES[ftype-profile];;
                 *.bash_profile)    style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_profile];;
                 *.bash_logout)     style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_logout];;
                 *.ttytterrc)       style=$ZSH_HIGHLIGHT_STYLES[ftype-ttytterrc];;
                 *.urlview)         style=$ZSH_HIGHLIGHT_STYLES[ftype-urlview];;
                 *.xinitrc)         style=$ZSH_HIGHLIGHT_STYLES[ftype-xinitrc];;
                 *.Xauthority)      style=$ZSH_HIGHLIGHT_STYLES[ftype-Xauthority];;
                 *.Xmodmap)         style=$ZSH_HIGHLIGHT_STYLES[ftype-Xmodmap];;
                 *.Xresources)      style=$ZSH_HIGHLIGHT_STYLES[ftype-Xresources];;
                 *.iso)             style=$ZSH_HIGHLIGHT_STYLES[ftype-iso];;
                 *.img)             style=$ZSH_HIGHLIGHT_STYLES[ftype-img];;
                 *.dmg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dmg];;
                 *.vcd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vcd];;
                 *.ISO)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ISO];;
                 *.nrg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nrg];;
                 *.mdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdf];;
                 *.allow)           style=$ZSH_HIGHLIGHT_STYLES[ftype-allow];;
                 *.deny)            style=$ZSH_HIGHLIGHT_STYLES[ftype-deny];;
                 *.tex)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tex];;
                 *.latex)           style=$ZSH_HIGHLIGHT_STYLES[ftype-latex];;
                 *.textile)         style=$ZSH_HIGHLIGHT_STYLES[ftype-textile];;
                 *.rdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rdf];;
                 *.owl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-owl];;
                 *.n3)              style=$ZSH_HIGHLIGHT_STYLES[ftype-n3];;
                 *.rc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rc];;
                 *.ttl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ttl];;
                 *.nt)              style=$ZSH_HIGHLIGHT_STYLES[ftype-nt];;
                 *.torrent)         style=$ZSH_HIGHLIGHT_STYLES[ftype-torrent];;
                 *.jidgo)           style=$ZSH_HIGHLIGHT_STYLES[ftype-jidgo];;
                 *.xml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xml];;
                 *.nfo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nfo];;
                 *.yml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yml];;
                 *.cfg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cfg];;
                 *.conf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-conf];;
                 *.ini)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ini];;
                 *.yml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yml];;
                 *.json)            style=$ZSH_HIGHLIGHT_STYLES[ftype-json];;
                 *.aux)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aux];;
                 *.md5)             style=$ZSH_HIGHLIGHT_STYLES[ftype-md5];;
                 *.sfv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sfv];;
                 *.sha1)            style=$ZSH_HIGHLIGHT_STYLES[ftype-sha1];;
                 *.st5)             style=$ZSH_HIGHLIGHT_STYLES[ftype-st5];;
                 *.ffp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ffp];;
                 *.par)             style=$ZSH_HIGHLIGHT_STYLES[ftype-par];;
                 *.flac)            style=$ZSH_HIGHLIGHT_STYLES[ftype-flac];;
                 *.alac)            style=$ZSH_HIGHLIGHT_STYLES[ftype-alac];;
                 *.wav)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wav];;
                 *.aac)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aac];;
                 *.au)              style=$ZSH_HIGHLIGHT_STYLES[ftype-au];;
                 *.mid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mid];;
                 *.midi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-midi];;
                 *.mka)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mka];;
                 *.mp2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp2];;
                 *.mp3)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp3];;
                 *.wma)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wma];;
                 *.mpc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mpc];;
                 *.ogg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogg];;
                 *.ra)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ra];;
                 *.m4a)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4a];;
                 *.m4b)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4b];;
                 *.m4r)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4r];;
                 *.axa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-axa];;
                 *.oga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-oga];;
                 *.spx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-spx];;
                 *.m3u8)            style=$ZSH_HIGHLIGHT_STYLES[ftype-m3u8];;
                 *.m3u)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m3u];;
                 *.pls)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pls];;
                 *.cue)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cue];;
                 *.xspf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xspf];;
                 *.S3M)             style=$ZSH_HIGHLIGHT_STYLES[ftype-S3M];;
                 *.dat)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dat];;
                 *.fcm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fcm];;
                 *.m4)              style=$ZSH_HIGHLIGHT_STYLES[ftype-m4];;
                 *.mod)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mod];;
                 *.oga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-oga];;
                 *.s3m)             style=$ZSH_HIGHLIGHT_STYLES[ftype-s3m];;
                 *.sid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sid];;
                 *.spl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-spl];;
                 *.wv)              style=$ZSH_HIGHLIGHT_STYLES[ftype-wv];;
                 *.wvc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wvc];;
                 *.mov)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mov];;
                 *.MOV)             style=$ZSH_HIGHLIGHT_STYLES[ftype-MOV];;
                 *.mpg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mpg];;
                 *.mpeg)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mpeg];;
                 *.m2v)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m2v];;
                 *.mkv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mkv];;
                 *.ogm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogm];;
                 *.mp4)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp4];;
                 *.VOB)             style=$ZSH_HIGHLIGHT_STYLES[ftype-VOB];;
                 *.m4v)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4v];;
                 *.mp4v)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mp4v];;
                 *.vob)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vob];;
                 *.qt)              style=$ZSH_HIGHLIGHT_STYLES[ftype-qt];;
                 *.nuv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nuv];;
                 *.wmv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wmv];;
                 *.asf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-asf];;
                 *.rm)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rm];;
                 *.rmvb)            style=$ZSH_HIGHLIGHT_STYLES[ftype-rmvb];;
                 *.flc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-flc];;
                 *.avi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-avi];;
                 *.AVI)             style=$ZSH_HIGHLIGHT_STYLES[ftype-AVI];;
                 *.fli)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fli];;
                 *.flv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-flv];;
                 *.gl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gl];;
                 *.m2ts)            style=$ZSH_HIGHLIGHT_STYLES[ftype-m2ts];;
                 *.divx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-divx];;
                 *.webm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-webm];;
                 *.ogv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogv];;
                 *.sample)          style=$ZSH_HIGHLIGHT_STYLES[ftype-sample];;
                 *.ts)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ts];;
                 *.axv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-axv];;
                 *.anx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-anx];;
                 *.ogx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogx];;
                 *.srt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-srt];;
                 *.ttf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ttf];;
                 *.otf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-otf];;
                 *.pcf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pcf];;
                 *.bdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bdf];;
                 *.fon)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fon];;
                 *.dfont)           style=$ZSH_HIGHLIGHT_STYLES[ftype-dfont];;
                 *.pfa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfa];;
                 *.pfb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfb];;
                 *.gsf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gsf];;
                 *.32x)             style=$ZSH_HIGHLIGHT_STYLES[ftype-32x];;
                 *.A64)             style=$ZSH_HIGHLIGHT_STYLES[ftype-A64];;
                 *.a00)             style=$ZSH_HIGHLIGHT_STYLES[ftype-a00];;
                 *.a52)             style=$ZSH_HIGHLIGHT_STYLES[ftype-a52];;
                 *.a64)             style=$ZSH_HIGHLIGHT_STYLES[ftype-a64];;
                 *.a78)             style=$ZSH_HIGHLIGHT_STYLES[ftype-a78];;
                 *.adf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-adf];;
                 *.atr)             style=$ZSH_HIGHLIGHT_STYLES[ftype-atr];;
                 *.cdi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cdi];;
                 *.fm2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fm2];;
                 *.gb)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gb];;
                 *.gba)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gba];;
                 *.gbc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gbc];;
                 *.gel)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gel];;
                 *.gg)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gg];;
                 *.ggl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ggl];;
                 *.j64)             style=$ZSH_HIGHLIGHT_STYLES[ftype-j64];;
                 *.nds)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nds];;
                 *.nes)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nes];;
                 *.rom)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rom];;
                 *.sav)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sav];;
                 *.sms)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sms];;
                 *.service)         style=$ZSH_HIGHLIGHT_STYLES[ftype-service];;
                 *.socket)          style=$ZSH_HIGHLIGHT_STYLES[ftype-socket];;
                 *.device)          style=$ZSH_HIGHLIGHT_STYLES[ftype-device];;
                 *.mount)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mount];;
                 *.automount)       style=$ZSH_HIGHLIGHT_STYLES[ftype-automount];;
                 *.swap)            style=$ZSH_HIGHLIGHT_STYLES[ftype-swap];;
                 *.target)          style=$ZSH_HIGHLIGHT_STYLES[ftype-target];;
                 *.path)            style=$ZSH_HIGHLIGHT_STYLES[ftype-path];;
                 *.timer)           style=$ZSH_HIGHLIGHT_STYLES[ftype-timer];;
                 *.snapshot)        style=$ZSH_HIGHLIGHT_STYLES[ftype-snapshot];;
                 *.c)               style=$ZSH_HIGHLIGHT_STYLES[ftype-c];;
                 *.C)               style=$ZSH_HIGHLIGHT_STYLES[ftype-C];;
                 *.cp)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cp];;
                 *.cc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cc];;
                 *.cpp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cpp];;
                 *.cxx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cxx];;
                 *.c++)             style=$ZSH_HIGHLIGHT_STYLES[ftype-c++];;
                 *.ii)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ii];;
                 *.cs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
                 *.rs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rs];;
                 *.rst)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rst];;
                 *.go)              style=$ZSH_HIGHLIGHT_STYLES[ftype-go];;
                 *.erl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-erl];;
                 *.ml)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ml];;
                 *.scala)           style=$ZSH_HIGHLIGHT_STYLES[ftype-scala];;
                 *.H)               style=$ZSH_HIGHLIGHT_STYLES[ftype-H];;
                 *.hpp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-hpp];;
                 *.hxx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-hxx];;
                 *.h++)             style=$ZSH_HIGHLIGHT_STYLES[ftype-h++];;
                 *.tcc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tcc];;
                 *.f)               style=$ZSH_HIGHLIGHT_STYLES[ftype-f];;
                 *.for)             style=$ZSH_HIGHLIGHT_STYLES[ftype-for];;
                 *.ftn)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ftn];;
                 *.s)               style=$ZSH_HIGHLIGHT_STYLES[ftype-s];;
                 *.S)               style=$ZSH_HIGHLIGHT_STYLES[ftype-S];;
                 *.sx)              style=$ZSH_HIGHLIGHT_STYLES[ftype-sx];;
                 *.am)              style=$ZSH_HIGHLIGHT_STYLES[ftype-am];;
                 *.in)              style=$ZSH_HIGHLIGHT_STYLES[ftype-in];;
                 *.old)             style=$ZSH_HIGHLIGHT_STYLES[ftype-old];;
                 *.pcap)            style=$ZSH_HIGHLIGHT_STYLES[ftype-pcap];;
                 *.cap)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cap];;
                 *.dmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dmp];;
                 *.dump)            style=$ZSH_HIGHLIGHT_STYLES[ftype-dump];;
                 *.am)              style=$ZSH_HIGHLIGHT_STYLES[ftype-am];;
                 *.in)              style=$ZSH_HIGHLIGHT_STYLES[ftype-in];;
                 *.old)             style=$ZSH_HIGHLIGHT_STYLES[ftype-old];;
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
