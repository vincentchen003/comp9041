#!/bin/sh
if test -f "$1";
then
i=0;
while [[ i>=0 ]]; do
	str=".$1"".$i";
	let i=i+1;
	if test ! -f "$str"; then
		cp "$1" "$str";
		echo "Backup of '$1' saved as '$str'"
		break
	fi

done
fi
