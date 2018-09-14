 
 /*------------------------------------------------------------------------
    File        : fielddbService
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Wed Sep 05 15:45:56 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class FielddbService: 
    
    {ds/dsDbFieldFiltered.i}
    {ds/dsDbField.i}

    method public void findAccess (fieldName as character, 
                                  systemName as character, 
                                  output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "ACCESS" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findAccessDetails (compUnit as character, 
                                         fieldName as character, 
                                         systemName as character, 
                                         output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "ACCESS" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.
  
    method public void findUpdate (fieldName as character, 
                                  systemName as character, 
                                  output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "UPDATE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findUpdateDetails (compUnit as character, 
                                         fieldName as character, 
                                         systemName as character, 
                                         output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "UPDATE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.  
    
    method public void findDelete (fieldName as character, 
                                  systemName as character, 
                                  output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "DELETE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findDeleteDetails (compUnit as character, 
                                         fieldName as character, 
                                         systemName as character, 
                                         output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "DELETE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.

    method public void findReference (fieldName as character, 
                                     systemName as character, 
                                     output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "REFERENCE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findReferenceDetails (compUnit as character, 
                                            fieldName as character, 
                                            systemName as character, 
                                            output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "REFERENCE" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.

    method public void findIndex (fieldName as character, 
                                 systemName as character, 
                                 output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "INDEX" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findIndexDetails (compUnit as character, 
                                        fieldName as character, 
                                        systemName as character, 
                                        output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 fieldDB.type = "INDEX" and
                 fieldDB.info = fieldName 
                 by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.

    method public void findAllDbFields (fieldName as character, 
                                       systemName as character, 
                                       output dataset dsDbFieldFiltered):
        dataset dsDbFieldFiltered:empty-dataset().
        for each fieldDB no-lock where
                 fieldDB.system = systemName and
                 (fieldDB.type = "ACCESS" or
                 fieldDB.type = "REFERENCE" or
                 fieldDB.type = "DELETE" or
                 fieldDB.type = "UPDATE") and
                 (fieldDB.info matches("*~~." + fieldName) or
                 fieldDB.info = fieldName or
                 fieldDB.info matches ("*~~." + fieldName + ":*"))
                 by fieldDB.compileUnit:
                
            find first ttDbFieldFiltered where 
                       ttDbFieldFiltered.compileUnit = fieldDB.compileUnit no-error.
            if not available ttDbFieldFiltered
            then do:
                create ttDbFieldFiltered.
                ttDbFieldFiltered.compileUnit = fieldDB.compileUnit.
            end. 
        end.
        dataset dsDbFieldFiltered:accept-changes().
    end method.
    
    method public void findAllDbFieldsDetails (compUnit as character, 
                                              fieldName as character, 
                                              systemName as character, 
                                              output dataset dsDbField):
        dataset dsDbField:empty-dataset().
        for each fieldDB no-lock where
            fieldDB.system = systemName and
            (fieldDB.type = "ACCESS" or
            fieldDB.type = "REFERENCE" or
            fieldDB.type = "DELETE" or
            fieldDB.type = "UPDATE") and
            (fieldDB.info matches("*~~." + fieldName) or
            fieldDB.info = fieldName or
            fieldDB.info matches ("*~~." + fieldName + ":*"))
            by fieldDB.compileUnit:
                
            if compUnit = fielddb.compileUnit
            then do:
                create ttDbField.
                ttDbField.system = fieldDB.system.
                ttDbField.compileUnit = fieldDB.compileUnit.
                ttDbField.fileName = fieldDB.fileName.
                ttDbField.sourceName = fieldDB.sourceName.
                ttDbField.sourcePath = fieldDB.sourcePath.
                ttDbField.type = fieldDB.type.
                ttDbField.line = fieldDB.line.
                ttDbField.info = fieldDB.info.
            end.
        end.
        dataset dsDbField:accept-changes().
    end method.
end class.