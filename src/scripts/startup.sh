#!/bin/bash

LOG="startup.log"

function clean() {
	echo 'Stopping database...' >> "$LOG"
	$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/stopDB.sh
}

$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/createDB.sh
$DLC/servers/pasoe/felix/bin/tcman.sh start
/bin/bash

#TODO start npm
#cd $DLC/servers/pasoe/felix/dev/felix_front/felix
#npm start &

trap clean INT SIGINT SIGTERM

echo 'Waiting...'

wait $!
