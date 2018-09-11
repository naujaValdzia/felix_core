/*create system.               */
/*system.systemName = "kosmos".*/

/*define variable systemService as class SystemService no-undo.    */
/*systemService = new SystemService().                             */
/*                                                                 */
/*systemService:updateSystem("indigo",?,"fwef","wef","qef","qewf").*/
/*systemService:deleteSystem("indigo").*/

/*create error.                         */
/*    error.systemName = "indigo".      */
/*    error.filePath = "asdasd/asda/dd".*/
/*    error.errorMessage = "pranesimas".*/

create unused.
    unused.systemName = "indigo".
    unused.fileName = "procedura".
    unused.type = "RUN".
    unused.compileUnit = "asd".

create unused.
    unused.systemName = "indigo".
    unused.fileName = "includas".
    unused.type = "INCLUDE".
    unused.compileUnit = "asd".
    
create unused.
    unused.systemName = "indigo".
    unused.fileName = "klase".
    unused.type = "IMPLICIT INVOKE".
    unused.compileUnit = "asd".
/*for each error where error.systemName = "indigo":*/
/*    delete error.                                */
/*end.                                             */

/*{ds/dserror.i}                                             */
/*define variable errorService as class ErrorService no-undo.*/
/*errorService = new ErrorService().                         */
/*errorService:getError("indigo", output dataset dserror).   */
/*                                                           */
/*for each tterror:                                          */
/*    display tterror.filePath.                              */
/*end.                                                       */

/*{ds/dsunused.i}                                                     */
/*define variable unusedService as class UnusedService no-undo.       */
/*unusedService = new UnusedService().                                */
/*unusedService:getUnusedProcedure("indigo", output dataset dsunused).*/
/*                                                                    */
/*for each ttunused:                                                  */
/*    display ttunused.fileName.                                      */
/*end.                                                                */