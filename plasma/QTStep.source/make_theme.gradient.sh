#!/bin/bash
# Usage: make_theme.sh colors.NAME


colorscheme="$(echo "$1" | sed 's/colors.//')"
displayname="QTStep Gradient $colorscheme"
name="$(echo "$displayname" | tr -d ' ')"

rm -rv   ../$name
cp -av . ../$name
cd       ../$name

for i in widgets/*.gradient.svg; do
	mv -v $i $(echo $i | sed 's/\.gradient\.svg/.svg/')
done
rm -v widgets/*.classic.svg

sed -i "s/^Name=.*/Name=$displayname/"                            metadata.desktop
sed -i "s/^X-KDE-PluginInfo-Name=.*/X-KDE-PluginInfo-Name=$name/" metadata.desktop

declare -A colors_source
while read key val; do
	colors_source[$key]=$val
done < colors

declare -A colors_theme
while read key val; do
	colors_theme[$key]=$val
done < "colors.$colorscheme"

for file in widgets/*.svg; do
	for i in ${!colors_source[@]}; do
		sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $file
	done
	for i in ${!colors_source[@]}; do
		sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $file
	done
done

rm -v colors* override.colors.* *.sh README preview.svg
cp -av "$(grep -lr '^Name='"$colorscheme"'$' $XDG_DATA_HOME/color-schemes | head -1)" colors

cd -
