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
	displayname="QTStep Gradient $colorscheme "$size"p"
	name="$(echo "$displayname" | tr -d ' ')"
	
	rm -rv   ../$name
	cp -av . ../$name
	cd       ../$name
	mv -v QTStep.sourcerc "$name"rc
	
	rm -v *.traditional.svg QTStep.sourcerc.traditional
	for i in *.gradient.svg; do
		mv -v $i $(echo $i | sed 's/\.gradient\.svg/.svg/')
	done
	
	sed -i "s/^Name=.*/Name=$displayname/"                            metadata.desktop
	sed -i "s/^X-KDE-PluginInfo-Name=.*/X-KDE-PluginInfo-Name=$name/" metadata.desktop
	
	sed -i "s/TitleHeight=.*/TitleHeight=$size/"                  "$name"rc
	sed -i "s/ButtonHeight=.*/ButtonHeight=$size/"                "$name"rc
	sed -i "s/ButtonWidth=.*/ButtonWidth=$(($size + 2))/"         "$name"rc
	sed -i "s/ButtonWidthMenu=.*/ButtonWidthMenu=$(($size - 4))/" "$name"rc

	sed -i "/id=\"/s/-"$size"p\"/\"/" decoration.svg

	declare -A colors_source
	while read key val; do
		colors_source[$key]=$val
	done < colors
	
	declare -A colors_theme
	while read key val; do
		colors_theme[$key]=$val
	done < "colors.$colorscheme"

	# Make Button hover background transparent to make the background gradient visible
	for i in alldesktops.svg close.svg help.svg keepabove.svg keepbelow.svg maximize.svg minimize.svg restore.svg shade.svg; do
		sed -i "/fill:${colors_source[active-hover]}/s/fill-opacity:1/fill-opacity:0.085/" $i
		sed -i "/fill-opacity:0.085/s/fill:${colors_source[active-hover]}/fill:#ffffff/" $i
	done

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
