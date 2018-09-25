 
 /*------------------------------------------------------------------------
    File        : ReadXref
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class ReadXref: 

    {tt/ttCompilerParameters.i}

    method public void waitForXrefs ():
        temp-table ttSystemInfo:read-json("file",os-getenv("TEMP") + "\FelixSystemInfo.json","empty").
        find ttSystemInfo.    
        readFromXrefDir(os-getenv("TEMP") + "\" + ttSystemInfo.systemName + "\", ttSystemInfo.systemName).
        os-delete value(os-getenv("JSON-LOCATION")).
    end method.

    method public void readFromXrefDir (cDir as character, 
                                        cSystem as character):
        define variable cFileStream as character no-undo format "x(200)".
        define variable cPath as character no-undo format "x(200)".

        deleteOldData(cSystem).
        
        input from os-dir(cDir).
        repeat:
            import cFileStream.
            if cFileStream matches "*.xref"
            then do:
                cPath = cDir + cFileStream.
                importXref(cPath,cSystem).
            end.
        end.
        input close.
    end method.

    method public void importXref(cPath as character, cSystem as character):
        define variable cWholeLine as character no-undo.
        define variable cSourceName as character no-undo.
        define variable cFileName as character no-undo.
        define variable cLineNumber as character no-undo.
        define variable cXrefType as character no-undo.
        define variable cXrefInformation as character no-undo.
        define variable cCompileUnit as character no-undo.
        define variable i as integer no-undo.
        define variable i2 as integer no-undo.
        define variable i3 as integer no-undo.
        define variable numEntriesCounter as integer no-undo.
        define variable cSourcePath as character no-undo.
        define variable temp as character no-undo. //used for temporary data
        
        if length(ttSystemInfo.systemPropath) = r-index(ttSystemInfo.systemPropath,",") 
        then ttSystemInfo.systemPropath = substring(ttSystemInfo.systemPropath,1,length(ttSystemInfo.systemPropath) - 1).

        input from value(cPath).
        repeat:
            import unformatted cWholeLine.
            cWholeLine = replace(cWholeLine,"\","/").
            cSourceName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cFileName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cLineNumber = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cXrefType = substring(cWholeLine, 1, index(cWholeLine, " ")).
            
            if cXrefType = "INCLUDE"
            then do:
                cXrefInformation = substring(cWholeLine, r-index(cWholeLine, "INCLUDE"), length(cWholeLine)).
                cXrefInformation = replace(cXrefInformation,"INCLUDE","").
                cXrefInformation = replace(cXrefInformation,"~"","").
                cXrefInformation = replace(cXrefInformation," ","").
                cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ".i") + 1).
            end.
            else do:
                cXrefInformation = substring(cWholeLine, index(cWholeLine, " ") + 1).
                cXrefInformation = trim(cXrefInformation, "~"").
            end.
                
            temp = cSourceName.
            repeat numEntriesCounter = 1 to num-entries(ttSystemInfo.systemPropath, ",").
                temp = replace(temp, replace(entry(numEntriesCounter,ttSystemInfo.systemPropath,",") + "/","\","/"), "").
            end.
            cSourcePath = temp.

            repeat i = 0 to num-entries(cFileName, "/"):
            end.
            repeat i2 = 0 to num-entries(cSourceName, "/"):
            end.

            if cXrefType = "RUN" or 
               cXrefType = "NEW" or 
               cXrefType = "INCLUDE" or 
               cXrefType = "COMPILE"
            then do:
                if index(cXrefInformation, " ") <> 0 or 
                   index(cXrefInformation, ",") <> 0
                then do:
                    cXrefInformation = entry (1, cXrefInformation, " ").
                    cXrefInformation = entry (1, cXrefInformation, ",").
                end.
                if cXrefType = "COMPILE"
                then do:
                    repeat numEntriesCounter = 1 to num-entries(ttSystemInfo.systemPropath, ",").
                        cXrefInformation = replace(cXrefInformation, replace(entry(numEntriesCounter,ttSystemInfo.systemPropath,",") + "/","\","/"), "").
                    end.  
                    cCompileUnit = cXrefInformation.
                end.
                create file.
                assign
                    file.fileName = entry(i - 1, cFileName, "/")
                    file.sourceName = entry(i2 - 1, cSourceName, "/")
                    file.sourcePath = cSourcePath
                    file.line = integer(cLineNumber)
                    file.type = cXrefType
                    file.info = cXrefInformation
                    file.compileUnit = cCompileUnit
                    file.systemName = cSystem.
            end.
            else if cXrefType = "CLASS" and (cXrefInformation matches ("*INHERITS*") or cXrefInformation matches ("*IMPLEMENTS*"))
            then do:
                if cXrefInformation matches ("*INHERITS*")
                then do:
                    cXrefInformation = substring(cXrefInformation, index(cXrefInformation, "INHERITS")).
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                else if cXrefInformation matches ("*IMPLEMENTS*")
                then do:
                    cXrefInformation = substring(cXrefInformation, index(cXrefInformation, "IMPLEMENTS")).
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                create file.
                assign
                    file.fileName = entry(i - 1, cFileName, "/")
                    file.sourceName = entry(i2 - 1, cSourceName, "/")
                    file.sourcePath = cSourcePath
                    file.line = integer(cLineNumber)
                    file.type = cXrefType
                    file.info = cXrefInformation
                    file.compileUnit = cCompileUnit
                    file.systemName = cSystem.
            end.
            else if cXrefType = "SEARCH"
            then do:
                cXrefInformation = replace(cXrefInformation,"DATA-MEMBER ","").
                cXrefInformation = replace(cXrefInformation,"INHERITED-DATA-MEMBER ","").
                cXrefInformation = replace(cXrefInformation," TEMPTABLE","").
                cXrefInformation = replace(cXrefInformation," WHOLE-INDEX","").
                cXrefInformation = replace(cXrefInformation," TABLE-SCAN","").
                cXrefInformation= trim(cXrefInformation).
                cXrefInformation = entry(2,cXrefInformation," ").

                create dbField.
                assign
                    dbField.fileName = entry(i - 1, cFileName, "/")
                    dbField.sourceName = entry(i2 - 1, cSourceName, "/")
                    dbField.sourcePath = cSourcePath
                    dbField.line = integer(cLineNumber)
                    dbField.type = "INDEX"
                    dbField.info = cXrefInformation
                    dbField.compileUnit = cCompileUnit
                    dbField.systemName = cSystem.
            end.
            else if cXrefType = "INVOKE"
            then do:
                if index(cXrefInformation, ",") <> 0
                then do:
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                if cLineNumber = "IMPLICIT"
                then do:
                    cLineNumber = "0".
                    cXrefType = "IMPLICIT " + cXrefType.
                end.
                create file.
                assign
                    file.fileName = entry(i - 1, cFileName, "/")
                    file.sourceName = entry(i2 - 1, cSourceName, "/")
                    file.sourcePath = cSourcePath
                    file.line = integer(cLineNumber)
                    file.type = cXrefType
                    file.info = cXrefInformation
                    file.compileUnit = cCompileUnit
                    file.systemName = cSystem.
            end.
            else if cXrefType = "ACCESS" or cXrefType = "UPDATE" or cXrefType = "REFERENCE" or cXrefType = "DELETE"
            then do:
                if index(cXrefInformation, "INHERITED") <> 0 or 
                   index(cXrefInformation, "PUBLIC") <> 0
                then do:
                    create file.
                    assign
                        file.fileName = entry(i - 1, cFileName, "/")
                        file.sourceName = entry(i2 - 1, cSourceName, "/")
                        file.sourcePath = cSourcePath
                        file.line = integer(cLineNumber)
                        file.type = cXrefType
                        file.info = cXrefInformation
                        file.compileUnit = cCompileUnit
                        file.systemName = cSystem.
                end.
                else if index(cXrefInformation, "TEMPTABLE") = 0 and
                        index(cXrefInformation, "SHARED") = 0 and
                        index(cXrefInformation, "DATA-MEMBER") = 0 and
                        index(cXrefInformation, "WORKFILE") = 0 and
                        index(cXrefInformation, "SEQUENCE") = 0 and
                        index(cXrefInformation, "PROPERTY") = 0
                then do:
                    cXrefInformation = trim(cXrefInformation).
                    if index(cXrefInformation, ".") <> 0
                    then cXrefInformation = substring(cXrefInformation, index(cXrefInformation,".") + 1).
                    cXrefInformation = replace(cXrefInformation," ",".").

                    create dbField.
                    assign
                        dbField.fileName = entry(i - 1, cFileName, "/")
                        dbField.sourceName = entry(i2 - 1, cSourceName, "/")
                        dbField.sourcePath = cSourcePath
                        dbField.line = integer(cLineNumber)
                        dbField.type = cXrefType
                        dbField.info = cXrefInformation
                        dbField.compileUnit = cCompileUnit
                        dbField.systemName = cSystem.
                end.
            end.
        end.
        input close.
    end method.
    
    method public void deleteOldData (vSystem as character):
        for each file where file.systemName = vSystem:
            delete file.
        end.
        for each dbField where dbField.systemName = vSystem:
            delete dbField.
        end.
    end method.
end class.