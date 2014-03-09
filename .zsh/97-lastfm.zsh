#------------------------------------------////
#               Shell-FM
#------------------------------------------////

alias cfg-shellfm='$EDITOR ~/.shell-fm/shell-fm.rc'     # config settings

sfm-artist() { link=$(echo "lastfm://artist/$@" | sed 's/ /+/g'); shell-fm $link ;}
sfm-user() { link=$(echo "lastfm://user/$@" | sed 's/ /+/g'); shell-fm $link ;}
sfm-globaltags() { link=$(echo "lastfm://globaltags/$@" | sed 's/ /+/g'); shell-fm $link ;}
sfm-tag() { link=$(echo "lastfm://tag/$@" | sed 's/ /+/g'); shell-fm $link ;}


# lastfm://user/$USER/loved
# lastfm://user/$USER/personal
# lastfm://usertags/$USER/$TAG
# lastfm://artist/$ARTIST/similarartists
# lastfm://globaltags/$TAG
# lastfm://user/$USER/recommended
# lastfm://user/$USER/playlist
# lastfm://tag/$TAG1*$TAG2*$TAG3
