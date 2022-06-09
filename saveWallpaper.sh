#!/bin/bash
filePath=$(readlink -f "$0")
path=$(dirname "$filePath")

chosenCat=$(cat "$path/chosenCat.txt")

if [[ -f $path/alreadySaved.txt ]]; then
	notify-send "Wallpaper taken from stored wallpapers so cannot save again."
	echo  "Wallpaper taken from stored wallpapers so cannot save again."
elif [[ ! -f $path/saved.txt ]]; then
	mkdir -p "$HOME/Pictures/wallpapers/$chosenCat"

	count=`ls "$HOME/Pictures/wallpapers/$chosenCat" | wc -l`
	count=$((count+1))

	cp -f $HOME/Pictures/wallpapers/current.png "$HOME/Pictures/wallpapers/$chosenCat/$chosenCat-$count.png"
    
	echo "saved" > $path/saved.txt
	notify-send "Wallpaper saved"
	echo "Wallpaper saved"
else
	notify-send "Wallpaper is already saved"
	echo "Wallpaper is already saved"
fi
