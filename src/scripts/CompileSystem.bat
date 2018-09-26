SET JSON-LOCATION=%1
set DLC=C:\progress\openedge
start /wait %DLC%\bin\prowin -p ../prog/analysis/systemConnect.p -basekey "INI" -ininame %2
exit /B