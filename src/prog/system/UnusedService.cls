 
 /*------------------------------------------------------------------------
    File        : unusedService
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Wed Sep 05 15:45:17 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class UnusedService: 

    {ds/dsUnused.i}

    method public void getUnusedProcedure(sysName as character, 
                                          output dataset dsUnused):
        dataset dsUnused:empty-dataset().
        for each unused no-lock where 
                 unused.systemName = sysName and 
                 unused.info matches ("*" + ".p"):
            create ttUnused.
            ttUnused.fileName = unused.fileName.
            ttUnused.type = unused.type.
            ttUnused.compileUnit = unused.compileUnit.
            ttUnused.systemName = unused.systemName.
            ttUnused.info = unused.info.
            ttUnused.id = unused.id.
        end.
        dataset dsUnused:accept-changes ().
    end method.    
    
    method public void getUnusedClass(sysName as character, 
                                      output dataset dsUnused):
        dataset dsUnused:empty-dataset().
        for each unused no-lock where 
                 unused.systemName = sysName and
                 unused.info matches ("*" + ".cls"):
            create ttUnused.
            ttUnused.fileName = unused.fileName.
            ttUnused.type = unused.type.
            ttUnused.compileUnit = unused.compileUnit.
            ttUnused.systemName = unused.systemName.
            ttUnused.info = unused.info.
            ttUnused.id = unused.id.
        end.
        dataset dsUnused:accept-changes ().
    end method.  
    
    method public void getUnusedInclude(sysName as character, 
                                        output dataset dsUnused):
        dataset dsUnused:empty-dataset().
        for each unused no-lock where 
                 unused.systemName = sysName and 
                 unused.type = "INCLUDE":
            create ttUnused.
            ttUnused.fileName = unused.fileName.
            ttUnused.type = unused.type.
            ttUnused.compileUnit = unused.compileUnit.
            ttUnused.systemName = unused.systemName.
            ttUnused.info = unused.info.
            ttUnused.id = unused.id.
        end.
        dataset dsUnused:accept-changes ().
    end method.  
    
    method public void getUnusedAll(sysName as character, 
                                    output dataset dsUnused):
        dataset dsUnused:empty-dataset().
        for each unused no-lock where 
                 unused.systemName = sysName:
            create ttUnused.
            ttUnused.fileName = unused.fileName.
            ttUnused.type = unused.type.
            ttUnused.compileUnit = unused.compileUnit.
            ttUnused.systemName = unused.systemName.
            ttUnused.info = unused.info.
            ttUnused.id = unused.id.
        end.
        dataset dsUnused:accept-changes ().
    end method.  
end class.