database = loadfile ("./libs/redis.lua")()
function CerNerTeam()
local i, t, popen = 0, {}, io.popen
local pfile = popen('ls')
local num = 0
for filename in pfile:lines() do
   if filename:match('tabchi%-(%d+)%.lua') and tonumber(filename:match('tabchi%-(%d+)%.lua')) >= num then
num = tonumber(filename:match('tabchi%-(%d+)%.lua')) + 1
end		
end
return num
end
local num = CerNerTeam()
io.write("Tabchi Number: "..num)
local text,ok = io.open("tabchi.lua",'r'):read('*a'):gsub("tabchi%-id",num)
io.open("tabchi-"..num..".lua",'w'):write(text):close()
io.open("tabchi-"..num..".sh",'w'):write("while true; do\n$(dirname $0)/tg -p tabchi-"..num.." -s tabchi-"..num..".lua\ndone"):close()
io.popen("chmod 777 tabchi-"..num..".sh")
print("\nDone Tabchi  "..num.." has Been Created \nRun : ./tabchi-"..num..".sh")
print("CerNer Team")