{ds/dsfile.i}
{ds/dsFileFiltered.i}
{ds/dstree.i}

define variable fileService as class FileService no-undo.
/*define variable treeDTO as class TreeDTO no-undo.                                    */
/*                                                                                     */
fileService = new FileService().
/*fileService:listIsUsing("stsutil.cls", "indigo", output dataset dsfile by-reference).*/
/*treeDTO = new TreeDTO().                                                             */
/*treeDTO:fromDomain(dataset dsfile, output dataset dstree by-reference).              */
/*                                                                                     */
/*for each ttTree:                                                                     */
/*    display ttTree.                                                                  */
/*end.                                                                                 */

/*define variable systemService as class SystemService no-undo.*/
/*systemService = new SystemService().                         */
/*systemService:deleteSystem("aa").                            */

fileService:findIncludeDetails("acr/AcrUtil.cls", "businessErr.i", "indigo", output dataset dsFile).
for each ttFile:
    display ttFile.compileUnit format "x(30)".
    display ttfile.line.
    display ttfile.type.
    display ttFile.sourcePath.
end.

/*fileService:findInclude("businessErr.i", "indigo", output dataset dsFileFiltered).*/
/*for each ttFileFiltered:                                                          */
/*    display ttFileFiltered.compileUnit format "x(50)".                            */
/*end.         */


            //class

                  