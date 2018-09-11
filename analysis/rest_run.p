for each unused where unused.systemName = "indigo":
    delete unused.
end.

define variable findUnused as class FindUnused no-undo.
findUnused = new FindUnused().
findUnused:getUnused().