{ds/dsSystem.i}
define variable systemService as class SystemService no-undo.
systemService = new SystemService().


/*systemService:fillDS(output dataset dssystem).*/
/*for each ttsystem:                            */
/*    display ttsystem.systemDBparameters.      */
/*end.                                          */
systemService:createSystem().