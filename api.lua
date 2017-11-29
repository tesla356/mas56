#start Project Api Tab V5
tabchi = dofile('./funcation.lua')
http = require('socket.http')
https = require('ssl.https')
URL = require('socket.url')
json = dofile("./libs/JSON.lua")
serpent = (loadfile "./libs/serpent.lua")()
-------------------------------
database = dofile('./libs/redis.lua')
-------------------------------
api_id = 406039147
local base_api = "https://maps.googleapis.com/maps/api"

config_sudo = {366831302}
-------------------------------
function is_fulsudo(msg)
  local var = false
  for v,user in pairs(config_sudo) do
    if user == msg.sender_user_id_ then
      var = true
    end
  end
  return var
end
function is_sudo(msg)
  local var = false
 for v,user in pairs(config_sudo) do
    if user == msg.sender_user_id_ then
      var = true
    end
  end
  if database:sismember("bothelpsudo", msg.sender_user_id_) then
    var = true
  end
  return var
end

----------------------------------
function dl_cb (arg, data)
	-- vardump(data)
end
----------------------------------
function vardump(value, depth, key)
  local linePrefix = ''
  local spaces = ''

  if key ~= nil then
    linePrefix = key .. ' = '
  end

  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    for i=1, depth do 
      spaces = spaces .. '  '
    end
  end

  if type(value) == 'table' then
    mTable = getmetatable(value)
    if mTable == nil then
      print(spaces .. linePrefix .. '(table) ')
    else
      print(spaces .. '(metatable) ')
        value = mTable
    end
    for tableKey, tableValue in pairs(value) do
      vardump(tableValue, depth, tableKey)
    end
  elseif type(value)  == 'function' or 
    type(value) == 'thread' or 
    type(value) == 'userdata' or 
    value == nil then 
      print(spaces .. tostring(value))
  elseif type(value)  == 'string' then
    print(spaces .. linePrefix .. '"' .. tostring(value) .. '",')
  else
    print(spaces .. linePrefix .. tostring(value) .. ',')
  end
end
function bot_updates(offset)
	local url = send_api.."/getUpdates?timeout=10"
	if offset then
		url = url.."&offset="..offset
	end
	return send_req(url)
end
function exi_file(path, suffix)
    local files = {}
    local pth = tostring(path)
	local psv = tostring(suffix)
    for k, v in pairs(scandir(pth)) do
        if (v:match('.'..psv..'$')) then
            table.insert(files, v)
        end
    end
    return files
end
--------------------------------
function file_exi(name, path, suffix)
	local fname = tostring(name)
	local pth = tostring(path)
	local psv = tostring(suffix)
    for k,v in pairs(exi_file(pth, psv)) do
        if fname == v then
            return true
        end
    end
    return false
end
function serialize_to_file(data, file, uglify)
  file = io.open(file, 'w+')
  local serialized
  if not uglify then
    serialized = serpent.block(data, {
        comment = false,
        name = '_'
      })
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end
function string.random(length)
   local str = "";
   for i = 1, length do
      math.random(97, 122)
      str = str..string.char(math.random(97, 122));
   end
   return str;
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

-- DEPRECATED
function string.trim(s)
  print("string.trim(s) is DEPRECATED use string:trim() instead")
  return s:gsub("^%s*(.-)%s*$", "%1")
end

-- Removes spaces
function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end

function get_http_file_name(url, headers)
  -- Eg: foo.var
  local file_name = url:match("[^%w]+([%.%w]+)$")
  -- Any delimited alphanumeric on the url
  file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
  -- Random name, hope content-type works
  file_name = file_name or str:random(5)

  local content_type = headers["content-type"]

  local extension = nil
  if content_type then
    extension = mimetype.get_mime_extension(content_type)
  end
  if extension then
    file_name = file_name.."."..extension
  end

  local disposition = headers["content-disposition"]
  if disposition then
    -- attachment; filename=CodeCogsEqn.png
    file_name = disposition:match('filename=([^;]+)') or file_name
  end

  return file_name
