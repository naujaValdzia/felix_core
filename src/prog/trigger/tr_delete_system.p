trigger procedure for create of system.

for each file where 
         file.system = system.systemName:
    delete file.
end.

for each dbField where 
         dbField.system = system.systemName:
    delete dbField.
end.

for each error where
         error.systemName = system.systemName:
    delete error.
end.

for each unused where
         unused.systemName = system.systemName:
    delete unused.
end.