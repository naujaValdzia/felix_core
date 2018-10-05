#!/bin/bash
LOG=/usr/db/createDB.log
PF=/usr/db/felixdb.pf
DF=$DLC/servers/pasoe/felix/dev/felix_shared/db/felixdb.df
#DBLOC=/usr/db

#create PF
echo "-db /usr/db/felixdb.db -S 14440" > "$PF"

if [ ! -f /usr/db/felixdb.db ]
then
	#create empty DB
	mkdir /usr/db
	prodb /usr/db/felixdb.db empty
	proserve -pf "$PF"
	#load DF
	_progres -b -p "/usr/dlc/servers/pasoe/felix/dev/felix_core/src/scripts/loadDF.p" -param "$DF" -pf "$PF" > "$LOG"
else
	proserve -pf "$PF"
fi
