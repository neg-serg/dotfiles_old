#!/usr/bin/env zsh
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2011 Guido van Steen
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
#  * Neither the name of the FIZSH nor the names of its contributors may be used to endorse or
#    promote products derived from this software without specific prior written permission.
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
#
# /etc/fizsh/fizshrc

# This fizshrc script intends to make zsh behave similar to fish when it comes to fish's
# syntax highlighting and fish's matlab-like history search. This script also emulates
# fish's prompt.
#
# When fizsh is run for the first time this script is copied to "$HOME/.fizsh/.zshrc".
# "$HOME/.fizsh/" is fizsh's "$ZDOTDIR" directory. This file is therefore sourced automatically
# when fizsh is run.
#
# The script was tested on Linux. It may need some modifications to work on
# other systems.

# Set the environment variables
#
0=fizsh # Trick to let people check wether fizsh is running, i.e. whether $0 is "fizsh"
SHELL=$(which fizsh)

# History
#
HISTFILE=$_fizsh_F_DOT_DIR/.fizsh_history
HISTSIZE=100000
SAVEHIST=100000

# Append to the history file instead of overwriting it and do it immediately
# when a command is executed.
#
setopt append_history
setopt inc_append_history

# Avoid duplicate entries in the history file
#
setopt hist_ignore_all_dups

# Reduce whitespace in history
#
setopt hist_reduce_blanks

# Reduce whitespace in history
#
setopt hist_ignore_space

# Allow interactive comments
#
setopt interactive_comments

# When entering a nonexistent command name automatically try to find a similar one.
#
setopt correct

# Get rid of beeps
#
setopt no_beep

# Set the prompt
#
setopt prompt_subst

# PS1='$(fizsh-prompt)'
# for some reason turning this into a sourcable function does not work
# see below as well
#
if [[ -r "$_fizsh_F_DOT_DIR""/fizsh-prompt.zsh" ]]; then
  PS1='$("$_fizsh_F_DOT_DIR"/fizsh-prompt.zsh)'
else
  PS1=''
fi

# Set the terminal title
#
[[ "xterm" =~ $TERM ]] && precmd () {print -Pn "\e]0;$0: %n @ %M: %~\a"}
[[ "screen" =~ $TERM ]] && precmd () {print -Pn "\e]0;$0: %n @ %M [screened]: %~\a"}

# Initiate completion system
#
autoload -U compinit
if [[ $_fizsh_F_COMPINIT_STARTED -ne 1 ]]; then
  compinit
  _fizsh_F_COMPINIT_STARTED=1
fi

zmodload zsh/complist

# Enable color support of ls
#
if [[ "$TERM" != "dumb" ]]; then
  if [[ -x $(which dircolors) ]]; then
    eval $(dircolors -b)
    alias 'ls=ls --color=auto'
  fi
fi

# Use colored output
#
autoload -U colors && colors
alias grep="grep --color=auto"

# Source zsh-syntax-highlighting.zsh, zsh-history-substring-search.zsh,
# fizsh-miscellaneous.zsh and fizshrc
#
source $_fizsh_F_DOT_DIR/zsh-syntax-highlighting.zsh
source $_fizsh_F_DOT_DIR/zsh-history-substring-search.zsh
source $_fizsh_F_DOT_DIR/fizsh-miscellaneous.zsh

# source $_fizsh_F_DOT_DIR/fizsh-prompt # would be nice as well. However,
# for some reason sourcing the prompt as a function from a file
# does not work properly: after a while the prompt get out of sync
# the same thing seems to happen when we use the precmd function
# to echo the prompt. A bug in ZSH!?
#
source $_fizsh_F_DOT_DIR/.fizshrc

# Give $ZDOTDIR its original value again so that we can call zsh
# without implicitly calling fizsh.
#
[[ $+_fizsh_F_OLD_ZDOTDIR -eq 1 ]] && export ZDOTDIR=$_fizsh_F_OLD_ZDOTDIR
# if _fizsh_F_OLD_ZDOTDIR was exported, we use it to restore the value of ZDOTDIR
[[ $+_fizsh_F_OLD_ZDOTDIR -eq 0 ]] && unset ZDOTDIR
# if _fizsh_F_OLD_ZDOTDIR was not exported, ZDOTDIR did not exist before fizsh was called. So we unset it
