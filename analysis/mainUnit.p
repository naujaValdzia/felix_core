



/*--------------- Get list of unused files ----------------- */

define variable findUnused as class FindUnused no-undo.
findUnused = new FindUnused().
findUnused:getUnused().

/*---------------------------------------------------------- */