#!/bin/bash

LOG="startup.log"

function clean() {
	echo 'Stopping database...' >> "$LOG"
	$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/stopDB.sh
}

$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/createDB.sh
$DLC/servers/pasoe/felix/bin/tcman.sh start
/bin/bash

echo 'Waiting...'

trap clean SIGTERM

wait $!