end
function load_data(filename)
	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = json.decode(s)
	return data
end
function save_data(filename, data)
	local s = json.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()
end
--  Saves file to /tmp/. If file_name isn't provided,
-- will get the text after the last "/" for filename
-- and content-type for extension
function download_to_file(url, file_name)
  print("url to download: "..url)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil

  if url:starts('https') then
    options.redirect = false
    response = {https.request(options)}
  else
    response = {http.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_name = file_name or get_http_file_name(url, headers)

  local file_path = "data/"..file_name
  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function run_command(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end
function string:isempty()
  return self == nil or self == ''
end

-- Returns true if the string is blank
function string:isblank()
  self = self:trim()
  return self:isempty()
end

-- DEPRECATED!!!!!
function string.starts(String, Start)
  print("string.starts(String, Start) is DEPRECATED use string:starts(text) instead")
  return Start == string.sub(String,1,string.len(Start))
end

-- Returns true if String starts with Start
function string:starts(text)
  return text == string.sub(self,1,string.len(text))
end
function unescape_html(str)
  local map = {
    ["lt"]  = "<",
    ["gt"]  = ">",
    ["amp"] = "&",
    ["quot"] = '"',
    ["apos"] = "'"
  }
  new = string.gsub(str, '(&(#?x?)([%d%a]+);)', function(orig, n, s)
    var = map[s] or n == "#" and string.char(s)
    var = var or n == "#x" and string.char(tonumber(s,16))
    var = var or orig
    return var
  end)
  return new
end
function check_markdown(text) --markdown escape ( when you need to escape markdown , use it like : check_markdown('your text')
		str = text
		if str:match('_') then
			output = str:gsub('_',[[\_]])
		elseif str:match('*') then
			output = str:gsub('*','\\*')
		elseif str:match('`') then
			output = str:gsub('`','\\`')
		else
			output = str
		end
	return output
end
function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -a "'..directory..'"'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

 function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
 function get_staticmap(area)
	local api = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
 
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
function sendinline(chat_id_,text,keyboard)
local bot = 'Token'
local url = 'https://api.telegram.org/bot'..bot
if keyboard then

tokens = url .. '/sendMessage?chat_id=' ..chat_id_.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard))
else
tokens = url .. '/sendMessage?chat_id=' ..chat_id_.. '&text=' ..URL.escape(text)..'&parse_mode=html'
end
https.request(tokens)
end
---------------------------------
 function showedit(msg,data)
         if msg then
  tabchi.viewMessages(msg.chat_id_, {[0] = msg.id_})
      if msg.send_state_.ID == "MessageIsSuccessfullySent" then
      return false 
      end 
----------------------------------
------------Chat Type------------
function is_supergroup(msg)
  chat_id_ = tostring(msg.chat_id_)
  if chat_id_:match('^-100') then 
    if not msg.is_post_ then
    return true
    end
  else
    return false
  end
end

function is_channel(msg)
  chat_id_ = tostring(msg.chat_id_)
  if chat_id_:match('^-100') then 
  if msg.is_post_ then -- message is a channel post
    return true
  else
    return false
  end
  end
end

function is_group(msg)
  chat_id_ = tostring(msg.chat_id_)
  if chat_id_:match('^-100') then 
    return false
  elseif chat_id_:match('^-') then
    return true
  else
    return false
  end
end

function is_private(msg)
  chat_id_ = tostring(msg.chat_id_)
  if chat_id_:match('^-') then
    return false
  else
    return true
  end
end
function check_markdown(text)
		str = text
		if str:match('_') then
			output = str:gsub('_',[[\_]])
		elseif str:match('*') then
			output = str:gsub('*','\\*')
		elseif str:match('`') then
			output = str:gsub('`','\\`')
		else
			output = str
		end
	return output
end
-------------MSG MATCHES------------
local text = msg.content_.text_
--------------MSG TYPE----------------
 if msg.content_.ID == "MessageText" then
         print("This is [ TEXT ]")
      msg_type = 'text'
    end
-------------------------------------
if is_fulsudo(msg) then
if text and text:match('^setsudo (%d+)') then
  local b = text:match('^setsudo (%d+)')
  database:sadd('bothelpsudo',b)
     tabchi.sendText(msg.chat_id_, msg.id_, 1, '`'..b..'` *Added From Help Sudo*', 1, 'md')
end
if text and text:match('^remsudo (%d+)') then
  local b = text:match('^remsudo (%d+)')
  database:srem('bothelpsudo',b)
     tabchi.sendText(msg.chat_id_, msg.id_, 1, '`'..b..'` *Removed From Help Sudo*', 1, 'md')
end
if text == 'sudolist' then
local hash =  "bothelpsudo"
          local list = database:smembers(hash)
          local t = '*Sudo list: *\n'
          for k,v in pairs(list) do
   local user_info = database:hgetall('user:'..v)
              if user_info and user_info.username then
                local username = user_info.username
                t = t..k.." - @"..username.." ["..v.."]\n"
              else
                t = t..k.." - "..v.."\n"
              end
            end
          t = t..'\nCerNer Team'
          if #list == 0 then
          t = '*No Sudo*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end
end

if is_sudo(msg) then
if text and text:match("^(pm) (%d+) (.*)") then

      local matches = {
        text:match("^(pm) (%d+) (.*)")
      }
      if #matches == 3 then
        tabchi.sendText((matches[2]), 0, 1, matches[3], 1, "html")
                    print("Tabchi [ Message ]")
 
  tabchi.sendText(msg.chat_id_, msg.id_, 1, '*Send!*', 1, 'md')
      end
end
--------------------------------------
if text and text:match('^setpm (%d+)$') then
database:set('pmmax',text:match('setpm (.*)'))
tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Pm Has Been Set To: *`'..text:match('setpm (.*)')..'`', 1, 'md')
end
end
--------------------------------------
local fun = (database:get('fun') or 'no') 
    if fun == 'yes' then
if text == '/start' then
local text = [[سلام ممنون که منو استارت کردی :) 
میدونی من چیکار میتونم بکنم  ؟
من یه ربات سرگرم کننده هستم  میتونم 
من میتونم جک بگم خخخخخ
مثلا : joke
میتونم اذان شهرتو بگم
azan ینقاق
میتونم ساعتو بگم
time
@CerNer_Tm
]]
local keyboard = {
inline_keyboard = {
{

{text="به کانال ما بپیوندید",url="https://telegram.me/CerNer_TM"}

}
}
}
 sendinline(msg.chat_id_,text,keyboard)
