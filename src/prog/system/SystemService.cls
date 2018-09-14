 
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
        find first system where
                   system.systemName = ttsystem.systemName no-error.
        if available system
        then do:
            undo.
        end.
        else do:
            create system.
            system.systemName = ttSystem.systemName.
            system.localSourcePath = ttSystem.localSourcePath.
            system.systemPropath = ttSystem.systemPropath.
            system.systemDBparameters = ttSystem.systemDBparameters.
            system.entryPoints = ttsystem.entryPoints.
            system.systemLocation = ttsystem.systemLocation.
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
        /*        sysName as character,           */
        /*        localSourcePath as character,   */
        /*        systemPropath as character,     */
        /*        systemDBparameters as character,*/
        /*        entryPoints as character,       */
        /*        systemLocation as character     */
        find first system where 
                   system.systemName = ttsystem.systemName.
        if available system
        then do:
            buffer-copy ttsystem except ttsystem.systemName to system.
/*                if ttsystem.localSourcePath <> ? and ttsystem.localSourcePath <> "" then      */
/*                system.localSourcePath = ttsystem.localSourcePath.                            */
/*                if ttsystem.systemPropath <> ? and ttsystem.systemPropath <> "" then          */
/*                system.systemPropath = ttsystem.systemPropath.                                */
/*                if ttsystem.systemDBparameters <> ? and ttsystem.systemDBparameters <> "" then*/
/*                system.systemDBparameters = ttsystem.systemDBparameters.                      */
/*                if ttsystem.entryPoints <> ? and ttsystem.entryPoints <> "" then              */
/*                system.entryPoints = ttsystem.entryPoints.                                    */
/*                if ttsystem.systemLocation <> ? and ttsystem.systemLocation <> "" then        */
/*                system.systemLocation = ttsystem.systemLocation.                              */
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