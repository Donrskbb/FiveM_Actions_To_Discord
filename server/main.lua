--DONT CHANGE IN HERE, JUST GO TO CONFIG.LUA--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.webhook
  local DISCORD_IMAGE = Config.image


local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "Discord Bot by Donrskbb",
			["icon_url"] = DISCORD_IMAGE,
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- Send the first notification
sendToDiscord(_U('server'),_U('server_start'),Config.green)

-- Event when a player is writing
AddEventHandler('chatMessage', function(author, color, message)
  if(settings.LogChatServer)then
      local player = ESX.GetPlayerFromId(author)
     sendToDiscord(_U('server_chat'), player.name .." : "..message,Config.grey)
  end
end)


-- Event when a player is connecting
RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  if(settings.LogLoginServer)then
    sendToDiscord(_U('server_connecting'), GetPlayerName(source) .." ".. _U('user_connecting'),Config.grey)
  end
end)

-- Event when a player is disconnecting
AddEventHandler('playerDropped', function(reason)
  if(settings.LogLoginServer)then
    sendToDiscord(_U('server_disconnecting'), GetPlayerName(source) .." ".. _U('user_disconnecting') .. "("..reason..")",Config.grey)
  end
end)



-- Add event when a player is kicked
-- TriggerEvent("esx:kickhammer",GetPlayerName(source),GetPlayerName(id)) -> es_admin2
RegisterServerEvent("esx:kickhammer")
AddEventHandler("esx:kickhammer", function(name,staff)
   if(settings.LogBanhammer)then
    sendToDiscordBan(_U('server_banhammer'),staff.." ".._U('kicked_by').." "..name,Config.pink)
   end

end)

-- Add event when a player is banned
-- TriggerEvent("esx:banhammer",GetPlayerName(source),GetPlayerName(id)) -> es_admin2
RegisterServerEvent("esx:banhammer")
AddEventHandler("esx:banhammer", function(name,staff)
   if(settings.LogBanhammer)then
    sendToDiscordBan(_U('server_banhammer'),staff.." ".._U('banned_by').." "..name,Config.purple)
   end

end)