end
 if msg.content_.ID == "MessageChatAddMembers" and msg.content_.id_ == 406039147 then
        if database:get('welcome') then
        t =  database:get('welcome') 
        else
        t = [[ سلام  ممنون ک منو به گروه اوردی
میدونی من چیکار میتونم بکنم  ؟
من یه ربات سرگرم کننده هستم  میتونم 
من میتونم جک بگم خخخخخ
مثلا : joke
میتونم اذان شهرتو بگم
azan ینقاق
میتونم ساعتو بگم
time
@CerNer_Tm]]
        end
       tabchi.sendText(msg.chat_id_, msg.id_, 1, t,0)
          end
   
      if text == 'time' then
local url , res = http.request('http://probot.000webhostapp.com/api/time.php/')
  if res ~= 200 then return tabchi.sendText(msg.chat_id_, msg.id_, 1, '*No Connection*', 1, 'md') end
  local jdat = json:decode(url)
   if jdat.L == "0" then
   jdat_L = 'خیر'
   elseif jdat.L == "1" then
   jdat_L = 'بله'
   end
local jdat = json:decode(url)
  local text = 'ساعت : `'..jdat.Stime..'`\n\nتاریخ : `'..jdat.FAdate..'`\n\nتعداد روز های ماه جاری : `'..jdat.t..'`\n\nعدد روز در هفته : `'..jdat.w..'`\n\nشماره ی این هفته در سال : `'..jdat.W..'`\n\nنام باستانی ماه : `'..jdat.p..'`\n\nشماره ی ماه از سال : `'..jdat.n..'`\n\nنام فصل : `'..jdat.f..'`\n\nشماره ی فصل از سال : `'..jdat.b..'`\n\nتعداد روز های گذشته از سال : `'..jdat.z..'`\n\nدر صد گذشته از سال : `'..jdat.K..'`\n\nتعداد روز های باقیمانده از سال : <code>'..jdat.Q..'`\n\nدر صد باقیمانده از سال : `'..jdat.k..'`\n\nنام حیوانی سال : `'..jdat.q..'`\n\nشماره ی قرن هجری شمسی : `'..jdat.C..'`\n\nسال کبیسه : `'..jdat_L..'`\n\nمنطقه ی زمانی تنظیم شده : <code>'..jdat.e..'`\n\nاختلاف ساعت جهانی : `'..jdat.P..'`\n\nاختلاف ساعت جهانی به ثانیه : `'..jdat.A..'`\n'
