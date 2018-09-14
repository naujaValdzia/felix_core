 
 /*------------------------------------------------------------------------
    File        : FindSystem
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Tue Sep 11 16:19:23 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class FindSystem: 
    {tt/ttCompilerParameters.i}
    
    define variable iniFileName as character no-undo.
    
    method public void systemFind():
        define variable vSystem as character no-undo.
        vSystem = os-getenv("FELIX-SYSTEM-NAME").
        
        find first system where 
                   system.systemName = vSystem.
        create ttSystemInfo.
               ttSystemInfo.systemName = system.systemName.
               ttSystemInfo.localSourcePath = system.localSourcePath.
               ttSystemInfo.systemPropath = system.systemPropath.
               ttSystemInfo.systemDBparameters = system.systemDBparameters.
        
        iniFileName = createINI(propath + "," + ttSystemInfo.systemPropath + ",").
        os-delete value(os-getenv("TEMP") + "/" + ttSystemInfo.systemName) recursive.
        temp-table ttSystemInfo:write-json ("file", os-getenv("TEMP") + "\FelixSystemInfo.json", yes).
        os-command silent value("CompileSystem.bat " + OS-GETENV("TEMP") + "\FelixSystemInfo.json" + " " + iniFileName).
        pause.
        quit.
    end method.

    method public character createINI (ppropath as character):
        iniFileName = os-getenv("TEMP") + "\" + os-getenv("FELIX-SYSTEM-NAME") + "Propath.ini".
        output to value(iniFileName).
            put unformatted subst("[Startup] ~nPROPATH= &1~n~n[WinChar Startup]~nPROPATH= &1~n",ppropath).
        output close.
        return iniFileName.
    end method.
end class.