 
 /*------------------------------------------------------------------------
    File        : AnalysisUtility
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ppacevicius
    Created     : Tue Sep 11 13:44:22 EEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class AnalysisUtility: 
    method public character getNameFromPath (cPath as character):
        do while index (cPath, '/') > 0:
            cPath = substring(cPath, index(cPath, '/') + 1).
        end.
        if index (cPath, ":") > 0 
            then do:
                cPath = substring(cPath, 1, index(cPath, ":") - 1).
            end.
        do while num-entries(cPath, ".") > 1 and not 
                 (entry(2, cPath, ".") = "cls" or 
                 entry(2, cPath, ".") = "p" or 
                 entry(2, cPath, ".") = "i"):
            cPath = substring(cPath, index(cPath, ".") + 1).
        end.     
        return cPath.
    end method.
end class.