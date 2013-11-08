#! /bin/zsh
open(){
    local editor="vim"
    local web_browser="firefox"
    local video_player="mplayer"
    local document_reader="zathura"
    local image_viewer="mosaic"
    local audio_player="mplayer"

    if [ -d "$1" ]; then
        ncd "$1"
        elif [ -e "$1" ]; then
        mime_type=$(file -L -b --mime-type "$1")
            # the order is important, e.g. foo/bar must appear before foo/*
            case $mime_type in
                inode/x-empty) $editor "$1" ;;
                video/*|application/vnd.rn-realmedia) $video_player "$1" ;;
                audio/*) $audio_player "$1" ;;
                image/vnd.djvu) $document_reader "$1" ;;
                image/svg+xml|application/x-shockwave-flash) $web_browser "$1" ;;
                image/x-xcf) gimp "$1" ;;
                image/*) $image_viewer "$1" ;;
                # image/x-canon-cr2) dcraw -T -w "$1" ;;
                # application/x-lha) lha x "$1" ;;
                application/postscript) $document_reader "$1" ;;
                application/pdf) $document_reader "$1" ;;
                application/zip) unzip -d "${@%.*}" "$1" ;;
                application/x-tar) tar xvf "$1" ;;
                application/x-rar) unrar -ad x "$1" ;;
                application/x-bittorrent) transmission-remote-cli "$1" ;;
                application/vnd.ms-opentype|application/x-font-ttf|application/vnd.font-fontforge-sfd) fontforge "$1" ;;
                text/html) $web_browser "$1" ;;
                text/troff) man -l "$1" ;;
                *) case "$1" in *.tar.gz|*.tgz)
                            tar xvzf "$1" ;; *.tar.xz)
                            tar xvJf "$1" ;; *.tar.bz2)
                            tar xvjf "$1" ;; *.bz2)
                            bunzip2 "$1" ;; *.tar)
                            tar xvf "$1" ;; *.gz)
                            gunzip "$1" ;; *.ace)
                            unace x "$1" ;; *.7z)
                            7z x "$1" ;; *.chm)
                            xchm "$1" ;; *.nzb)
                            nzbget -A "$1" ;; *.nfo)
                            $editor "$1" ;; *.pcf|*.bdf|*.pfb)
                            fontforge "$1" ;; *.svg)
                            $web_browser "$1" ;; *.pps|*.PPS|*.ppt|*.PPT)
                            ppsei "$1" ;; *.abw)
                            abiword "$1" ;; *.rtf|*.doc)
                            catdoc -w -s cp1252 "$1" ;; *.xls)
                            xls2csv -s cp1252 "$1" ;; *.xpm)
                            $image_viewer "$1" ;; *.mp3|*.m3u|*.ogg)
                            $audio_player "$1" ;; *.mp4|*.avi|*.mpg|*.mpeg|*.mkv|*.ogv|*.f4v|*.m2ts)
                            $video_player "$1" ;; *.webarchive)
                            tmp_xml=$(mktemp) tmp_html=$(mktemp)
                            plutil -i "$1" -o "$tmp_xml"
                            webarchive_decodemain "$tmp_xml" > "$tmp_html"
                            $web_browser "$tmp_html"
                            rm "$tmp_xml"
                            ;;
                        *.blend) blender "$1" ;;
                        *.emulecollection) amule-emc "$1" ;;
                        *) mime_encoding=$(file -L -b --mime-encoding "$1")
                            case $mime_encoding in
                                *binary) xxd -l 128 "$1" ;;
                                *) $editor "$1" ;;
                            esac
                            ;;
                    esac
                    ;;
            esac
    else
    case "$1" in
                *://*) $web_browser "$1" ;;
                *:*) handle_uri "$1" ;;
                *@*.*) mutt "$1" ;;
                *) echo "file not found: '$1'" >&2 ;;
            esac
    fi
}
