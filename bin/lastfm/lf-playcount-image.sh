#ght 2010 (c) Yu-Jie Lin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# The communication functions with MPD is copied from MPDisp
#
# Creation Date: 2010-08-29T06:28:16+0800


##########
# Settings

CFG_DIR=~/.lf-bash
HOST=localhost
PORT=6600
CACHE_FILE=/tmp/lf-playcount-image

#################
# End of Settings

MPD_TCP=/dev/tcp/$HOST/$PORT
_ret=
song_title=
song_artist=
song_album=
song_time=
current_time=

TRACKINFO_API="http://ws.audioscrobbler.com/2.0/?method=track.getinfo"

###########
# Functions

function request() {
        # $1 command
                exec 5<> $MPD_TCP 2>/dev/null
                        [[ $? -gt 0 ]] && return 1
                                echo $1 >&5
                                        echo "close" >&5
                                                tmp=$(cat <&5)
                                                        exec 5>&-
                                                                # TODO check OK before return
                                                                        _ret=$(head -n -1 <<< "$tmp" | tail -n +2)
                                                                                return 0
                                                                                        }
                                                                                        
                                                                                        function extract_field() {
                                                                                                # $1 field_name
                                                                                                        # $2 search body
                                                                                                                _ret=$(grep "^$1: " <<< "$2" 2>/dev/null | sed "s/$1: //")
                                                                                                                        }
                                                                                                                        
                                                                                                                        function parse_song_info() {
                                                                                                                                request currentsong
                                                                                                                                        [[ $? -gt 0 ]] && return 1
                                                                                                                                                _tmp=$_ret
                                                                                                                                                        extract_field "Title" "$_tmp"
                                                                                                                                                                song_title=$_ret
                                                                                                                                                                        extract_field "Artist" "$_tmp"
                                                                                                                                                                                song_artist=$_ret
                                                                                                                                                                                        extract_field "Album" "$_tmp"
                                                                                                                                                                                                song_album=$_ret
                                                                                                                                                                                                        extract_field "Time" "$_tmp"
                                                                                                                                                                                                                song_time=$_ret
                                                                                                                                                                                                                        fmt_time $song_time
                                                                                                                                                                                                                                song_time_f=$_ret
                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                        function parse_time() {
                                                                                                                                                                                                                                                request "status"
                                                                                                                                                                                                                                                        extract_field "time" "$_ret"
                                                                                                                                                                                                                                                                current_time=$(cut -f 1 -d : <<< "$_ret")
                                                                                                                                                                                                                                                                #       fmt_time $current_time
                                                                                                                                                                                                                                                                #       current_time_f=$_ret
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                        function urlencode() {
                                                                                                                                                                                                                                                                                # http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script
                                                                                                                                                                                                                                                                                        _ret="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1")"
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                extract_XML_value () {
                                                                                                                                                                                                                                                                                                            # $1 entity name
                                                                                                                                                                                                                                                                                                                    # $2 string to find
                                                                                                                                                                                                                                                                                                                            echo -n "$2" | egrep -o "<$1>[^<]+" | sed -e "s/<$1>//"
                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                    function get_track_info() {
                                                                                                                                                                                                                                                                                                                                            URL="$TRACKINFO_API"
                                                                                                                                                                                                                                                                                                                                                    urlencode "$song_title"
                                                                                                                                                                                                                                                                                                                                                            [[ "$_ret" != "" ]] && URL="$URL&track=$_ret"
                                                                                                                                                                                                                                                                                                                                                                    urlencode "$song_artist"
                                                                                                                                                                                                                                                                                                                                                                            [[ "$_ret" != "" ]] && URL="$URL&artist=$_ret"
                                                                                                                                                                                                                                                                                                                                                                                    _ret=$(wget "$URL" -O -)
                                                                                                                                                                                                                                                                                                                                                                                            # Parsing
                                                                                                                                                                                                                                                                                                                                                                                                    userplaycount=$(extract_XML_value "userplaycount" "$_ret")
                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$userplaycount" == "" ]] && userplaycount=0
                                                                                                                                                                                                                                                                                                                                                                                                                    userloved=$(extract_XML_value "userloved" "$_ret")
                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$userloved" == "" ]] && userloved=0
                                                                                                                                                                                                                                                                                                                                                                                                                                    image_small=$(extract_XML_value 'image size="small"' "$_ret")
                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$image_small" == "" ]] && image_small="http://cdn.last.fm/flatness/catalogue/album/jewelcase_small.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                    image_medium=$(extract_XML_value 'image size="medium"' "$_ret")
                                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$image_medium" == "" ]] && image_medium="http://cdn.last.fm/flatness/catalogue/album/jewelcase_medium.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                    image_large=$(extract_XML_value 'image size="large"' "$_ret")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$image_large" == "" ]] && image_large="http://cdn.last.fm/flatness/catalogue/album/jewelcase_large.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    image_extralarge=$(extract_XML_value 'image size="extralarge"' "$_ret" 2> /dev/null)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            echo "$song_hash $userplaycount $image_small $image_medium $image_large $image_extralarge $userloved" > "$CACHE_FILE"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # Wget image, Conky seems to be blocked?
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            mkdir -p /tmp/lf-images
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    f_image_small="$(echo "$image_small" | tr -t \/ -)"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            f_image_medium="$(echo "$image_medium" | tr -t \/ -)"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    f_image_large="$(echo "$image_large" | tr -t \/ -)"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            f_image_extralarge="$(echo "$image_extralarge" | tr -t \/ -)"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    [[ ! -f "/tmp/lf-images/$f_image_small" ]] && wget "$image_small" -O "/tmp/lf-images/$f_image_small"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ ! -f "/tmp/lf-images/$f_image_medium" ]] && wget "$image_medium" -O "/tmp/lf-images/$f_image_medium"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    [[ ! -f "/tmp/lf-images/$f_image_large" ]] && wget "$image_large" -O "/tmp/lf-images/$f_image_large"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$image_extralarge" != "" ]] && [[ ! -f "/tmp/lf-images/$f_image_extralarge" ]] && wget "$image_extralarge" -O "/tmp/lf-images/$f_image_extralarge"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ln -sf "/tmp/lf-images/$f_image_small" "/tmp/lf-images/small.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ln -sf "/tmp/lf-images/$f_image_medium" "/tmp/lf-images/medium.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ln -sf "/tmp/lf-images/$f_image_large" "/tmp/lf-images/large.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            [[ "$image_extralarge" != "" ]] && ln -sf "/tmp/lf-images/$f_image_extralarge" "/tmp/lf-images/extralarge.png" || rm "/tmp/lf-images/extralarge.png"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ######
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # Main
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # CHECK API KEY & USERNAME
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    source "$CFG_DIR/config" &> /dev/null
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if [[ "$APIKEY" == "" ]]; then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                echo "Please add the following content to $CFG_DIR/config:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                APIKEY=YOUR_LASTFM_APIKEY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        exit 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if [[ "$USERNAME" == "" ]]; then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                echo "Please add the following content to $CFG_DIR/config:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                USERNAME=YOUR_LASTFM_USERNAME
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        exit 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    TRACKINFO_API="$TRACKINFO_API&api_key=$APIKEY&username=$USERNAME"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # CHECK MPD
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    parse_song_info
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if (( $? != 0 )); then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                echo "Something went wrong with MPD!"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        exit 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    parse_time
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    song_hash="$(echo -n "${song_title}|${song_artist}" | md5sum | head -c 32)"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if [[ ! -f "$CACHE_FILE" ]]; then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                get_track_info
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        # Check the cache file
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                cache="$(cat "$CACHE_FILE")"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        _song_hash="$(echo -n "$cache" | cut -f 1 -d \ )"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                if [[ "$_song_hash" != "$song_hash" ]]; then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    get_track_info
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        fi
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        #!/bin/bash
# copyright 2010 (c) Yu-Jie Lin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# The communication functions with MPD is copied from MPDisp
#
# Creation Date: 2010-08-29T06:28:16+0800


##########
# Settings

CFG_DIR=~/.lf-bash
HOST=localhost
PORT=6600
CACHE_FILE=/tmp/lf-playcount-image

#################
# End of Settings

MPD_TCP=/dev/tcp/$HOST/$PORT
_ret=
song_title=
song_artist=
song_album=
song_time=
current_time=

TRACKINFO_API="http://ws.audioscrobbler.com/2.0/?method=track.getinfo"

###########
# Functions

function request() {
        # $1 command
        exec 5<> $MPD_TCP 2>/dev/null
        [[ $? -gt 0 ]] && return 1
        echo $1 >&5
        echo "close" >&5
        tmp=$(cat <&5)
        exec 5>&-
        # TODO check OK before return
        _ret=$(head -n -1 <<< "$tmp" | tail -n +2)
        return 0
        }

function extract_field() {
        # $1 field_name
        # $2 search body
        _ret=$(grep "^$1: " <<< "$2" 2>/dev/null | sed "s/$1: //")
        }

function parse_song_info() {
        request currentsong
        [[ $? -gt 0 ]] && return 1
        _tmp=$_ret
        extract_field "Title" "$_tmp"
        song_title=$_ret
        extract_field "Artist" "$_tmp"
        song_artist=$_ret
        extract_field "Album" "$_tmp"
        song_album=$_ret
        extract_field "Time" "$_tmp"
        song_time=$_ret
        fmt_time $song_time
        song_time_f=$_ret
        }

function parse_time() {
        request "status"
        extract_field "time" "$_ret"
        current_time=$(cut -f 1 -d : <<< "$_ret")
#       fmt_time $current_time
#       current_time_f=$_ret
        }

function urlencode() {
        # http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script
        _ret="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1")"
        }

extract_XML_value () {
        # $1 entity name
        # $2 string to find
        echo -n "$2" | egrep -o "<$1>[^<]+" | sed -e "s/<$1>//"
        }

function get_track_info() {
        URL="$TRACKINFO_API"
        urlencode "$song_title"
        [[ "$_ret" != "" ]] && URL="$URL&track=$_ret"
        urlencode "$song_artist"
        [[ "$_ret" != "" ]] && URL="$URL&artist=$_ret"
        _ret=$(wget "$URL" -O -)
        # Parsing
        userplaycount=$(extract_XML_value "userplaycount" "$_ret")
        [[ "$userplaycount" == "" ]] && userplaycount=0
        userloved=$(extract_XML_value "userloved" "$_ret")
        [[ "$userloved" == "" ]] && userloved=0
        image_small=$(extract_XML_value 'image size="small"' "$_ret")
        [[ "$image_small" == "" ]] && image_small="http://cdn.last.fm/flatness/catalogue/album/jewelcase_small.png"
        image_medium=$(extract_XML_value 'image size="medium"' "$_ret")
        [[ "$image_medium" == "" ]] && image_medium="http://cdn.last.fm/flatness/catalogue/album/jewelcase_medium.png"
        image_large=$(extract_XML_value 'image size="large"' "$_ret")
        [[ "$image_large" == "" ]] && image_large="http://cdn.last.fm/flatness/catalogue/album/jewelcase_large.png"
        image_extralarge=$(extract_XML_value 'image size="extralarge"' "$_ret" 2> /dev/null)
        echo "$song_hash $userplaycount $image_small $image_medium $image_large $image_extralarge $userloved" > "$CACHE_FILE"
        # Wget image, Conky seems to be blocked?
        mkdir -p /tmp/lf-images
        f_image_small="$(echo "$image_small" | tr -t \/ -)"
        f_image_medium="$(echo "$image_medium" | tr -t \/ -)"
        f_image_large="$(echo "$image_large" | tr -t \/ -)"
        f_image_extralarge="$(echo "$image_extralarge" | tr -t \/ -)"
        [[ ! -f "/tmp/lf-images/$f_image_small" ]] && wget "$image_small" -O "/tmp/lf-images/$f_image_small"
        [[ ! -f "/tmp/lf-images/$f_image_medium" ]] && wget "$image_medium" -O "/tmp/lf-images/$f_image_medium"
        [[ ! -f "/tmp/lf-images/$f_image_large" ]] && wget "$image_large" -O "/tmp/lf-images/$f_image_large"
        [[ "$image_extralarge" != "" ]] && [[ ! -f "/tmp/lf-images/$f_image_extralarge" ]] && wget "$image_extralarge" -O "/tmp/lf-images/$f_image_extralarge"
        ln -sf "/tmp/lf-images/$f_image_small" "/tmp/lf-images/small.png"
        ln -sf "/tmp/lf-images/$f_image_medium" "/tmp/lf-images/medium.png"
        ln -sf "/tmp/lf-images/$f_image_large" "/tmp/lf-images/large.png"
        [[ "$image_extralarge" != "" ]] && ln -sf "/tmp/lf-images/$f_image_extralarge" "/tmp/lf-images/extralarge.png" || rm "/tmp/lf-images/extralarge.png"
        }

######
# Main

# CHECK API KEY & USERNAME

source "$CFG_DIR/config" &> /dev/null

if [[ "$APIKEY" == "" ]]; then
        echo "Please add the following content to $CFG_DIR/config:

APIKEY=YOUR_LASTFM_APIKEY
"
        exit 1
fi

if [[ "$USERNAME" == "" ]]; then
        echo "Please add the following content to $CFG_DIR/config:

USERNAME=YOUR_LASTFM_USERNAME
"
        exit 1
fi

TRACKINFO_API="$TRACKINFO_API&api_key=$APIKEY&username=$USERNAME"

# CHECK MPD

parse_song_info
if (( $? != 0 )); then
        echo "Something went wrong with MPD!"
        exit 1
fi

parse_time
song_hash="$(echo -n "${song_title}|${song_artist}" | md5sum | head -c 32)"

if [[ ! -f "$CACHE_FILE" ]]; then
        get_track_info
else
        # Check the cache file
        cache="$(cat "$CACHE_FILE")"
        _song_hash="$(echo -n "$cache" | cut -f 1 -d \ )"
        if [[ "$_song_hash" != "$song_hash" ]]; then
                get_track_info
        fi
fi

