#!/usr/bin/env bash

set -euo pipefail

get_target_list() {
	local -a targets
	for t in "$@"; do
		targets+=( "($t)" )
	done

	local IFS='|'
	echo "${targets[*]}"
}

TARGET_LIST=$(get_target_list $@)
active_kiddos=$(who | awk "\$1~/${TARGET_LIST}/ { print \$1 }") 
if [[ ! -z $active_kiddos ]]
then
	espeak "Time to log off!"
fi

for kiddo in $active_kiddos
do
	echo "Logging off $kiddo"
	pkill -HUP -u $kiddo
done

sleep 15

for kiddo in $active_kiddos
do
	pkill -u $kiddo
done

echo "Finished logging off kiddos at $(date)"
