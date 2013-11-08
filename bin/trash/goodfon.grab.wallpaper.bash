#!/bin/bash
#author swex 
#date Sat Oct  3 06:25:41 MSD 2010
#wallpaper grubber and changer from goodfon.ru

DIR=~/Pictures/goodfon.ru 
TMPDIR=/tmp/goodfon.ru/tmp
DAYZ=2
mkdir $DIR
mkdir $TMPDIR
mkdir $DIR/tmp
cd $TMPDIR
wget http://www.goodfon.ru/goodfon.rss
touch goodfon.rss.old
diff -i -b -B -q goodfon.rss goodfon.rss.old
if < ! $? -eq 0 >; then
echo "**** File has changed*****" 
diff -i -b -B goodfon.rss goodfon.rss.old >> diff.rss
rm goodfon.rss.old
mv goodfon.rss goodfon.rss.old
else
echo "same"
fi

echo | cat diff.rss | grep "<link>http://www.goodfon.ru/wallpaper" |cut -c 45-49| while read -r line; do wget -nc -P /tmp/goodfon.ru "http://www.goodfon.ru/image/$line-original.jpg"
done
rm /tmp/goodfon.ru/tmp/diff.rss
cd $TMPDIR && cd ..
for f in *; do mv $f "`echo $f | cut -c 1-5`"; done
find . -maxdepth 1 -type f -exec mv "{}" $DIR/tmp \;         
cd $DIR/tmp
ls | sed 's/\(.*\)$/mv "&" "\1.jpg"/' | sh
find . -maxdepth 1 -type f -exec mv "{}" $DIR \;  
PIC=$(ls $DIR/*.jpg | shuf -n1)
find $DIR -atime +$DAYZ -exec rm {} \; # Удаляет обои старше n дней
gconftool -t string -s /desktop/gnome/background/picture_filename $PIC    
echo "done"
