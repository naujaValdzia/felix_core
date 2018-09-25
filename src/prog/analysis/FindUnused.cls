 
 /*------------------------------------------------------------------------
    File        : FindUnused
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class FindUnused: 

    {tt/ttUsed.i}
    
    define variable vCompileUnit as character no-undo.
    define variable vSystem as character no-undo.
    define buffer bUsed for ttUsed.
    
    method public void getUnused ():
        define variable vEntryPoints as character format "x(100)" no-undo extent 100.
        
        vSystem = os-getenv("FELIX-SYSTEM-NAME").
        deleteOldUnused(vSystem).
        
        find first system where 
                   system.systemName = vSystem.
        
        if length(system.entryPoints) = r-index(system.entryPoints,",") 
        then system.entryPoints = substring(system.entryPoints,1,length(system.entryPoints) - 1).
        
        allFiles(vSystem).
        
        repeat i = 1 to num-entries(system.entryPoints, ",").
            vEntryPoints = entry(i,system.entryPoints,",").
            assignAsUsed(vEntryPoints[i],vSystem).
        end.   
          
        for each bUsed where 
                 bUsed.isUsed = false exclusive-lock:
            do:
                create unused.
                unused.compileUnit = bUsed.compileUnit.
                unused.fileName = bUsed.fileName.
                unused.type = bUsed.type.
                unused.systemName = bused.systemName.
                unused.info = bused.info.
            end.
        end.
    end.
    
    /*------------------------------------------------------------------------------
     Purpose: To assign files as "used"
     Notes: Recursion.
    ------------------------------------------------------------------------------*/
    method public void assignAsUsed (nextCompileUnit as character, vSystem as character):
        define buffer bfile for file.
        define buffer ufile for file.

        do:
            find first ufile where 
                       ufile.compileUnit matches ("*" + nextCompileUnit + "*") and
                       ufile.systemName = vSystem and
                       (ufile.type = "COMPILE" or
                       ufile.type = "INCLUDE") no-error.
            if available ufile
            then do:
                vCompileUnit = ufile.info. 
                for each bfile where 
                         (bFile.info <> vCompileUnit and
                         bFile.compileUnit = ufile.compileUnit and
                         bFile.systemName = vSystem and
                         ((index(bfile.info, ".p") <> 0) or
                         (index(bfile.info, ".cls") <> 0) or
                         (index(bfile.info, ".i") <> 0))):

                    find bUsed where 
                         bUsed.info = bFile.info no-error.
                    if not available bUsed
                    then do:
                        create bUsed.
                        bUsed.compileUnit = bfile.info.
                        bUsed.fileName = bfile.fileName.
                        bUsed.type = bFile.type.
                        bUsed.systemName = bFile.systemName.
                        bUsed.info = "***PROGRESS SYSTEM FILE***".
                        bUsed.isUsed = true.
                    end.
                    bUsed.isUsed = true.
                    assignAsUsed(bFile.info, vSystem).
                end.
            end.
        end.
    end method.

     /*------------------------------------------------------------------------------
     Purpose: To check if file exists in temp-table ttUsed. If not, - then create temp-table
              ttUsed and add value "false" to ttUsed field isUsed. Basically it adds all files 
              matching COMPILE and INCLUDE from desired system.
     Notes:   In some cases "info" field may be empty, it is caused by xref analysis.
              If xref consists of include which is separated by two spaces, like this: " yourInclude.i " it
              is importing "space" symbol to info field, because our import delimiter is space.
              Problem solved in importXref file.
    ------------------------------------------------------------------------------*/

    method public void allFiles (vSystem as character):
        for each file where 
                 file.systemName = vSystem and file.type = "INCLUDE":
        if available file
            then do:
                find first ttUsed where 
                           ttUsed.info = file.info no-error.
                if not available ttUsed
                then do:
                    create ttUsed.
                    ttUsed.compileUnit = file.compileUnit.
                    ttUsed.fileName = file.fileName.
                    ttUsed.type = file.type.
                    ttUsed.systemName = file.systemName.
                    ttUsed.info = file.info.
                    ttUsed.isUsed = false.

                    if file.info = "" 
                    then ttUsed.info = "PROBLEM WITH XREF, CHECK GRAMMAR. INCLUDE MAY BE SEPARATED BY TWO SPACES. .i".
                end.
            end.
        end.
        for each file where 
                 file.systemName = vSystem and file.type = "COMPILE":
        if available file
        then do:
            create ttUsed.
            ttUsed.compileUnit = file.compileUnit.
            ttUsed.fileName = file.fileName.
            ttUsed.type = file.type.
            ttUsed.systemName = file.systemName.
            ttUsed.info = file.info.
            ttUsed.isUsed = false.

            if file.info = "" 
            then ttUsed.info = "PROBLEM WITH XREF, CHECK GRAMMAR. INCLUDE MAY BE SEPARATED BY TWO SPACES. .i".
        end.
        end.
    end method.
    
    method public void deleteOldUnused (vSystem as character):
        for each unused where 
                 unused.systemName = vSystem:
            delete unused.    
        end.
    end method.
end class.