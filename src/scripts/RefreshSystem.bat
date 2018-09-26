set FELIX-SYSTEM-NAME=%1
set DLC=C:\progress\openedge
set CURRENT-DIR=%cd%
echo [1] Initializing system setup
echo [2] System is now creating .db file and loading data from .df and .st
echo [3] System is now generating Xref files
start /wait %DLC%\bin\prowin -b -p ../prog/analysis/systemFind.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000

echo Xref compilation is now complete. Proceeding.
echo [4] System is now searching for errors that may have occurred while generating Xref files.

start /wait %DLC%\bin\prowin -b -p ../prog/analysis/systemError.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000

echo Search complete
echo [5] Starting Xref analysis...

start /wait /min %DLC%\bin\prowin -b -p ../prog/analysis/xrefAnalysis.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000

echo Xref analysis complete. 

pause
msg * Setup complete. You can now start using the analyser.
exit /B