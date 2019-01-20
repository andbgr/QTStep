#!/bin/bash
# Usage: make_theme.sh colors.NAME


colorscheme="$(echo "$1" | sed 's/colors.//')"
displayname="QTStep $colorscheme"
name="$(echo "$displayname" | tr -d ' ')"

rm -rv   ../$name
cp -av . ../$name
cd       ../$name

sed -i "s/^Name=.*/Name=$displayname/"  metadata.desktop
sed -i "s/^Theme-Id=.*/Theme-Id=$name/" metadata.desktop

declare -A colors_source
while read key val; do
	colors_source[$key]=$val
done < colors

declare -A colors_theme
while read key val; do
	colors_theme[$key]=$val
done < "colors.$colorscheme"

# If button/entry color is same as background, make it transparent so the background gradient is visible
if [ "${colors_theme[button]}" = "${colors_theme[bg]}" ]; then
	sed -i "/fill:${colors_source[button]}/s/fill-opacity:1/fill-opacity:0/" button.svg
fi

if [ "${colors_theme[view]}" = "${colors_theme[bg]}" ]; then
	sed -i "/fill:${colors_source[view]}/s/fill-opacity:1/fill-opacity:0/" entry.svg
fi

for file in *.svg main.qml; do
	for i in ${!colors_source[@]}; do
		sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $file
	done
	for i in ${!colors_source[@]}; do
		sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $file
	done
done

rsvg-convert preview.svg -o preview.png

rm -v colors* override.colors.* *.sh README preview.svg *.colors

cd -
