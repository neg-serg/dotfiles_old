#!/bin/bash
backColor=2e525a
frontColor=4A838F
paperColor=ffffff
glyphColorOriginal=304050
glyphColorNew=1a2e32

xsltproc --stringparam backColor $backColor --stringparam frontColor $frontColor --stringparam paperColor $paperColor change_folder_colors.xslt $1 > tmp.svg && mv tmp.svg $1
sed -i "s/#$glyphColorOriginal;/#$glyphColorNew;/g" $1
