#!/bin/bash
# Shading functions ported from QtCurve, plus a few helper functions
# License is GNU Lesser General Public License version 2.1 or (at your option) version 3


function min {
	echo $@ | tr ' ' '\n' | sort -n | head -1
}


function max {
	echo $@ | tr ' ' '\n' | sort -n | tail -1
}


function round {
	bc <<< "($1 + 0.5) / 1"
}


function blend {
        r1=$(echo $1 | cut -d, -f1)
        g1=$(echo $1 | cut -d, -f2)
        b1=$(echo $1 | cut -d, -f3)
	
	r2=$(echo $2 | cut -d, -f1)
        g2=$(echo $2 | cut -d, -f2)
        b2=$(echo $2 | cut -d, -f3)
	
	r=$(bc -l <<< "$r1 + ($r2 - $r1) * $3")
	g=$(bc -l <<< "$g1 + ($g2 - $g1) * $3")
	b=$(bc -l <<< "$b1 + ($b2 - $b1) * $3")

	r=$(round $r)
	g=$(round $g)
	b=$(round $b)

	echo "$r,$g,$b"
}


function hextorgb {
        r=$((0x$(echo $1 | cut -b2-3)))
        g=$((0x$(echo $1 | cut -b4-5)))
        b=$((0x$(echo $1 | cut -b6-7)))

        echo "$r,$g,$b"
}


function rgbtohex {
	r=$(printf %02x $(echo $1 | cut -d, -f1))
	g=$(printf %02x $(echo $1 | cut -d, -f2))
	b=$(printf %02x $(echo $1 | cut -d, -f3))

        echo "#$r$g$b"
}


function rgbtohsl {
	r=$(echo $1 | cut -d, -f1)
	g=$(echo $1 | cut -d, -f2)
	b=$(echo $1 | cut -d, -f3)

	r=$(bc -l <<< "$r / 255")
	g=$(bc -l <<< "$g / 255")
	b=$(bc -l <<< "$b / 255")

	min=$(min $r $g $b)
	max=$(max $r $g $b)
	
	l=$(bc -l <<< "($max + $min) / 2")
	s=0
	h=0
	
	if (($(bc -l <<< "$max != $min"))); then
		delta=$(bc -l <<< "$max - $min")
		if (($(bc -l <<< "$l <= 0.5"))); then
			s=$(bc -l <<< "$delta / ($max + $min)")
		else
			s=$(bc -l <<< "$delta / (2 - $max - $min)")
		fi
		
		if (($(bc -l <<< "$r == $max"))); then
			h=$(bc -l <<< "($g - $b) / $delta")
		elif (($(bc -l <<< "$g == $max"))); then
			h=$(bc -l <<< "2 + ($b - $r) / $delta")
		elif (($(bc -l <<< "$b == $max"))); then
			h=$(bc -l <<< "4 + ($r - $g) / $delta")
		fi
	
		h=$(bc -l <<< "$h / 6")
		if (($(bc -l <<< "$h < 0"))); then
			h=$(bc -l <<< "$h + 1")
		fi
	fi

	echo "$h,$s,$l"
}	


function h2c {
	h=$1
	m1=$2
	m2=$3

	h=$(bc <<< "$h % 6")
	if (($(bc -l <<< "$h < 0"))); then
		h=$(bc -l <<< "$h + 6")
	fi

	if (($(bc -l <<< "$h < 1"))); then
		bc -l <<< "$m1 + ($m2 - $m1) * $h"
	elif (($(bc -l <<< "$h < 3"))); then
		echo $m2
	elif (($(bc -l <<< "$h < 4"))); then
		bc -l <<< "$m1 + ($m2 - $m1) * (4 - $h)"
	else
		echo $m1
	fi
}


function hsltorgb {
	h=$(echo $1 | cut -d, -f1)
	s=$(echo $1 | cut -d, -f2)
	l=$(echo $1 | cut -d, -f3)
	
	h=$(bc -l <<< "$h * 6")

	if (($(bc -l <<< "$l <= 0.5"))); then
		m2=$(bc -l <<< "$l * (1 + $s)")
	else
		m2=$(bc -l <<< "$l + $s * (1 - $l)")
	fi
	
	m1=$(bc -l <<< "2 * $l - $m2")

	r=$(h2c $(bc -l <<< "$h + 2") $m1 $m2)
	g=$(h2c $h $m1 $m2)
	b=$(h2c $(bc -l <<< "$h - 2") $m1 $m2)

	r=$(bc <<< "$r * 255")
	g=$(bc <<< "$g * 255")
	b=$(bc <<< "$b * 255")

	r=$(round $r)
	g=$(round $g)
	b=$(round $b)

	echo "$r,$g,$b"
}


# Usage: shadehsl r,g,b k
# r,g,b is decimal from 0 to 255
# k is shading factor, 1.0 means no change
function shadehsl {
	c=$(rgbtohsl $1)

	h=$(echo $c | cut -d, -f1)
	s=$(echo $c | cut -d, -f2)
	l=$(echo $c | cut -d, -f3)
	
	k=$2

	l=$(bc -l <<< "$l * $k")
	if (($(bc -l <<< "$l > 1"))); then
		l=1
	fi

	s=$(bc -l <<< "$s * $k")
	if (($(bc -l <<< "$s > 1"))); then
		s=1
	fi

	hsltorgb "$h,$s,$l"
}


# Usage: shadehsl r,g,b k
# r,g,b is decimal from 0 to 255
# k is shading factor, 1.0 means no change
function shadesimple {
	r=$(echo $1 | cut -d, -f1)
	g=$(echo $1 | cut -d, -f2)
	b=$(echo $1 | cut -d, -f3)
	
	k=$2
	
	r=$(bc -l <<< "$r / 255")
	g=$(bc -l <<< "$g / 255")
	b=$(bc -l <<< "$b / 255")

	v=$(bc -l <<< "$k - 1")

	r=$(bc -l <<< "$r + $v")
	g=$(bc -l <<< "$g + $v")
	b=$(bc -l <<< "$b + $v")
	
	r=$(min $(max $r 0) 1)
	g=$(min $(max $g 0) 1)
	b=$(min $(max $b 0) 1)
	
	r=$(bc <<< "$r * 255")
	g=$(bc <<< "$g * 255")
	b=$(bc <<< "$b * 255")

	r=$(round $r)
	g=$(round $g)
	b=$(round $b)

	echo "$r,$g,$b"
}
