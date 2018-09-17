 
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
    
    method public void createSystem (dataset dsSystem,
                                     output vSuccess as logical,
                                     output vMessage as character):
        find ttSystem.
        find first system where
                   system.systemName = ttSystem.systemName no-error.
        if available system
        then do:
            vSuccess = false.
            vMessage = "System with with name " + ttsystem.systemName + "already exists. Please choose another one".
        end.
        else do:
            create system.
            system.systemName = ttSystem.systemName.
            system.localSourcePath = ttSystem.localSourcePath.
            system.systemPropath = ttSystem.systemPropath.
            system.systemDBparameters = ttSystem.systemDBparameters.
            system.entryPoints = ttSystem.entryPoints.
            system.systemLocation = ttSystem.systemLocation.
            vSuccess = true.
            vMessage = "System successfully created".
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
    
    method public void updateSystem (dataset dsSystem,
                                     output vSuccess as logical,
                                     output vMessage as character):
        for each ttSystem: 
            do on error undo, throw:
            find first system where 
                       system.systemName = ttSystem.systemName.
                       
            if available system
            then do:
                buffer-copy ttSystem except ttSystem.systemName ttSystem.id to system.
                vSuccess = true.
                vMessage = "System successfully updated".
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