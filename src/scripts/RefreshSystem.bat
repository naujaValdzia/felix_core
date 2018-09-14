@echo %1
set FELIX-SYSTEM-NAME=%1
set DLC=C:\progress\openedge
%DLC%\bin\prowin -b -p ../prog/analysis/systemFind.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000

:waitloop
IF EXIST %TEMP%"\compile.done" GOTO waitloopend
timeout /t 1
goto waitloop
:waitloopend

%DLC%\bin\prowin -b -p ../prog/analysis/systemError.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000 
%DLC%\bin\prowin -b -p ../prog/analysis/xrefAnalysis.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000 
del %TEMP%\compile.done
#%DLC%\bin\prowin -b -p ../prog/analysis/unused.p -basekey "INI" -ininame FelixPropath -db felixdb -S 9000 