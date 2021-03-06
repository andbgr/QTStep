#!/bin/bash
# Usage: make_theme.sh colors.NAME


colorscheme="$(echo "$1" | sed 's/colors.//')"
displayname="QTStep $colorscheme"
name="$(echo "$displayname" | tr -d ' ')"
		
rm -rv   ../$name
cp -av . ../$name
cd       ../$name
mv -v QTStep.source.kvconfig "$name".kvconfig
mv -v QTStep.source.svg      "$name".svg

declare -A colors_source
while read key val; do
	colors_source[$key]=$val
done < colors

declare -A colors_theme
while read key val; do
	colors_theme[$key]=$val
done < "colors.$colorscheme"

for file in *.svg *.kvconfig; do
	for i in ${!colors_source[@]}; do
		sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $file
	done
	for i in ${!colors_source[@]}; do
		sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $file
	done
done

# rsvg-convert preview.svg -o preview.png

rm -v colors* override.colors.* *.sh README preview.svg
cp -av "$(grep -lr '^Name='"$colorscheme"'$' $XDG_DATA_HOME/color-schemes | head -1)" .

cd -
