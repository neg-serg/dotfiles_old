#!/bin/sh

echo '${XDG_DATA_HOME}='"${XDG_DATA_HOME}"

echo "You have 5 secs to break general wine-fileassoc stuff" && sleep 5s && {

    rm -vf ${XDG_DATA_HOME}/applications/wine-extension*.desktop
    rm -vf ${XDG_DATA_HOME}/icons/hicolor/*/*/application-x-wine-extension*

} && {

    rm -vf ${XDG_DATA_HOME}/applications/mimeinfo.cache
    rm -vf ${XDG_DATA_HOME}/mime/packages/x-wine*
    rm -vf ${XDG_DATA_HOME}/mime/application/x-wine-extension*

} && {

    update-desktop-database ${XDG_DATA_HOME}/applications
    update-mime-database ${XDG_DATA_HOME}/mime/

}

echo "You have 5 secs to break ${XDG_DATA_HOME} grep wine rm" && sleep 5s && {
    find ${XDG_DATA_HOME} -name '*wine*' -type f -print0 | xargs -0 rm -fv
}
