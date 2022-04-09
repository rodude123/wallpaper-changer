#!/bin/bash
chosenCat=`cat ./chosenCat.txt`

echo $chosenCat

if [[ ! -f ./saved.txt ]]; then
	mkdir -p "/home/rodude123/Pictures/wallpapers/$chosenCat"

	count=`ls "/home/rodude123/Pictures/wallpapers/$chosenCat" | wc -l`
	count=$((count+1))

	mv /home/rodude123/Pictures/wallpapers/current.png "/home/rodude123/Pictures/wallpapers/$chosenCat/$chosenCat-$count.png"

	echo "saved" > ./saved.txt
	notify-send "Wallpaper saved"
elif [[ -f ./alreadySaved.txt ]]; then
	notify-send "Wallpaper taken from stored wallpapers so cannot save again."
else
	notify-send "Wallpaper is already saved"
fi
