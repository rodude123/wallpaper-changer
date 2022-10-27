#!/bin/bash
# export $(dbus-launch)
export DISPLAY=":0"

if [[ $1 == "" ]]; then
    echo "no wallpaper engine  was chosen, choose from kde and nitrogen"
    exit
fi
filePath=$(readlink -f "$0")
path=$(dirname "$filePath")
categories=()

mapfile -t categories <  $path/categories.txt

clientID=$(head -n 1 $path/clientID.txt)

randCat=$((RANDOM % ${#categories[@]}))
chosenCat=${categories[$randCat]}

rm -f $path/chosenCat.txt
rm -f $path/alreadySaved.txt

rm -f $HOME/Pictures/wallpapers/current.png

if [[ $((1 + RANDOM % 100)) -le 50  ]]; then

	if [[ -d "$HOME/Pictures/wallpapers/$chosenCat" ]]; then
		count=`ls "$HOME/Pictures/wallpapers/$chosenCat" | wc -l`
		count=$((count+1))
		cp -f "$HOME/Pictures/wallpapers/$chosenCat/$chosenCat-$((1 + RANDOM % $count)).png" $HOME/Pictures/wallpapers/current.png
		notify-send "Wallpaper taken form saved wallpapers"
		echo "Wallpaper taken form saved wallpapers"
		echo "already saved" > $path/alreadySaved.txt
	else
		notify-send "Wallpaper doesn't exist so downloaded wallpaper instead"
		echo "Wallpaper doesn't exist so downloaded wallpaper instead"
		chosenCata=${chosenCat// /%20%}
		url=$(curl "https://api.unsplash.com/photos/random?query=$chosenCata&orientation=landscape&client_id=$clientID" | jq '. | .urls.raw' | sed 's/"//g')
		wget $url -O $HOME/Pictures/wallpapers/current.png & > /dev/null
		rm -f $path/saved.txt
	fi

else
    notify-send "Wallpaper doesn't exist so downloaded wallpaper instead"
    echo "Wallpaper doesn't exist so downloaded wallpaper instead"
	chosenCata=${chosenCat// /%20%}
	url=$(curl "https://api.unsplash.com/photos/random?query=$chosenCata&orientation=landscape&client_id=$clientID" | jq '. | .urls.raw' | sed 's/"//g')
	wget $url -O $HOME/Pictures/wallpapers/current.png & > /dev/null
	rm -f $path/saved.txt
fi

sleep 4

if [[ $1 == "kde" ]]; then
		dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
        var Desktops = desktops();                                                                                                                       
        for (i=0;i<Desktops.length;i++) {
                d = Desktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper",
                                            "org.kde.image",
                                            "General");
                d.writeConfig("Image", "file:///usr/share/wallpapers/Canopee/contents/images/3840x2160.png");
        }'

        dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
        var Desktops = desktops();                                                                                                                       
        for (i=0;i<Desktops.length;i++) {
                d = Desktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper",
                                            "org.kde.image",
                                            "General");
                d.writeConfig("Image", "file://'$HOME'/Pictures/wallpapers/current.png");
        }'
elif [[ $1 == "nitrogen" ]]; then
    sleep 2 && nitrogen --restore
fi
echo $chosenCat > $path/chosenCat.txt
sleep 2
notify-send "Wallpaper changed, new category: $chosenCat"
echo "Wallpaper changed, new category: $chosenCat"
