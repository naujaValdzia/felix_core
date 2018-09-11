 
 /*------------------------------------------------------------------------
    File        : fileService
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Wed Sep 05 15:44:24 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class FileService:

    {ds/dsFile.i}
    {ds/dsTree.i}
    {ds/dsFileFiltered.i}
    
    constructor public FileService ():
 
    end constructor.
    
    method public void listIsUsing (usingName as character, 
                                   usingSystem as character,
                                   output dataset dsFile):
        dataset dsFile:empty-dataset().
        usingName = replace(usingName,".cls","").
        for each file no-lock where 
                            (file.compileunit matches ("*/" + usingName) or
                            file.compileunit matches ("*/" + usingName + "~~.*")) and
                            (file.type = "RUN" or
                            file.type = "INCLUDE" or
                            file.type = "NEW" or 
                            file.type = "CLASS" or 
                            file.type = "INVOKE" or 
                            file.type = "IMPLICIT INVOKE") and
                            file.system = usingSystem
                            by file.info:
                        find first ttfile where FileUtility:getNameFromPath(file.info) = ttfile.fileName no-error.
                        if not available ttFile
                        then do:
                            create ttFile.
                            ttFile.fileName = FileUtility:getNameFromPath(file.info).
                            ttFile.type = file.type.
                        end. 
        end.
        dataset dsfile:accept-changes ().
    end method.   

    method public void listUsedBy (usedName as character, 
                                  usedSystem as character, 
                                  output dataset dsFile):
        dataset dsFile:empty-dataset().
        usedName = replace(usedName,".cls","").
        for each file no-lock where 
                 file.system = usedSystem and
                       ( (file.type = "NEW" or 
                         file.type = "CLASS" or 
                         file.type = "INVOKE" or 
                         file.type = "IMPLICIT INVOKE" or 
                         file.type = "ACCESS" or 
                         file.type = "UPDATE") and
                         (file.info matches("*~~." + usedName) or
                         file.info = usedName or
                         file.info matches ("*~~." + usedName + ":*"))
                         or
                         (file.type = "RUN" and
                         (file.info matches("*/" + usedName) or
                         file.info matches("*/" + usedName + ".p") or
                         file.info = usedName or
                         file.info matches (usedName + ".p")))
                         or
                         (file.type = "INCLUDE" and 
                         (file.info matches ("*/" + usedName) or
                         file.info matches("*/" + usedName + ".i") or
                         file.info = usedName or
                         file.info matches(usedName + ".i")))
                       )
                         by file.compileUnit:
                            create ttfile.
                            ttfile.fileName = FileUtility:getNameFromPath(file.compileUnit).
                            ttfile.info = file.info.
                            ttfile.type = file.type.
        end.
        dataset dsfile:accept-changes().
    end method.
    
    method public void findProcedure (itemName as character, 
                                     systemName as character, 
                                     output dataset dsFileFiltered):
        dataset dsFileFiltered:empty-dataset().
        itemName = replace(itemName,".p","").
        for each file no-lock where
            file.system = systemName and
            file.type = "RUN" and
            (file.info matches("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.p") or
            file.info = itemName or
            file.info matches (itemName + "~~.p")) 
            by file.compileUnit:
            do:
                find first ttFileFiltered where 
                    ttFileFiltered.compileUnit = file.compileUnit no-error.
                if not available ttFileFiltered
                then do:
                    create ttFileFiltered.
                    ttFileFiltered.compileUnit = file.compileUnit.
                end.
            end.
        end.
        dataset dsFileFiltered:accept-changes().
    end method.
    
    method public void findProcedureDetails (compUnit as character, itemName as character, 
                                            systemName as character, 
                                            output dataset dsFile):
        dataset dsFile:empty-dataset().
        itemName = replace(itemName,".p","").
        for each file no-lock where
            file.system = systemName and
            file.type = "RUN" and
            (file.info matches("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.p") or
            file.info = itemName or
            file.info matches (itemName + "~~.p"))
            by file.compileUnit:
                
            if compUnit = file.compileUnit 
                then do:
                    create ttFile.
                    ttFile.system = file.system.
                    ttFile.compileUnit = file.compileUnit.
                    ttFile.fileName = file.fileName.
                    ttFile.sourceName = file.sourceName.
                    ttFile.sourcePath = file.sourcePath.
                    ttFile.type = file.type.
                    ttFile.line = file.line.
                    ttFile.info = file.info.
                end.
        end.
        dataset dsFile:accept-changes().
    end method.
    
    method public void findClass (itemName as character, 
                                 systemName as character, 
                                 output dataset dsFileFiltered):
    dataset dsFileFiltered:empty-dataset().
    itemName = replace(itemName,".cls","").
    for each file no-lock where 
        file.system = systemName and
        (file.type = "NEW" or 
        file.type = "CLASS" or 
        file.type = "INVOKE" or 
        file.type = "IMPLICIT INVOKE" or 
        file.type = "ACCESS" or 
        file.type = "UPDATE") and
        (file.info matches("*~~." + itemName) or
        file.info = itemName or
        file.info matches ("*~~." + itemName + ":*"))
        by file.compileUnit:              
            do:
                find first ttFileFiltered where 
                    ttFileFiltered.compileUnit = file.compileUnit no-error.
                if not available ttFileFiltered
                then do:
                    create ttFileFiltered.
                    ttFileFiltered.compileUnit = file.compileUnit.
                end.
            end.
    end.
    dataset dsFileFiltered:accept-changes().
    end method.
    
    method public void findClassDetails (compUnit as character, itemName as character, 
                                        systemName as character, 
                                        output dataset dsFile):
    dataset dsFile:empty-dataset().
    itemName = replace(itemName,".cls","").
    for each file no-lock where 
        file.system = systemName and
        (file.type = "NEW" or 
        file.type = "CLASS" or 
        file.type = "INVOKE" or 
        file.type = "IMPLICIT INVOKE" or 
        file.type = "ACCESS" or 
        file.type = "UPDATE") and
        (file.info matches("*~~." + itemName) or
        file.info = itemName or
        file.info matches ("*~~." + itemName + ":*"))
        by file.compileUnit:              

        if compUnit = file.compileUnit 
            then do:
                create ttFile.
                ttFile.system = file.system.
                ttFile.compileUnit = file.compileUnit.
                ttFile.fileName = file.fileName.
                ttFile.sourceName = file.sourceName.
                ttFile.sourcePath = file.sourcePath.
                ttFile.type = file.type.
                ttFile.line = file.line.
                ttFile.info = file.info.
            end.
    end.
    dataset dsFile:accept-changes(). 
    end method.
    
    method public void findInclude (itemName as character, 
                                   systemName as character, 
                                   output dataset dsFileFiltered):
        dataset dsFileFiltered:empty-dataset().
        itemName = replace(itemName,".i","").
        for each file no-lock where 

            file.type = "INCLUDE" and 
            file.system = systemName and
            (file.info matches ("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.i") or
            file.info = itemName or
            file.info matches(itemName + "~~.i"))
            by file.compileUnit:
                do:
                    find first ttFileFiltered where 
                        ttFileFiltered.compileUnit = file.compileUnit no-error.
                    if not available ttFileFiltered
                    then do:
                        create ttFileFiltered.
                        ttFileFiltered.compileUnit = file.compileUnit.
                    end.
                end.
        end.
        dataset dsFileFiltered:accept-changes(). 
    end method.

    method public void findIncludeDetails (compUnit as character, itemName as character, 
                                          systemName as character, 
                                          output dataset dsFile):
        dataset dsFile:empty-dataset().
        itemName = replace(itemName,".i","").
        for each file no-lock where 
            file.type = "INCLUDE" and 
            file.system = systemName and
            (file.info matches ("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.i") or
            file.info = itemName or
            file.info matches(itemName + "~~.i"))
            by file.compileUnit:
                
            if compUnit = file.compileUnit 
                then do:
                    create ttFile.
                    ttFile.system = file.system.
                    ttFile.compileUnit = file.compileUnit.
                    ttFile.fileName = file.fileName.
                    ttFile.sourceName = file.sourceName.
                    ttFile.sourcePath = file.sourcePath.
                    ttFile.type = file.type.
                    ttFile.line = file.line.
                    ttFile.info = file.info.
                end.
        end.
        dataset dsFile:accept-changes(). 
    end method.

    method public void findAllFiles (itemName as character, 
                               systemName as character, 
                               output dataset dsFileFiltered):
                                   
        dataset dsFileFiltered:empty-dataset().
        itemName = replace(itemName,".p","").
        itemName = replace(itemName,".cls","").
        itemName = replace(itemName,".i","").
        
        for each file no-lock where 
            file.system = systemName and //determine system
            ((file.type = "RUN" and
            (file.info matches("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.p") or
            file.info = itemName or
            file.info matches (itemName + "~~.p"))) or //end of procedures search
            ((file.type = "NEW" or 
            file.type = "CLASS" or 
            file.type = "INVOKE" or 
            file.type = "IMPLICIT INVOKE" or 
            file.type = "ACCESS" or 
            file.type = "UPDATE") and
            (file.info matches("*~~." + itemName) or
            file.info = itemName or
            file.info matches ("*~~." + itemName + ":*"))) or //end of classes search
            (file.type = "INCLUDE" and 
            (file.info matches ("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.i") or
            file.info = itemName or
            file.info matches(itemName + "~~.i")))) //end of includes search
            by file.compileUnit:
                do:
                    find first ttFileFiltered where 
                        ttFileFiltered.compileUnit = file.compileUnit no-error.
                    if not available ttFileFiltered
                    then do:
                        create ttFileFiltered.
                        ttFileFiltered.compileUnit = file.compileUnit.
                    end.
                end.
        end.
        dataset dsFileFiltered:accept-changes(). 
    end method.

    method public void findAllFilesDetails (compUnit as character, itemName as character, 
                                           systemName as character, 
                                           output dataset dsFile):
                                               
        dataset dsFile:empty-dataset().
        itemName = replace(itemName,".p","").
        itemName = replace(itemName,".cls","").
        itemName = replace(itemName,".i","").
        
        for each file no-lock where 
            file.system = systemName and //determine system
            ((file.type = "RUN" and
            (file.info matches("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.p") or
            file.info = itemName or
            file.info matches (itemName + "~~.p"))) or //end of procedures search
            ((file.type = "NEW" or 
            file.type = "CLASS" or 
            file.type = "INVOKE" or 
            file.type = "IMPLICIT INVOKE" or 
            file.type = "ACCESS" or 
            file.type = "UPDATE") and
            (file.info matches("*~~." + itemName) or
            file.info = itemName or
            file.info matches ("*~~." + itemName + ":*"))) or //end of classes search
            (file.type = "INCLUDE" and 
            (file.info matches ("*/" + itemName) or
            file.info matches("*/" + itemName + "~~.i") or
            file.info = itemName or
            file.info matches(itemName + "~~.i")))) //end of includes search
            by file.compileUnit:
                
            if compUnit = file.compileUnit 
                then do:
                    create ttFile.
                    ttFile.system = file.system.
                    ttFile.compileUnit = file.compileUnit.
                    ttFile.fileName = file.fileName.
                    ttFile.sourceName = file.sourceName.
                    ttFile.sourcePath = file.sourcePath.
                    ttFile.type = file.type.
                    ttFile.line = file.line.
                    ttFile.info = file.info.
                end.
        end.
        dataset dsFile:accept-changes(). 
    end method.
end class.