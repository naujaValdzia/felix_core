 
 /*------------------------------------------------------------------------
    File        : errorService
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Wed Sep 05 15:45:00 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class ErrorService: 
    {ds/dsError.i}
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
        
    constructor public ErrorService (  ):

    end constructor.
    
    method public void getError(sysName as character, 
                                output dataset dsError):
        dataset dsError:empty-dataset().
        for each error no-lock where error.systemName = sysName:
            create ttError.
            ttError.filePath = error.filePath.
            ttError.systemName = error.systemName.
            ttError.errorMessage = error.errorMessage.
            ttError.id = error.id.
        end.
        dataset dsError:accept-changes ().
    end method.    

end class.