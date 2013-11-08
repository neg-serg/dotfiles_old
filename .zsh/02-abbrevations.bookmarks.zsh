#!/usr/bin/zsh

typeset -Ag abbreviations
abbreviations=(
  "pinc"  "/usr/{lib,share}/perl5/{core,site,vendor}_perl/"
  "jj"     "!$"
  "Icl"    "|ls_color"
  "jk"     "!-2$"
  "Im"     "| more"
  "Ia"     "| awk"
  "Ig"     "| grep"
  "Ieg"    "| egrep"
  "Iag"    "| agrep"
  "Igr"    "| groff -s -p -t -e -Tlatin1 -mandoc"
  "Ip"     "| $PAGER"
  "Ih"     "| head"
  "Ik"     "| keep"
  "It"     "| tail"
  "Is"     "| sort"
  "Iv"     "| ${VISUAL:-${EDITOR}}"
  "Iw"     "| wc"
  "Ix"     "| xargs"
  "findf" 'find . -maxdepth 1 -type f -printf "%P\n" | \
    perl -e "@_=<>; print sort grep {! /^[.]/ } @_; print sort grep { /^[.]/ } @_" | \
    ls_color'
  'Glob'  '{*,*/*,*/*/*,*/*/*/*,*/*/*/*/*,*/*/*/*/*/*}'
  'GlobV' '{*,*/*,*/*/*,*/*/*/*,*/*/*/*/*,*/*/*/*/*/*}.(mkv|mp4|wmv|mpe?g|avi|mov)'
  'GlobM' '{*,*/*,*/*/*,*/*/*/*,*/*/*/*/*,*/*/*/*/*/*}.(flac|mp3)'
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

# vim: set ts=2 expandtab sw=2:

