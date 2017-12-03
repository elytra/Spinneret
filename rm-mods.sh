#!/bin/bash -e
mapfile=/tmp/$RANDOM$RANDOM
jq --raw-output '.[]|.[]|"\(.modid) \(.filename)"' modalyzer.json > $mapfile
for i in "$@"; do
	files=`grep "^$i " $mapfile | cut -d ' ' -f 2-`
	if [ -n "$files" ]; then
		for f in $files; do
			rm -fv modpack/src/mods/$f modpack/src/mods/*/$f
		done
	else
		echo no mod with id $i in this modpack, skipping
	fi
done
rm $mapfile
