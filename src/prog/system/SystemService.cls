 
 /*------------------------------------------------------------------------
    File        : systemService
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Wed Sep 05 15:45:32 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
block-level on error undo, throw.

class SystemService: 
    
    {ds/dsSystem.i}
    
    method public void createSystem (dataset dsSystem):
        find ttSystem.
        find first system where
                   system.systemName = ttSystem.systemName no-error.
        if not available system
        then do:
            create system.
            system.systemName = ttSystem.systemName.
            system.localSourcePath = ttSystem.localSourcePath.
            system.systemPropath = ttSystem.systemPropath.
            system.systemDBparameters = ttSystem.systemDBparameters.
            system.entryPoints = ttSystem.entryPoints.
            system.systemLocation = ttSystem.systemLocation.
        end.
    end method.
    
    method public void systemList (output dataset dsSystem):
        dataset dsSystem:empty-dataset().
        for each system:
            create ttSystem.
            ttSystem.systemName = system.systemName.
            ttSystem.id = system.id.
        end.
        dataset dsSystem:accept-changes().
    end method.    
    
    method public void systemInfo (sysName as character, 
                                   output dataset dsSystem):
        dataset dsSystem:empty-dataset().
        find first system where 
                   system.systemName = sysName.
            create ttSystem.
            ttSystem.systemName = system.systemName.
            ttSystem.systemPropath = system.systemPropath.
            ttSystem.systemLocation = system.systemLocation.
            ttSystem.systemDBparameters = system.systemDBparameters.
            ttSystem.localSourcePath = system.localSourcePath.
            ttSystem.hasErrors = system.hasErrors.
            ttSystem.entryPoints = system.entryPoints.
            ttSystem.id = system.id.
        dataset dsSystem:accept-changes().
    end method.
    
    method public void updateSystem (dataset dsSystem):
        for each ttSystem: 
            find first system where 
                       system.systemName = ttSystem.systemName no-error.
            if available system
            then do:
                buffer-copy ttSystem except ttSystem.systemName ttSystem.id to system.
            end.
        end.
    end method.

    method public void deleteSystem (sysName as character):
        find first system where 
                   system.systemName = sysName.
        if available system
        then do:
            delete system.
        end.
    end.
end class.