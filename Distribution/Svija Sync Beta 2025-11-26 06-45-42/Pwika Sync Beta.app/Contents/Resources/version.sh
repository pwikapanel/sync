#!/usr/bin/env bash

#  check-connection.sh
#  SvijaSync
#
#  Created by Rajesh Ramachandrakurup on 6/2/21.

rsync_path="$1"
success="$4"

"$rsync_path" --version && echo "$success"
