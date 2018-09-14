 
 /*------------------------------------------------------------------------
    File        : FindErrors
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Thu Sep 13 17:07:00 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class FindErrors: 

    method public void checkErrors ():                                                                                                          
        input from os-dir(os-getenv("TEMP") + "/" + os-getenv("FELIX-SYSTEM-NAME")).
        assign file-info:file-name = (os-getenv("TEMP") + "/" + os-getenv("FELIX-SYSTEM-NAME") + "/" + os-getenv("FELIX-SYSTEM-NAME") + ".txt").
        if file-info:file-type begins "F" and file-info:file-size <> 0
        then do:
            find first system where 
                       system.systemName = os-getenv("FELIX-SYSTEM-NAME").
            system.hasErrors = yes.
            readErrorList().
        end.
        input close.
    end method.

    method public void readErrorList():
        define variable lineFromFile as character.
        define variable fileLocation as character no-undo.
        define variable counter1 as integer no-undo.
        define variable counter2 as integer no-undo.
        define variable pathLine as character.
        define variable messageLine as character.
        
        for each error where 
                 error.systemName = os-getenv("FELIX-SYSTEM-NAME"):
             delete error.        
         end.

        fileLocation = (os-getenv("TEMP") + "/" + os-getenv("FELIX-SYSTEM-NAME") + "/" + os-getenv("FELIX-SYSTEM-NAME") + ".txt").

        input from value(fileLocation).
        repeat:
            import unformatted lineFromFile.
            counter2 = counter2 + 1.
            if counter1 mod 2 = 0
            then do:
                pathLine = lineFromFile.
            end.
            else do:
                if index(lineFromFile,"*") <> 0 
                then lineFromFile = replace(lineFromFile,"*","").
                messageLine = lineFromFile.
            end.
            if counter2 mod 2 = 0
            then do:
                create error.
                error.filePath = pathLine.
                error.errorMessage = messageLine.
                error.systemName = os-getenv("FELIX-SYSTEM-NAME").
            end.
           counter1 = counter1 + 1.
        end.
        input close.
    end method.
end class.