#!/bin/bash
# Usage: make_theme.sh colors.NAME


for size in 19 23 27 31 35; do
	colorscheme="$(echo "$1" | sed 's/colors.//')"
	displayname="QTStep Traditional $colorscheme "$size"p"
	name="$(echo "$displayname" | tr -d ' ')"
	
	rm -rv    ../../$name
	cp -av .. ../../$name
	cd        ../../$name/xfwm4
	
	for file in *."$size"p.xpm; do
		mv -v $file $(echo $file | sed "s/\."$size"p//")
	done

	for file in *.traditional*; do
		mv -v $file $(echo $file | sed 's/\.traditional//')
	done
	
	rm -v *[0-9]p.xpm
	
	declare -A colors_source
	while read key val; do
		colors_source[$key]=$val
	done < colors
	
	declare -A colors_theme
	while read key val; do
		colors_theme[$key]=$val
	done < "colors.$colorscheme"

	sed -i "s/^active_text_color=.*/active_text_color=${colors_theme[text-active]}/"       themerc 
	sed -i "s/^inactive_text_color=.*/inactive_text_color=${colors_theme[text-inactive]}/" themerc 
	
	for file in *.xpm; do
		for i in ${!colors_source[@]}; do
			sed -i "s/${colors_source[$i]}/PLACEHOLDER-$i-PLACEHOLDER/g" $file
		done
		for i in ${!colors_source[@]}; do
			sed -i "s/PLACEHOLDER-$i-PLACEHOLDER/${colors_theme[$i]}/g" $file
		done
	done
	
	rm -v colors* override.colors.* *.sh README

	cd -
done
