filename=$(basename $1 .png)
temppngname="${filename}-temp.png"
tempjpgname="${filename}-temp.jpg"
jpgname="${filename}.jpg"

echo "rename $1 to $temppngname"
cp $1 $temppngname
echo "highlight relevant parts in $temppngname"
magick $temppngname -stroke red -strokewidth 4 -fill none -draw "rectangle 440,1740 2100,1835" $temppngname
magick $temppngname -stroke red -strokewidth 4 -fill none -draw "rectangle 440,1910 2100,2005" $temppngname
echo "convert $temppngname to jpg format"
mogrify -format jpg $temppngname
echo "crop $tempjpgname and rename to $jpgname"
convert -crop 3360x1940+0+160 $tempjpgname $jpgname
echo "resize $tempjpgname"
mogrify -resize 40% $tempjpgname
echo "delete temporary files $temppngname and $tempjpgname"
rm $temppngname
rm $tempjpgname
