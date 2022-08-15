# first argument is the image to be processed
# second argument ist the position of the highlight rectangle

print_usage() {
    printf "Usage: prepare-image.sh -c -r <resolution> <filename> <rectangle1> ... <rectanglen>"
}

# set default values for options
c_flag='true'
r_flag='40%'

while getopts 'cr:' flag; do
    case "${flag}" in
        c) c_flag='true' ;;
        r) r_flag="${OPTARG}" ;;
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
echo "resize $tempjpgname to $r_flag"
mogrify -resize "${r_flag}" $tempjpgname
echo "rename $tempjpgname to $jpgname"
mv $tempjpgname $jpgname
echo "delete temporary file $temppngname"
rm $temppngname