local keyboard = {
inline_keyboard = {
{

{text="به کانال ما بپیوندید",url="https://telegram.me/CerNer_TM"}

}
}
}
 sendinline(msg.chat_id_,text,keyboard)
end

if text == 'joke' then
local database = 'http://vip.opload.ir/vipdl/94/11/amirhmz/'
	local res = http.request(database.."joke.db")
	local joke = res:split(",")
local keyboard = {
inline_keyboard = {
{

{text="به کانال ما بپیوندید",url="https://telegram.me/CerNer_TM"}

}
}
}
 sendinline(msg.chat_id_,joke[math.random(#joke)],keyboard)
end

    if text and text:match('^azan +(.*)') then
        local w = text:match('^azan +(.*)') 
			city = w
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'شهر: '..city
		text = text..'\nاذان صبح: '..data.Fajr
		text = text..'\nطلوع آفتاب: '..data.Sunrise
		text = text..'\nاذان ظهر: '..data.Dhuhr
		text = text..'\nغروب آفتاب: '..data.Sunset
		text = text..'\nاذان مغرب: '..data.Maghrib
		text = text..'\nعشاء : '..data.Isha
		text = text..'\n@CerNer_Tm\n'
local keyboard = {
inline_keyboard = {
{

{text="به کانال ما بپیوندید",url="https://telegram.me/CerNer_TM"}

}
}
}
 sendinline(msg.chat_id_,text,keyboard)
end
end
if is_sudo(msg) then
   if text == 'reload' then
 dofile('./funcation.lua')
 dofile('./api.lua')
tabchi.sendText(msg.chat_id_,msg.id_,1,'*Tabchi Api BOT Reloaded*',1,'md')
end
--------------------------------------
if text == 'panel' then
local gps = database:scard("asgp") or 0
local user = database:scard("ausers")
local gp = database:scard("agp") or 0
local allmsg = database:get("aallmsg") or 0
		local keyboard = {
inline_keyboard = {
{

{text = ''..allmsg..'', callback_data = 'CerNer Team'},{text = 'تعداد کل پیام ها >', callback_data = 'CerNer Team'}
},{
{text = ''..gps..'', callback_data = 'CerNer Team'},{text = 'سوپر گروه ها  >', callback_data = 'CerNer Team'}
},{
{text = ''..gp..'', callback_data = 'CerNer Team'},{text = 'گروه ها > ', callback_data = 'CerNer Team'}
},{
{text = ''..user..'', callback_data = 'CerNer Team'},{text = 'کاربران >', callback_data = 'CerNer Team'}
},{
{text="به کانال ما بپیوندید",url="https://telegram.me/CerNer_TM"}

}
}
}
 sendinline(msg.chat_id_,'امار تبلیغ گر پیشرفته API ساخته شده توسط کرنرتیم',keyboard)
end
if text and text:match('^deltabchi (%d+)') then
          local id = text:match('deltabchi (%d+)')
     run_bash("rm -rf ~/.telegram-cli/tabchi-"..id.."")
     run_bash("rm -rf ~/tabchi-"..id..".sh")
     run_bash("rm -rf ~/tabchi-"..id..".lua")


       tabchi.sendText(msg.chat_id_, msg.id_, 1, 'تبلیغ گر شماره '..id..' *حذف شد*', 1, 'md')

   end
 if text and text:match('^setadd (.*)') then
          local welcome = text:match('^setadd (.*)')
          database:set('welcome',welcome)
          local t = '*Added MsG Saved!*\n_In MSG:_\n`'..welcome..'`'
          tabchi.sendText(msg.chat_id_, msg.id_, 1, check_markdown(t), 1, 'md')

          end
if text == 'reset' then
database:del("asgp")
database:del("ausers")
database:del("agp")
 database:del("aallmsg")
 local text = 'Done'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
if text == 'help' then
local text = [[
راهنمای کار با سورس (API)

mod staus 
حات ربات
setmod fun
حالت ربات به  فان تغییر کرد
mod disable
غیرفعال کردن حلت (ساده)
 deltabchi num
حذف تبلیغ گر مورد نظر
setsudo id
افزودن سودو 
remsudo id 
عزل از مقام سودو
panel 
آمار ربات تبلیغ گر (api)
bc sgp
ارسال پیام به تمام سوپر گروه ها
bc gp
ارسا پیام به تمام گروه ها
bc user 
ارسال پیام به تمام کاربران (pv)
-------
fwd sgp
فروارد به تمام سوپرگروه ها 
fwd gp 
فروارد به تمام گروه ها 
fwd user
فروارد به تمام کاربران  
reload
بازنگری پلاگین ها
------
قدرت گرفته از کرنرتیم
@CerNer_Tm
]]
       tabchi.sendText(msg.chat_id_, msg.id_, 1, check_markdown(text), 1, 'md')
end
if text == 'setmod fun' then
database:set('fun','yes')
tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Mod Stats Has Been seted To* `FUN`', 1, 'md')
   print("Tabchi [ Message ]")
end
 if text == 'chat sgp' then
local hash =  'asgp'
          local list = database:smembers(hash)
          local t = '*Groups : *\n'
          for k,v in pairs(list) do
          t = t..k.." `"..v.." `\n" 
          end
          t = t..'\nCERNER Team'
          if #list == 0 then
          t = '*No Gp*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end
if text == 'chat gp' then
local hash =  'agp'
          local list = database:smembers(hash)
          local t = '*Groups : *\n'
          for k,v in pairs(list) do
          t = t..k.." `"..v.." `\n" 
          end
          t = t..'\nCERNER Team'
          if #list == 0 then
          t = '*No Gp*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end

if text == 'mod disable' then
database:set('fun','no')
database:del('fun','yes')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Mod Stats Has Been seted To* `OFF`', 1, 'md')
print("Tabchi [ Message ]")
  end
if text == 'mod status' then
 if database:get('fun') then
              mod = 'فان'
            else
              mod = 'ساده'
            end
   tabchi.sendText(msg.chat_id_, msg.id_, 1, '`حالت ربات Api :` '..mod..' میبااشد\n\n`Create By` *CerNer Team*', 1, 'md')
end
   if text == 'bc sgp' and tonumber(msg.reply_to_message_id_) > 0 then
          function cb(a,b,c)
          local text = b.content_.text_
          local list = database:smembers('asgp')
          for k,v in pairs(list) do
        tabchi.sendText(v, 0, 1, text,1, 'md')
          end
   local gps = database:scard("asgp")     
     local text = '*Your Message Was Send To* `'..gps..'`* SuperGroups*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end
if text == 'bc gp' and tonumber(msg.reply_to_message_id_) > 0 then
function cb(a,b,c)
local text = b.content_.text_
local list = database:smembers('agp')
for k,v in pairs(list) do
tabchi.sendText(v, 0, 1, text,1, 'md')
end
if text  then
 function cb(a,b,c)
         database:set('bot_id',b.id_)
tabchi.sendText(msg.chat_id_, msg.id_, 1, ''..b.id_..'', 1, 'md')		
         end
      tabchi.getMe(cb)
      end
    
local gp = database:scard("agp")     
local text = '*Your Message Was Send To* `'..gp..'`* Groups*'
tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')		
end
tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
end
 if text == 'bc user' and tonumber(msg.reply_to_message_id_) > 0 and is_sudo(msg) then
          function cb(a,b,c)
          local text = b.content_.text_
          local list = database:smembers('ausers')
          for k,v in pairs(list) do
        tabchi.sendText(v, 0, 1, text,1, 'md')
          end
local uu = database:scard("ausers")     
     local text = '*Your Message Was Send To* `'..uu..'`* Users*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end
if text == 'fwd sgp' and tonumber(msg.reply_to_message_id_) > 0 then
          function cb(a,b,c)
          local list = database:smembers('asgp')
          for k,v in pairs(list) do
         tabchi.forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)
          end
local gps = database:scard("asgp")     
     local text = '*Your Message Was ForWard To* `'..gps..'`* SuperGroups*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end
if text == 'fwd gp' and tonumber(msg.reply_to_message_id_) > 0 then
          function cb(a,b,c)
          local list = database:smembers('agp')
          for k,v in pairs(list) do
         tabchi.forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)
          end
local gp = database:scard("agp")     
  local text = '*Your Message Was ForWard To* `'..gp..'`* Groups*'
tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
 end
  tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
 end
if text == 'fwduser' and tonumber(msg.reply_to_message_id_) > 0 then
 function cb(a,b,c)
local list = database:smembers('ausers')
 for k,v in pairs(list) do
 tabchi.forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)
