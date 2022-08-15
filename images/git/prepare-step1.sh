filename=$(basename $1 .png)
temppngname="${filename}-temp.png"
tempjpgname="${filename}-temp.jpg"
jpgname="${filename}.jpg"

echo "highlight relevant part in $1 and rename to $temppngname"
magick $1 -stroke red -strokewidth 4 -fill none -draw "rectangle 2146,645 2350,740" $temppngname
magick $temppngname -stroke red -strokewidth 4 -fill none -draw "rectangle 1490,970 2325,1060" $temppngname
echo "convert $temppngname to jpg format"
mogrify -format jpg $temppngname
echo "crop $tempjpgname and rename to $jpgname"
convert -crop 3360x1940+0+160 $tempjpgname $jpgname
echo "resize $tempjpgname"
mogrify -resize 40% $tempjpgname
echo "delete temporary files $temppngname and $tempjpgname"
rm $temppngname
rm $tempjpgname
