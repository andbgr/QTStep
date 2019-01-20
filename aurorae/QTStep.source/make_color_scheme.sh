#!/bin/bash
# see README

source "$(dirname $0)"/qtcurve_shading.sh

name="$(grep '^Name=' $1 | sed 's/^Name=//')"
file="colors.$name"
cp -av colors "$file"

if test -e "override.$file"; then
	declare -A colors_override
	while read key val; do
		colors_override[$key]=$(hextorgb $val)
	done < "override.$file"
fi

declare -A colors

colors[active]=$(sed -nr '/\[WM\]/,/\[/{s/^activeBackground=(.*)/\1/p}' $1)
colors[inactive]=$(sed -nr '/\[WM\]/,/\[/{s/^inactiveBackground=(.*)/\1/p}' $1)
colors[selection]=$(sed -nr '/\[Colors:Selection\]/,/\[/{s/^BackgroundNormal=(.*)/\1/p}' $1)
colors[bg]=$(sed -nr '/\[Colors:Window\]/,/\[/{s/^BackgroundNormal=(.*)/\1/p}' $1)
colors[button]=$(sed -nr '/\[Colors:Button\]/,/\[/{s/^BackgroundNormal=(.*)/\1/p}' $1)
colors[view]=$(sed -nr '/\[Colors:View\]/,/\[/{s/^BackgroundNormal=(.*)/\1/p}' $1)

test -v colors_override[@] && for i in active inactive bg; do
	if test ${colors_override[$i]+_}; then
		colors[$i]=${colors_override[$i]}
	fi
done

colors[active-border]=$(shadesimple ${colors[active]} 0.333)
colors[active-highlight]=$(shadesimple ${colors[active]} 1.333)
colors[active-innerdark]=$(shadesimple ${colors[active]} 0.833)
colors[active-hover]=$(shadesimple ${colors[active]} 1.042)
colors[active-pressed]=$(shadesimple ${colors[active]} 0.833)

colors[active-gradient-1]=$(shadesimple ${colors[active]} 1.242)
colors[active-gradient-2]=$(shadesimple ${colors[active]} 1.022)
colors[active-gradient-3]=$(shadesimple ${colors[active]} 1.022)
colors[active-gradient-4]=$(shadesimple ${colors[active]} 1.014)
colors[active-gradient-5]=$(shadesimple ${colors[active]} 0.962)
colors[active-gradient-6]=$(shadesimple ${colors[active]} 0.982)
colors[active-gradient-7]=$(shadesimple ${colors[active]} 0.962)
colors[active-gradient-8]=$(shadesimple ${colors[active]} 1.242)

test -v colors_override[@] && for i in active-gradient-{1..8}; do
	if test ${colors_override[$i]+_}; then
		colors[$i]=${colors_override[$i]}
	fi
done

colors[active-gradient-1-highlight]=$(shadesimple ${colors[active-gradient-1]} 1.333)
colors[active-gradient-2-highlight]=$(shadesimple ${colors[active-gradient-2]} 1.333)
colors[active-gradient-3-highlight]=$(shadesimple ${colors[active-gradient-3]} 1.333)
colors[active-gradient-4-highlight]=$(shadesimple ${colors[active-gradient-4]} 1.333)
colors[active-gradient-5-highlight]=$(shadesimple ${colors[active-gradient-5]} 1.333)
colors[active-gradient-6-highlight]=$(shadesimple ${colors[active-gradient-6]} 1.333)
colors[active-gradient-7-highlight]=$(shadesimple ${colors[active-gradient-7]} 1.333)
colors[active-gradient-8-highlight]=$(shadesimple ${colors[active-gradient-8]} 1.333)

