# first argument is the image to be processed
# second argument ist the position of the highlight rectangle

filename=$(basename $1 .png)
temppngname="${filename}-temp.png"
tempjpgname="${filename}-temp.jpg"
jpgname="${filename}.jpg"

echo "duplicate $1 to $temppngname"
cp $1 $temppngname
for i in "${@:2}"; do
    echo "highlight rectangle \"$i\" in $temppngname"
    magick $temppngname -stroke red -strokewidth 4 -fill none -draw "rectangle $i" $temppngname
done
echo "convert $temppngname to jpg format"
mogrify -format jpg $temppngname
echo "crop $tempjpgname"
convert -crop 3360x1940+0+160 $tempjpgname $tempjpgname
echo "resize $tempjpgname"
mogrify -resize 40% $tempjpgname
echo "rename $tempjpgname to $jpgname"
mv $tempjpgname $jpgname
echo "delete temporary file $temppngname"
rm $temppngname
