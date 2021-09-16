# Resize png files
mkdir backup
cp *.png backup
mogrify -resize 50% *.png
