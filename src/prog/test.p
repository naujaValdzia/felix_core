define variable cXrefInformation as character no-undo.
define variable cWholeLine as character no-undo init "dvssssssvvvvvvvvvvvvvvvvvvvvvls 25 INCLUDE indigo/src/ttAccOpCompList.i &visibility=protected &name=ttAccOpCompList".
define variable cXrefType as character no-undo init "INCLUDE".
//define variable cWholeLine as character no-undo init "/u1/env/bankcp/indigo/svn-trunk/system/acr/AcrGen.cls /u1/env/bankcp/indigo/svn-trunk/system/acr/AcrGen.cls 24 INCLUDE acr/ttAcrHis.i".
//define variable cWholeLine as character no-undo init "etupInfo.cls 26 INCLUDE setup/ttProdGrp.i visibility=protected &name=ttProdGrp".
if cXrefType = "INCLUDE"
then do:
    cXrefInformation = substring(cWholeLine, r-index(cWholeLine, "INCLUDE"), length(cWholeLine)).
    message cXrefInformation.
    cXrefInformation = replace(cXrefInformation,"INCLUDE","").
    message cXrefInformation.
    cXrefInformation = replace(cXrefInformation,"~"","").
    message cXrefInformation.
    cXrefInformation = replace(cXrefInformation," ","").
    message cXrefInformation.
    //if index(cXrefInformation, "&") <> 0
    //then do:
        cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ".i") + 1).
        message cXrefInformation.
    //end.
end.
else do:
    cXrefInformation = substring(cWholeLine, index(cWholeLine, " ") + 1).
    cXrefInformation = trim(cXrefInformation, "~"").
end.

/*for each unused where unused.type = "include" and unused.info matches ("*" + ".i") and unused.type <> "COMPILE":*/
/*    delete unused.                                                                                              */
/*end.                                                                                                            */
    
/*    then do: */
/*        undo.*/
/*    end.     */
