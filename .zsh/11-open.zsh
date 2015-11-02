#! /bin/zsh
open(){
    local editor="v"
    local web_browser="firefox"
    local vid_pl="mpv"
    local audio_player="mpv"
    local doc_reader="zathura"
    local image_viewer="~/bin/scripts/sxiv_browser.sh"
    
    if [[ -d $1 ]]; then
        urxvt --chdir "$1"
    elif [[ -e $1 ]]; then
        mime_type=$(file -L -b --mime-type "$1")
            # the order is important, e.g. foo/bar must appear before foo/*
            case ${mime_type} in
                inode/x-empty)                        ${editor} "$1"          ;;
                video/*|application/vnd.rn-realmedia) ${vid_pl} "$1"    ;;
                audio/*)                              ${audio_player} "$1"    ;;
                image/vnd.djvu)                       [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
                image/svg+xml\
                    |application/x-shockwave-flash)   ${web_browser} "$1"     ;;
                image/x-xcf) gimp                     "$1"                    ;;
                image/*)                              ${image_viewer} "$1"    ;;
                epplication/postscript)               [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
                application/pdf)                      [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
                application/epub)                     [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
                application/x-bittorrent)             ta "$1"                 ;;
                application/vnd.ms-opentype\
                    |application/x-font-ttf\
                    |application/vnd.font-fontforge-sfd) fontforge "$1"       ;;
                text/html) $web_browser "$1"                                  ;;
                text/troff) man -l "$1"                                       ;;
                         *) case "$1" in
                         *.nzb) xchm "$1" 2>/dev/null                                            ;;
                         *.nfo) nzbget -A "$1" 2>/dev/null                                       ;;
                         *.pcf|*.bdf|*.pfb) ${editor} "$1"                                       ;;
                         *.svg) display "$1"                                                     ;;
                         *.pps|*.PPS|*.ppt|*.PPT) ${web_browser} "$1"                            ;;
                         *.rtf|*.doc)  libreoffice "$1" 2>/dev/null                              ;;
                         *.xls) catdoc -w -s cp1251 "$1"                                         ;;
                         *.xpm) xls2csv -s cp1251 "$1"                                           ;;
                         *.mp3|*.m3u|*.ogg) ${audio_player} "$1"                                 ;;
                         *.mp4|*.avi|*.mpg|*.mpeg|*.mkv|*.ogv|*.f4v|*.m2ts) ${vid_pl} "$1" ;;
                         *) mime_encoding=$(file -L -b --mime-encoding "$1")
                            case ${mime_encoding} in
                                *) ${editor} "$1"                                                ;;
                            esac
                            ;;
                    esac
                    ;;
            esac
    else
    case "$1" in
                *://*) ${web_browser} "$1" ;;
                *) echo "file not found: '$1'" >&2 ;;
            esac
    fi
}
