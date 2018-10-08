 
 /*------------------------------------------------------------------------
    File        : FindSystem
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class FindSystem: 
    {tt/ttCompilerParameters.i}
    
    define variable iniFileName as character no-undo.
    define variable cDir as character no-undo.
    define variable cFileStream as character no-undo.
    
    method public void systemFind():
        define variable vSystem as character no-undo.
        vSystem = os-getenv("FELIX_SYSTEM_NAME").
        cDir = os-getenv("CURRENT_DIR").
        
        find first system where 
                   system.systemName = vSystem.
        create ttSystemInfo.
               ttSystemInfo.systemName = system.systemName.
               ttSystemInfo.localSourcePath = system.localSourcePath.
               ttSystemInfo.systemPropath = system.systemPropath.
               ttSystemInfo.systemDBparameters = system.systemDBparameters.
               
        deleteOldDb(vSystem, cDir).
        //iniFileName = createINI(propath + "," + ttSystemInfo.systemPropath + ",").
        os-delete value(os-getenv("TEMP") + "/" + ttSystemInfo.systemName) recursive.
        temp-table ttSystemInfo:write-json ("file", os-getenv("TEMP") + "/FelixSystemInfo.json", yes).
        os-command silent value("./CompileSystem.sh " + os-getenv("TEMP") + "/FelixSystemInfo.json").
        // kodel mum reikejo iniFileName?????????
        // + " " + iniFileName LN:34
        pause.
        quit.
    end method.

/*    method public character createINI (ppropath as character):                                            */
/*        iniFileName = os-getenv("TEMP") + "/" + os-getenv("FELIX_SYSTEM_NAME") + "Propath.ini".           */
/*        output to value(iniFileName).                                                                     */
/*            put unformatted subst("[Startup] ~nPROPATH= &1~n~n[WinChar Startup]~nPROPATH= &1~n",ppropath).*/
/*        output close.                                                                                     */
/*        return iniFileName.                                                                               */
/*    end method.                                                                                           */
    
    method public void deleteOldDb (vSystem as character, cDir as character):
        input from os-dir (cDir).
        repeat:
            import cFileStream.
            if cFileStream matches ("*" + vSystem + "*")
            then do:
                 os-delete value(cDir + "/" + cFileStream).
            end.
        end.  
        os-delete value(ttSystemInfo.systemDBparameters + "/" + vSystem + ".db") no-error.
    end method.
end class.