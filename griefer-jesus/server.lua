RegisterNetEvent('griefer-jesus:playSoundForNearbyPlayers')
AddEventHandler('griefer-jesus:playSoundForNearbyPlayers', function()
    local source = source
    local players = GetPlayers()

    for _,playerId in ipairs(players) do
        TriggerClientEvent("griefer-jesus:awesomegod", playerId, source, playerId)
    end
end)

local hasESX = false

if Config.UseESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    hasESX = true
end

if Config.UseCommands then

RegisterCommand("grieferjesus", function(source, args, rawCommand)
    local xPlayer

    if hasESX then
        xPlayer = ESX.GetPlayerFromId(source)
    end

    local victimid = tonumber(args[1])
    local aggressive = tonumber(args[2])
    local typemsg = args[3] or "default"

    if not aggressive then aggressive = 0 end

    if not hasESX or (xPlayer and xPlayer.getGroup() == "superadmin") then
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, victimid .. Config.CommandSuccess)
        TriggerClientEvent("griefer-jesus:letsgooo", victimid, aggressive, typemsg)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, Config.CommandNoAccess)
    end
end, false)

RegisterCommand("begrieferjesus", function(source)
    local xPlayer

    if hasESX then
        xPlayer = ESX.GetPlayerFromId(source)
    end

    if not hasESX or (xPlayer and xPlayer.getGroup() == "superadmin") then
        TriggerClientEvent("griefer-jesus:letsgrief", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, Config.CommandNoAccess)
    end
end, false)

end
