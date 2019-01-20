#!/bin/bash
# Usage: make_tiles.sh colors.NAME


colorscheme="$(echo "$1" | sed 's/colors.//')"
displayname="QTStep $colorscheme"
name="$(echo "$displayname" | tr -d ' ')"
		
rm -rv   ../$name
cp -av . ../$name
cd       ../$name

rm -v *.gradient.svg

for image in *.svg *.qss; do
	declare -A colors_source
	while read key val; do
		colors_source[$key]=$val
	done < colors
	
	declare -A colors_theme
	while read key val; do
		colors_theme[$key]=$val
	done < "colors.$colorscheme"

	for i in ${!colors_source[@]}; do
		sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $image
	done
	for i in ${!colors_source[@]}; do
		sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $image
	done
done

rsvg-convert preview.svg -o preview.png

rm -v colors* override.colors.* *.sh README preview.svg

cd -