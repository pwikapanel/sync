#!/usr/bin/env bash

#  check-connection.sh
#  SvijaSync
#
#  Created by Rajesh Ramachandrakurup on 6/2/21.

rsync_path="$1"
remote_connection="$2"
password="$3"
success="$4"

exclusions=(
    --exclude ".DS_Store"
    --exclude ".swp"
    --exclude ".git"
    --exclude ".command"
    --exclude ".pwd"
)

# added 220205 by Andrew

#   no_images=SYNC/SVIJA/SVG\ Files/
#   jpg=.jpg
#   png=.png
#   
#   rm -rf "$no_images"*"$jpg"
#   rm -rf "$no_images"*"$png"

shopt -s extglob
svg_folder=SYNC/SVIJA/SVG\ Files/
#rm -rf "$svg_folder"*.!(svg) # deletes my.file.svg
rm -rf "$svg_folder"!(*.svg) 

# end added 220205

export RSYNC_PASSWORD=$password
"$rsync_path" -azq --delete "${exclusions[@]}" "SYNC/" $remote_connection && echo "$success"
RSYNC_PASSWORD=
