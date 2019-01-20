#!/bin/bash
# Usage: make_theme.sh colors.NAME


function hextorgb {
	r=$((0x$(echo $1 | cut -b2-3)))
	g=$((0x$(echo $1 | cut -b4-5)))
	b=$((0x$(echo $1 | cut -b6-7)))

	echo "$r,$g,$b"
}


for size in 19 23 27 31 35; do
	colorscheme="$(echo "$1" | sed 's/colors.//')"
	displayname="QTStep Traditional $colorscheme "$size"p"
	name="$(echo "$displayname" | tr -d ' ')"
	
	rm -rv   ../$name
	cp -av . ../$name
	cd       ../$name
	mv -v QTStep.sourcerc.traditional "$name"rc
	
	rm -v *.gradient.svg QTStep.sourcerc
	for i in *.traditional.svg; do
		mv -v $i $(echo $i | sed 's/\.traditional\.svg/.svg/')
	done
	
	sed -i "s/^Name=.*/Name=$displayname/"                            metadata.desktop
	sed -i "s/^X-KDE-PluginInfo-Name=.*/X-KDE-PluginInfo-Name=$name/" metadata.desktop
	
	sed -i "s/TitleHeight=.*/TitleHeight=$(($size - 8))/"         "$name"rc
	sed -i "s/ButtonHeight=.*/ButtonHeight=$(($size - 8))/"       "$name"rc
	sed -i "s/ButtonWidth=.*/ButtonWidth=$(($size - 8))/"         "$name"rc
	sed -i "s/ButtonWidthMenu=.*/ButtonWidthMenu=$(($size - 8))/" "$name"rc

	sed -i "/id=\"/s/-"$size"p\"/\"/" decoration.svg

	declare -A colors_source
	while read key val; do
		colors_source[$key]=$val
	done < colors
	
	declare -A colors_theme
	while read key val; do
		colors_theme[$key]=$val
	done < "colors.$colorscheme"

	sed -i "s/^ActiveTextColor=.*/ActiveTextColor=$(hextorgb ${colors_theme[text-active]})/"       "$name"rc 
	sed -i "s/^InactiveTextColor=.*/InactiveTextColor=$(hextorgb ${colors_theme[text-inactive]})/" "$name"rc 
	
	for file in *.svg; do
		for i in ${!colors_source[@]}; do
			sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $file
		done
		for i in ${!colors_source[@]}; do
			sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $file
		done
	done
	
	rsvg-convert preview.svg -o preview.png

	rm -v colors* override.colors.* *.sh README preview.svg

	cd -
done
