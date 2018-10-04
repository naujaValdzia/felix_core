 
 /*------------------------------------------------------------------------
    File        : SystemService
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class SystemService: 
    
    {ds/dsSystem.i}
    
    method public void createSystem (dataset dsSystem,
                                     output vSuccess as logical,
                                     output vMessage as character):
        define buffer bSystem for system.
        find ttSystem.
        
        if ttSystem.systemName <> "" 
        then do:
            if index(ttSystem.systemPropath,";") <> 0 or
               index(ttSystem.entryPoints,";") <> 0 or
               index(ttSystem.systemDBparameters,";") <> 0 or
               index(ttSystem.localSourcePath,";") <> 0
            then do:
                ttSystem.systemPropath = replace(ttSystem.systemPropath,";",",").
                ttSystem.entryPoints = replace(ttSystem.entryPoints,";",",").
                ttSystem.systemDBparameters = replace(ttSystem.systemDBparameters,";",",").
                ttSystem.localSourcePath = replace(ttSystem.localSourcePath,";",",").
            end.
                
            find first bSystem where
                       bSystem.systemName = ttSystem.systemName no-error.
            if available bSystem
            then do:
                vSuccess = false.
                vMessage = "System with with name " + ttSystem.systemName + " already exists. Please choose another one".
            end.
            else do:
                create system.
                system.systemName = ttSystem.systemName.
                system.localSourcePath = replace(ttSystem.localSourcePath,"~\","/").
                system.systemPropath = replace(ttSystem.systemPropath,"~\","/").
                system.systemDBparameters = replace(ttSystem.systemDBparameters,"~\","/").
                system.entryPoints = replace(ttSystem.entryPoints,"~\","/").                
                vSuccess = true.
                vMessage = "System has been successfully created".
            end.
        end.
        else do:
            vSuccess = false.
            vMessage = "Unable to create system with no name. Please retry.".
        end.
    end method.
    
    method public void systemList (output dataset dsSystem):
        define buffer bSystem for system.
        dataset dsSystem:empty-dataset().
        
        for each bSystem:
            create ttSystem.
            ttSystem.systemName = bSystem.systemName.
            ttSystem.hasErrors = bSystem.hasErrors.
            ttSystem.id = bSystem.id.
        end.
        dataset dsSystem:accept-changes().
    end method.    
    
    method public void systemInfo (sysName as character, 
                                   output dataset dsSystem):
        define buffer bSystem for system.
        dataset dsSystem:empty-dataset().
        
        find first bSystem where 
                   bSystem.systemName = sysName.
            create ttSystem.
            ttSystem.systemName = bSystem.systemName.
            ttSystem.systemPropath = bSystem.systemPropath.
            ttSystem.systemDBparameters = bSystem.systemDBparameters.
            ttSystem.localSourcePath = bSystem.localSourcePath.
            ttSystem.hasErrors = bSystem.hasErrors.
            ttSystem.entryPoints = bSystem.entryPoints.
            ttSystem.id = bSystem.id.
        dataset dsSystem:accept-changes().
    end method.
    
    method public void updateSystem (dataset dsSystem,
                                     output vSuccess as logical,
                                     output vMessage as character):
        for each ttSystem: 
            do on error undo, throw:
            find first system where 
                       system.systemName = ttSystem.systemName.
                       
            if available system
            then do:
                buffer-copy ttSystem except ttSystem.systemName ttSystem.id ttSystem.hasErrors to system.
                if index(system.systemPropath,";") <> 0 or
                   index(system.entryPoints,";") <> 0 or
                   index(system.systemDBparameters,";") <> 0 or
                   index(system.localSourcePath,";") <> 0
                then do:
                    system.systemPropath = replace(system.systemPropath,";",",").
                    system.entryPoints = replace(system.entryPoints,";",",").
                    system.systemDBparameters = replace(system.systemDBparameters,";",",").
                    system.localSourcePath = replace(system.localSourcePath,";",",").
                end.
                vSuccess = true.
                vMessage = "System has been successfully updated".
            end.
            
            catch updateError as Progress.Lang.Error :
                vSuccess = false.
                vMessage = "Unable to find system with matching name".
            end catch.
            end.
        end.
    end method.

    method public void deleteSystem (sysName as character,
                                     output vSuccess as logical,
                                     output vMessage as character):
        find first system where 
                   system.systemName = sysName.
        if available system
        then do:
            delete system.
            vSuccess = true.
            vMessage = "System " + sysName + " has been deleted".
        end.
    end.
end class.