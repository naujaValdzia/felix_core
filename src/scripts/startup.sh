#!/bin/bash
$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/createDB.sh
$DLC/servers/pasoe/felix/bin/tcman.sh start
/bin/bash

function clean(){
	$DLC/servers/pasoe/felix/dev/felix_core/src/scripts/stopDB.sh
}

trap clean SIGINT SIGTERM

wait $!
