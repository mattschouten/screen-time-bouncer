#!/usr/bin/env bash

set -euo pipefail

usage(){
    echo "Usage: $0 <Target username>"
    exit 1
}

[[ $# -eq 0 ]] && usage

TARGET_USER=$1

ssh 172.16.1.110 -q <<EOF
    PID=\$(ps -e -o user:16,pid,cmd | grep gdm-x-session | grep $TARGET_USER | tr -s ' ' | cut -d ' ' -f 2)
    echo "Going to kill \$PID and end gdm-x-session for $TARGET_USER"
    
    sudo kill -HUP \$PID
EOF


# Future - capture something useful if user session wasn't found
