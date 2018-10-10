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
        cDir = replace(os-getenv("CURRENT_DIR"),"~\","/").
        
        find first system where 
                   system.systemName = vSystem.
        create ttSystemInfo.
               ttSystemInfo.systemName = system.systemName.
               ttSystemInfo.localSourcePath = AnalysisUtility:addPath(system.localSourcePath).
               ttSystemInfo.systemPropath = AnalysisUtility:addPropathPath(system.systemPropath).
               ttSystemInfo.systemDBparameters = AnalysisUtility:addPath(system.systemDBparameters).
               
        deleteOldDb(vSystem, cDir).

        os-delete value(os-getenv("TEMP") + "/" + ttSystemInfo.systemName) recursive.
        temp-table ttSystemInfo:write-json ("file", os-getenv("TEMP") + "/FelixSystemInfo.json", yes).
        os-command silent value("./CompileSystem.sh " + OS-GETENV("TEMP") + "/FelixSystemInfo.json").
        pause.
        quit.
    end method.
    
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
        os-delete value(ttSystemInfo.systemDBparameters + "/" + vSystem + ".lk") no-error.
    end method.
end class.