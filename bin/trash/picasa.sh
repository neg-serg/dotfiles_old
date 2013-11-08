#! /bin/bash
#
# Description: Upload image to Picasaweb
# Author: Victor Ananjevsky <ananasik@gmail.com>, 2011
#
 
AUTHFILE=${XDG_CACHE_HOME:-$HOME/.cache}/google.auth
YAD="yad --window-icon=web-browser --name=${0##*/}"
 
# create stylesheet
cat > /tmp/google.xsl <<EOF
<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:atom="http://www.w3.org/2005/Atom"
                              xmlns:gphoto='http://schemas.google.com/photos/2007'>
<xsl:output method="text" omit-xml-declaration="yes" encoding="utf-8"/>
<xsl:template match="//atom:feed">
  GOOGLE_USER="<xsl:value-of select="atom:title"/>"
  ALBUMS=(<xsl:for-each select="//atom:entry">
            "<xsl:value-of select="gphoto:id"/>"
            "<xsl:value-of select="atom:title"/>"
          </xsl:for-each>)
</xsl:template>
</xsl:stylesheet>
EOF
 
# login
if [[ -e $AUTHFILE ]]; then
    source $AUTHFILE
else
    eval $($YAD --image=gtk-dialog-authentication --title="Picasa login" \
  --text="<b>Login to google account</b>" --form \
  --field="Login:" --field="Password::H" | awk -F'|' '{printf "EMAIL=%s\nPASS=%s\n", $1, $2}')
    [[ -z $EMAIL || -z $PASS ]] && exit 1
 
    eval $(curl https://www.google.com/accounts/ClientLogin -sS --insecure \
  --data-urlencode Email="$EMAIL" --data-urlencode Passwd="$PASS" \
  -d accountType=GOOGLE -d source="$0" -d service=lh2)
 
    if [[ -z $Auth ]]; then
  $YAD --title="Login error" --image=dialog-error --button=gtk-close --text="Login failed: $Error"
  exit 1
    fi
 
    mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}
    echo "Auth=$Auth" > $AUTHFILE
fi
 
# get albums list
eval $(curl --silent --header "Authorization: GoogleLogin auth=$Auth" \
    "http://picasaweb.google.com/data/feed/api/user/default" | xsltproc /tmp/google.xsl -)
for ((i=1; i<${#ALBUMS[@]}; i+=2)); do
    alb="$alb!${ALBUMS[$i]}"
done
 
# select album and file
eval $($YAD --title="Upload to picasa" --text="Upload to Picasa" \
    --form --field="Album::CB" --field="Title:" --field="File::FL" \
    "$alb" "" "$1" | awk -F'|' '{printf "ALBUM=\"%s\"\nTITLE=\"%s\"\nFILENAME=\"%s\"\n", $1, $2, $3}')
[[ -z $ALBUM || -z $FILENAME ]] && exit 1
 
for ((i=1; i<${#ALBUMS[@]}; i+=2)); do
    if [[ $ALBUM == ${ALBUMS[$i]} ]]; then
  URI=http://picasaweb.google.com/data/feed/api/user/$GOOGLE_USER/albumid/${ALBUMS[(($i-1))]}
  break
    fi
done
TYPE=$(file -bi $FILENAME | sed "s/;.*$//")
 
# upload file
curl --request POST --data-binary "@$FILENAME" --header "Slug: $TITLE" \
    --header "Content-Type: $TYPE" --header "Authorization: GoogleLogin auth=$Auth" \
    "$URI" 2>&1 > /tmp/res | $YAD --button=gtk-cancel:1 --title="Upload to Picasa" \
    --text="Upload '$FILENAME' to '$ALBUM'" --progress --auto-close --auto-kill
 
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    $YAD --title="Upload error" --image=dialog-error --button=gtk-close --text="Upload failed: $(< /tmp/res)"
fi
 
# cleanup
rm -f /tmp/res /tmp/google.xsl
 
exit 0
