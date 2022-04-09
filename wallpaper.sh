#!/bin/bash
# export $(dbus-launch)
if [[ $1 == "" ]]; then
    echo "no wallpaper engine  was chosen, choose from kde and nitrogen"
    exit
fi
categories=()

mapfile -t categories < ./categories.txt

randCat=$((RANDOM % ${#categories[@]}))
chosenCat=${categories[$randCat]}

rm -f ./chosenCat.txt
rm -f ./alreadySaved.txt

# wget  https://source.unsplash.com/3840x2160/?$chosenCat -O /home/rodude123/Pictures/wallpapers/current.png

if [[ $((1 + RANDOM % 100)) -le 50  ]]; then
	# notify-send	$chosenCat-$((1 + RANDOM % $count))

	if [[ -d /home/rodude123/Pictures/wallpapers/$chosenCat ]]; then
		count=`ls /home/rodude123/Pictures/wallpapers/$chosenCat | wc -l`
		count=$((count+1))
		cp -f /home/rodude123/Pictures/wallpapers/$chosenCat/$chosenCat-$((1 + RANDOM % $count)).png /home/rodude123/Pictures/wallpapers/current.png
		notify-send "Wallpaper taken form saved wallpapers"
		echo "already saved" > ./alreadySaved.txt
	else
		chosenCata=${chosenCat// /%20%}
		wget  https://source.unsplash.com/3840x2160/?$chosenCata -O /home/rodude123/Pictures/wallpapers/current.png
		rm -f ./saved.txt
		notify-send "Wallpaper doesn't exist so downloaded wallpaper instead"
	fi

else
	chosenCata=${chosenCat// /%20%}
	wget  https://source.unsplash.com/3840x2160/?$chosenCata -O /home/rodude123/Pictures/wallpapers/current.png
	rm -f ./saved.txt
fi

if [[ $1 == "kde" ]]; then
    dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
        var Desktops = desktops();                                                                                                                       
        for (i=0;i<Desktops.length;i++) {
                d = Desktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper",
                                            "org.kde.image",
                                            "General");
                d.writeConfig("Image", "file:///home/rodude123/Pictures/wallpapers/background.jpg");
        }'

        dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
        var Desktops = desktops();                                                                                                                       
        for (i=0;i<Desktops.length;i++) {
                d = Desktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper",
                                            "org.kde.image",
                                            "General");
                d.writeConfig("Image", "file:///home/rodude123/Pictures/wallpapers/current.png");
        }'
elif [[ $1 == "nitrogen" ]]; then
    nitrogen --restore
fi
echo $chosenCat > ./chosenCat.txt
sleep 5
notify-send "Wallpaper changed, new category: $chosenCat"
