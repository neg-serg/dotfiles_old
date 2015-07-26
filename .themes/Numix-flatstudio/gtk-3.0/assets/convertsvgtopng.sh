
mkdir ./PNG
for i in ./*.svg
do
inkscape -z -e ./PNG/"${i/.svg/}".png -d 90 "$i"
done
#
for i in ./*.svg
do
inkscape -z -e ./PNG/"${i/.svg/}"@2.png -d 180 "$i"
done
