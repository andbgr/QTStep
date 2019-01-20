#!/bin/bash

find . -type f -name '*.xpm' | \
while read i; do
	sed -i 's/\(#......\)/\L\1/' "$i"
done

exit 0
