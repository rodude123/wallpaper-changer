#!/bin/bash
chosenCat=`cat /home/rodude123/wallpaperChanger/chosenCat.txt`

echo $chosenCat

if [[ ! -f /home/rodude123/wallpaperChanger/saved.txt ]]; then
	mkdir -p "/home/rodude123/Pictures/wallpapers/$chosenCat"

	count=`ls "/home/rodude123/Pictures/wallpapers/$chosenCat" | wc -l`
	count=$((count+1))

	mv /home/rodude123/Pictures/wallpapers/current.png "/home/rodude123/Pictures/wallpapers/$chosenCat/$chosenCat-$count.png"

	echo "saved" > /home/rodude123/wallpaperChanger/saved.txt
	notify-send "Wallpaper saved"
elif [[ -f /home/rodude123/wallpaperChanger/alreadySaved.txt ]]; then
	notify-send "Wallpaper taken from stored wallpapers so cannot save again."
else
	notify-send "Wallpaper is already saved"
fi