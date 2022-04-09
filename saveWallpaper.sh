#!/bin/bash
chosenCat=`cat ./chosenCat.txt`

filePath=$(readlink -f "$0")
path=$(dirname "$filePath")

echo $chosenCat

if [[ ! -f ./saved.txt ]]; then
	mkdir -p "/home/rodude123/Pictures/wallpapers/$chosenCat"

	count=`ls "/home/rodude123/Pictures/wallpapers/$chosenCat" | wc -l`
	count=$((count+1))

	mv /home/rodude123/Pictures/wallpapers/current.png "/home/rodude123/Pictures/wallpapers/$chosenCat/$chosenCat-$count.png"

	echo "saved" > $path/saved.txt
	notify-send "Wallpaper saved"
	echo "Wallpaper saved"
elif [[ -f $path/alreadySaved.txt ]]; then
	notify-send "Wallpaper taken from stored wallpapers so cannot save again."
	echo  "Wallpaper taken from stored wallpapers so cannot save again."
else
	notify-send "Wallpaper is already saved"
	echo "Wallpaper is already saved"
fi
