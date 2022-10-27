#!/bin/bash
mkdir -p $HOME/Pictures/wallpapers

if [[ $1 == "" ]]; then
    echo "no wallpaper engine  was chosen, choose from kde and nitrogen"
    exit
fi

if [[ $2 == "" ]]; then
	echo "Client ID not supplied, to obtain a client ID visit https://unsplash.com/documentation#creating-a-developer-account"
	exit
fi

echo -e "#!/bin/bash\n$PWD/wallpaper.sh $1" > cw
echo -e $2 > clientID.txt
echo -e "#!/bin/bash\n$PWD/saveWallpaper.sh" > sw

chmod +x cw sw

sudo mv cw /bin/cw
sudo mv sw /bin/sw
