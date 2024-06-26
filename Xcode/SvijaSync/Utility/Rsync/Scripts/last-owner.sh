#!/usr/bin/env bash

#  check-connection.sh
#  SvijaSync
#
#  Created by Rajesh Ramachandrakurup on 6/2/21.

last_modified_relative_path="$1"
rsync_path="$2"
remote_connection="$3"
password="$4"
success="$5"

exclusions=(
    --exclude ".DS_Store"
    --exclude ".swp"
    --exclude ".git"
    --exclude ".command"
    --exclude ".pwd"
)

export RSYNC_PASSWORD=$password
"$rsync_path" -azq --delete "${exclusions[@]}" "$remote_connection/$last_modified_relative_path" "SYNC/$last_modified_relative_path" && echo "$success"
RSYNC_PASSWORD=
