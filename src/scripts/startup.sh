#!/bin/bash
proserve -db /usr/db/felixdb.db -S 14440
$DLC/servers/pasoe/felix/bin/tcman.sh start
/bin/bash