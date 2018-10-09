/*------------------------------------------------------------------------
    File        : FindErrors
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class FindErrors: 

    define variable cName as character no-undo.
    
    
    method public void checkErrors ():  
        cName = os-getenv("FELIX_SYSTEM_NAME").  
                                                                                                                   
        input from os-dir(os-getenv("TEMP") + "/" + cName).
        assign file-info:file-name = (os-getenv("TEMP") + "/" + cName + "/" + cName + ".txt").
        if file-info:file-type begins "F" and file-info:file-size <> 0
        then do:
            find first system where 
                       system.systemName = cName.
            system.hasErrors = true.
            readErrorList(cName).
        end.
        input close.
    end method.

    method public void readErrorList(cName as character):
        define variable lineFromFile as character.
        define variable fileLocation as character no-undo.
        define variable counter1 as integer no-undo.
        define variable counter2 as integer no-undo.
        define variable pathLine as character.
        define variable messageLine as character.
        
        deleteOldError(cName).

        fileLocation = (os-getenv("TEMP") + "/" + cName + "/" + cName + ".txt").

        input from value(fileLocation).
        repeat:
            import unformatted lineFromFile.
            counter2 = counter2 + 1.
            if counter1 mod 2 = 0
            then do:
                pathLine = replace(lineFromFile,"~\","/").
            end.
            else do:
                if index(lineFromFile,"*") <> 0 
                then lineFromFile = replace(lineFromFile,"*","").
                messageLine = replace(lineFromFile,"~\","/").
            end.
            if counter2 mod 2 = 0
            then do:
                create error.
                error.filePath = pathLine.
                error.errorMessage = messageLine.
                error.systemName = cName.
            end.
           counter1 = counter1 + 1.
        end.
        input close.
    end method.
    
    method public void deleteOldError(vSystem as character):
        for each error where 
                 error.systemName = vSystem:
             delete error.        
         end.
    end method.
end class.