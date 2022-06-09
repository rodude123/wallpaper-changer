# wallpaper-changer
This is a set of scripts to change your wallpaper and save it to your pictures directory so that it can be recycled back as one of the pictures.

## init.sh
This script makes the wallpapers directory in your users pictures folder, then creates the cw and sw scripts which allow you to run them globally.

## wallpaper.sh
This script randomly chooses to download a wallpaper or chose one from your local list of wallpapers. If downloading a wallper is chosen it will download a wallpaper and set it. If choosing a wallpaper from your local list is chosen then it will try and find a wallpaper in the chosen category's directory, if one doesn't exist it will download one instead and set it.

## saveWallpaper.sh
This script saves the current wallpaper to the chosen category's directory.

## usage
Run `./init.sh` first as you may get errors when saving, or create the wallpapers directory in the pictures directory. You may have to supply a root password for the script to mv the cw and sw scripts into the bin directory. 