-- Add event when a player give an item
-- TriggerEvent("esx:giveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount) -> ESX_extended
RegisterServerEvent("esx:giveitemalert")
AddEventHandler("esx:giveitemalert", function(name,nametarget,itemname,amount)
   if(settings.LogItemTransfer)then
    sendToDiscord(_U('server_item_transfer'),name.." ".._U('user_gives_to').." "..nametarget.." : "..itemname.." x"..amount,Config.white)
   end

end)

-- Add event when a player drop an item
-- TriggerEvent("esx:dropitemalert",xPlayer.name,foundItem.label,total) -> ESX_extended
RegisterServerEvent("esx:dropitemalert")
AddEventHandler("esx:dropitemalert", function(name,itemname,amount)
   if(settings.LogItemDrop)then
    sendToDiscord(_U('server_item_drop'),name.." ".._U('user_drop').." : "..itemname.." x"..amount,Config.white)
   end

end)

-- Add event when a player pick an item
-- TriggerEvent("esx:pickitemalert",xPlayer.name,item.label,total) -> ESX_extended
RegisterServerEvent("esx:pickitemalert")
AddEventHandler("esx:pickitemalert", function(name,itemname,amount)
   if(settings.LogItemPickup)then
    sendToDiscord(_U('server_item_pick'),name.." ".._U('user_pick').." : "..itemname.." x"..amount,Config.white)
   end

end)




-- Add event when a player give weapon
-- TriggerEvent("esx:giveweaponalert",sourceXPlayer.name,targetXPlayer.name,weaponLabel) -> ESX_extended
RegisterServerEvent("esx:giveweaponalert")
AddEventHandler("esx:giveweaponalert", function(name,nametarget,weaponlabel)
  if(settings.LogWeaponTransfer)then
    sendToDiscord(_U('server_weapon_transfer'),name.." ".._U('user_gives_to').." "..nametarget.." : "..weaponlabel,Config.black)
  end

end)

-- Add event when a player drop weapon
-- TriggerEvent("esx:dropweaponalert",xPlayer.name,weaponLabel) -> ESX_extended
RegisterServerEvent("esx:dropweaponalert")
AddEventHandler("esx:dropweaponalert", function(name,weaponlabel)
   if(settings.LogWeaponDrop)then
    sendToDiscord(_U('server_weapon_drop'),name.." ".._U('user_drop').." : "..weaponlabel,Config.black)
   end

end)




-- Add event when a player give money
-- TriggerEvent("esx:givemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount) -> ESX_extended
RegisterServerEvent("esx:givemoneyalert")
AddEventHandler("esx:givemoneyalert", function(name,nametarget,amount)
  if(settings.LogMoneyTransfer)then
    sendToDiscord(_U('server_money_transfer'),name.." ".._U('user_gives_to').." "..nametarget.." : "..amount.." " .._U('money'),Config.red)
  end

end)

-- Add event when a player drop money
-- TriggerEvent("esx:dropmoneyalert",xPlayer.name,total) -> ESX_extended
RegisterServerEvent("esx:dropmoneyalert")
AddEventHandler("esx:dropmoneyalert", function(name,amount)
   if(settings.LogMoneyDrop)then
    sendToDiscord(_U('server_money_drop'),name.." ".._U('user_drop').." : "..amount.. " " .._U('money'),Config.red)
   end

end)

-- Add event when a player pick money
-- TriggerEvent("esx:pickmoneyalert",xPlayer.name,pickup.count) -> ESX_extended
RegisterServerEvent("esx:pickmoneyalert")
AddEventHandler("esx:pickmoneyalert", function(name,amount)
   if(settings.LogMoneyPickup)then
    sendToDiscord(_U('server_money_pick'),name.." ".._U('user_pick').." : "..amount.. " " .._U('money'),Config.red)
   end

end)



-- Add event when a player give dirty money
-- TriggerEvent("esx:givedirtymoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount) -> ESX_extended
RegisterServerEvent("esx:givedirtymoneyalert")
AddEventHandler("esx:givedirtymoneyalert", function(name,nametarget,amount)
  if(settings.LogDirtyMoneyTransfer)then
    sendToDiscord(_U('server_dirtymoney_transfer'),name.." ".._U('user_gives_to').." "..nametarget.." : "..amount.." " .._U('dirty_money'),Config.orange)
  end

end)

-- Add event when a player drop dirty money
-- TriggerEvent("esx:dropdirtymoneyalert",xPlayer.name,total) -> ESX_extended
RegisterServerEvent("esx:dropdirtymoneyalert")
AddEventHandler("esx:dropdirtymoneyalert", function(name,amount)
   if(settings.LogDirtyMoneyDrop)then
    sendToDiscord(_U('server_dirtymoney_drop'),name.." ".._U('user_drop').." : "..amount.." " .._U('dirty_money'),Config.orange)
   end

end)

-- Add event when a player pick dirty money
-- TriggerEvent("esx:pickdirtymoneyalert",xPlayer.name,pickup.count) -> ESX_extended
RegisterServerEvent("esx:pickdirtymoneyalert")
AddEventHandler("esx:pickdirtymoneyalert", function(name,amount)
   if(settings.LogDirtyMoneyPickup)then
    sendToDiscord(_U('server_dirtymoney_pick'),name.." ".._U('user_pick').." : "..amount .." " .._U('dirty_money'),Config.orange)
   end

end)



-- Add event when a player withdraw money
-- TriggerEvent("esx:withdrawmoneyalert", xPlayer.name, amount) -> new_banking
RegisterServerEvent("esx:withdrawmoneyalert")
AddEventHandler("esx:withdrawmoneyalert", function(name,amount)
   if(settings.LogBankWithdraw)then
    sendToDiscord(_U('server_bank_transfers'),name.." ".._U('withdraw').." : "..amount .." " .._U('bank'),Config.red)
   end

end)

-- Add event when a player deposit money
-- TriggerEvent("esx:depositmoneyalert", xPlayer.name, amount) -> new_banking
RegisterServerEvent("esx:depositmoneyalert")
AddEventHandler("esx:depositmoneyalert", function(name,amount)
   if(settings.LogBankDeposit)then
    sendToDiscord(_U('server_bank_transfers'),name.." ".._U('deposit').." : "..amount .." " .._U('bank'),Config.green)
   end

end)



-- Add event when a player is washing money
--  TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount) -> ESX_society
RegisterServerEvent("esx:washingmoneyalert")
AddEventHandler("esx:washingmoneyalert", function(name,amount)
  sendToDiscord(_U('server_washingmoney'),name.." ".._U('user_washingmoney').." ".. amount .." dollars",Config.orange)

end)

-- Event when a player is in a blacklisted vehicle
RegisterServerEvent("esx:enterblacklistedcar")
AddEventHandler("esx:enterblacklistedcar", function(model)
   local xPlayer = ESX.GetPlayerFromId(source)
   sendToDiscord(_U('server_blacklistedvehicle'),xPlayer.name.." ".._U('user_entered_in').." ".. model ,Config.red)

end)


-- Event when a player (not policeman) is in a police vehicle
RegisterServerEvent("esx:enterpolicecar")
AddEventHandler("esx:enterpolicecar", function(model)
 	 local xPlayer = ESX.GetPlayerFromId(source)
 	 sendToDiscord(_U('server_policecar'),xPlayer.name.." ".._U('user_entered_in').." ".. model , Config.blue)

end)


-- Event when a player is jacking a car
RegisterServerEvent("esx:jackingcar")
AddEventHandler("esx:jackingcar", function(model)
   local xPlayer = ESX.GetPlayerFromId(source)
   sendToDiscord(_U('server_carjacking'),xPlayer.name.." ".._U('user_carjacking').." ".. model,Config.purple)

end)


-- Event when a player is killing an other one
RegisterServerEvent('esx:killerlog')
AddEventHandler('esx:killerlog', function(t,killer, kilerT) -- t : 0 = NPC, 1 = player
  local xPlayer = ESX.GetPlayerFromId(source)
  if(t == 1) then
     local xPlayer = ESX.GetPlayerFromId(source)
     local xPlayerKiller = ESX.GetPlayerFromId(killer)

     if(xPlayerKiller.name ~= nil and xPlayer.name ~= nil)then

       if(kilerT.killerinveh) then
         local model = kilerT.killervehname

            sendToDiscord(_U('server_kill'), xPlayer.name .." ".._U('user_kill').." "..xPlayerKiller.name.." ".._U('with').." "..model,Config.red)



       else
            sendToDiscord(_U('server_kill'), xPlayer.name .." ".._U('user_kill').." "..xPlayerKiller.name,Config.red)



       end
    end
  else
     sendToDiscord(_U('server_kill'), xPlayer.name .." ".. _('user_kill_environnement'),Config.red)
  end

end)


-- Event when a player is writing a tweet
AddEventHandler('chatMessage', function(source, name, message)
    if(settings.LogTweetServer)then
        if message:sub(1, 1) == "/" then
          sm = stringsplit(message, " ");
           if sm[1] == "/tweet" then
            local identity = getIdentity(source)
            local nameName = "".. identity.firstname .. " " .. identity.lastname .. "",
               CancelEvent()
               --sendToDiscord(nameName,string.sub(message,7),Config.bluetweet)
               sendToDiscordTweet(_U('server_twitter'), "" .. identity.firstname .. " " .. identity.lastname .." # " .. string.sub(message,7),Config.red)
           end
        end
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    --local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier = @identifier", {
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
  if result[1] ~= nil then
    local identity = result[1]

    return {
      firstname   = identity['firstname'],
      lastname  = identity['lastname'],
      dateofbirth = identity['dateofbirth'],
      sex   = identity['sex'],
      height    = identity['height']
    }
  else
    return {
      firstname   = '',
      lastname  = '',
      dateofbirth = '',
      sex   = '',
      height    = ''
    }
    end
end