#!/bin/bash

export JSON_LOCATION=$1
LOG=compilation.log

_progres -b -p ../prog/analysis/systemConnect.p >> "$LOG"
wait

#start /wait %DLC%\bin\prowin -p ../prog/analysis/systemConnect.p -basekey "INI" -ininame %2
#exit /B