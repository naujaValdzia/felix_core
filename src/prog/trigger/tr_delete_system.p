trigger procedure for create of system.

for each file where 
         file.system = system.systemName:
    delete file.
end.

for each fieldDB where 
         fieldDB.system = system.systemName:
    delete fieldDB.
end.