colors[active-gradient-1-innerdark]=$(shadesimple ${colors[active-gradient-1]} 0.833)
colors[active-gradient-2-innerdark]=$(shadesimple ${colors[active-gradient-2]} 0.833)
colors[active-gradient-3-innerdark]=$(shadesimple ${colors[active-gradient-3]} 0.833)
colors[active-gradient-4-innerdark]=$(shadesimple ${colors[active-gradient-4]} 0.833)
colors[active-gradient-5-innerdark]=$(shadesimple ${colors[active-gradient-5]} 0.833)
colors[active-gradient-6-innerdark]=$(shadesimple ${colors[active-gradient-6]} 0.833)
colors[active-gradient-7-innerdark]=$(shadesimple ${colors[active-gradient-7]} 0.833)
colors[active-gradient-8-innerdark]=$(shadesimple ${colors[active-gradient-8]} 0.833)

colors[inactive-border]=$(shadesimple ${colors[inactive]} 0.333)
colors[inactive-highlight]=$(shadesimple ${colors[inactive]} 1.333)
colors[inactive-innerdark]=$(shadesimple ${colors[inactive]} 0.667)
colors[inactive-hover]=$(shadesimple ${colors[inactive]} 1.042)
colors[inactive-pressed]=$(shadesimple ${colors[inactive]} 0.833)

colors[selection-border]=$(shadesimple ${colors[selection]} 0.333)
colors[selection-highlight]=$(shadesimple ${colors[selection]} 1.333)
colors[selection-innerdark]=$(shadesimple ${colors[selection]} 0.833)
colors[selection-hover]=$(shadesimple ${colors[selection]} 1.042)
colors[selection-pressed]=$(shadesimple ${colors[selection]} 0.833)

colors[bg-border]=$(shadesimple ${colors[bg]} 0.333)
colors[bg-highlight]=$(shadesimple ${colors[bg]} 1.333)
colors[bg-innerdark]=$(shadesimple ${colors[bg]} 0.667)
colors[bg-hover]=$(shadesimple ${colors[bg]} 1.042)
colors[bg-pressed]=$(shadesimple ${colors[bg]} 0.833)

colors[button-border]=$(shadesimple ${colors[button]} 0.333)
colors[button-highlight]=$(shadesimple ${colors[button]} 1.333)
colors[button-innerdark]=$(shadesimple ${colors[button]} 0.667)
colors[button-hover]=$(shadesimple ${colors[button]} 1.042)
colors[button-pressed]=$(shadesimple ${colors[button]} 0.833)

colors[view-hover]=$(shadesimple ${colors[view]} 1.042)

colors[text-active]=$(sed -nr '/\[WM\]/,/\[/{s/^activeForeground=(.*)/\1/p}' $1)
colors[text-inactive]=$(sed -nr '/\[WM\]/,/\[/{s/^inactiveForeground=(.*)/\1/p}' $1)
colors[text-selection]=$(sed -nr '/\[Colors:Selection\]/,/\[/{s/^ForegroundNormal=(.*)/\1/p}' $1)
colors[text-bg]=$(sed -nr '/\[Colors:Window\]/,/\[/{s/^ForegroundNormal=(.*)/\1/p}' $1)
colors[text-button]=$(sed -nr '/\[Colors:Button\]/,/\[/{s/^ForegroundNormal=(.*)/\1/p}' $1)
colors[text-view]=$(sed -nr '/\[Colors:View\]/,/\[/{s/^ForegroundNormal=(.*)/\1/p}' $1)

test -v colors_override[@] && for i in ${!colors_override[@]}; do
	if test ${colors_override[$i]+_}; then
		colors[$i]=${colors_override[$i]}
	fi
done

colors[active-highlight-innerdark]=$(blend ${colors[active-highlight]} ${colors[active-innerdark]} 0.5)
colors[inactive-highlight-innerdark]=$(blend ${colors[inactive-highlight]} ${colors[inactive-innerdark]} 0.5)

colors[text-button-semi]=$(blend ${colors[text-button]} ${colors[button]} 0.5)



for i in $(cat colors | cut -f1); do
	sed -i "/^$i/s/#.*/$(rgbtohex ${colors[$i]})/" "$file"
done

exit 0
