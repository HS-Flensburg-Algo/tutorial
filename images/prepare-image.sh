# first argument is the image to be processed
# second argument ist the position of the highlight rectangle

print_usage() {
    printf "Usage: prepare-image.sh -c <filename> <rectangle1> <rectangle2>"
}

while getopts 'c' flag; do
    case "${flag}" in
        c) c_flag='true' ;;
        *) print_usage
            exit 1 ;;
    esac
done

shift $(($OPTIND - 1))

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
if [ "$c_flag" == 'true' ]; then
    echo "crop $tempjpgname"
    convert -crop 3360x1940+0+160 $tempjpgname $tempjpgname
fi
echo "resize $tempjpgname"
mogrify -resize 40% $tempjpgname
echo "rename $tempjpgname to $jpgname"
mv $tempjpgname $jpgname
echo "delete temporary file $temppngname"
rm $temppngname
