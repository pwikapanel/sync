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
    --exclude ".swp"
    --exclude ".git"
    --exclude ".command"
    --exclude ".pwd"
)

export RSYNC_PASSWORD=$password
"$rsync_path" -azq --delete "${exclusions[@]}" "$remote_connection" "sync/" && echo "$success"
RSYNC_PASSWORD=