end
local qq = database:scard("ausers")     
     local text = '*Your Message Was ForWard To* `'..qq..'`* Users*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end
end

database:incr("aallmsg")
------------------------------------
 if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match('-100(%d+)') then
        if not database:sismember("asgp",msg.chat_id_) then
          database:sadd("asgp",msg.chat_id_)
        end
-----------------------------------
elseif id:match('^-(%d+)') then
if not database:sismember("agp",msg.chat_id_) then
database:sadd("agp",msg.chat_id_)
end
-----------------------------------------
elseif id:match('') then
if not database:sismember("ausers",msg.chat_id_) then
database:sadd("ausers",msg.chat_id_)
end
   else
        if not database:sismember("asgp",msg.chat_id_) then
            database:sadd("asgp",msg.chat_id_)
if msg.content_.ID == "MessageChatDeleteMember" == 400423730 then
database:srem("asgp"..msg.chat_id_)
database:srem("agp"..msg.chat_id_)
end
end
end
end
end
end
      function tdcli_update_callback(data)
 ---vardump(data)
    if (data.ID == "UpdateNewMessage") then
     showedit(data.message_,data)
  elseif (data.ID == "UpdateMessageEdited") then
    data = data
    local function edited_cb(extra,result,success)
      showedit(result,data)
    end
     tdcli_function ({
      ID = "GetMessage",
      chat_id_ = data.chat_id_,
      message_id_ = data.message_id_
    }, edited_cb, nil)
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({
      ID="GetChats",
      offset_order_="9223372036854775807",
      offset_chat_id_=0,
      limit_=20
    }, dl_cb, nil)
  end
end

