#!/bin/bash
LOG=createDB.log
PF=/usr/db/felixdb.pf
DF=$DLC/servers/pasoe/felix/dev/felix_shared/db/felixdb.df

mkdir /usr/db
prodb /usr/db/felixdb.db empty

#create PF
echo "-db /usr/db/felixdb.db -S 14440" > "$PF"

proserve -pf "$PF"

_progres -b -p "/usr/dlc/servers/pasoe/felix/dev/felix_core/src/scripts/loadDF.p" -param "$DF" -pf "$PF" > "$LOG"
