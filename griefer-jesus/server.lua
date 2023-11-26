local useesx = false    --enable if using esx and wanting command for admins to trigger griefer jesus

RegisterNetEvent('griefer-jesus:playSoundForNearbyPlayers')
AddEventHandler('griefer-jesus:playSoundForNearbyPlayers', function()
    local source = source
    local players = GetPlayers()

    for _,playerId in ipairs(players) do
        TriggerClientEvent("griefer-jesus:awesomegod", playerId, source, playerId)
    end
end)

if useesx then

    ESX = nil 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    RegisterCommand("grieferjesus", function(source, args, rawCommand)
        local xPlayer = ESX.GetPlayerFromId(source)
        victimid = tonumber(args[1])
        if xPlayer and xPlayer.getGroup() == "superadmin" then
            TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Griefer Jesus for "..victimid..". Dont forget to pray.")
            TriggerClientEvent("griefer-jesus:letsgooo", victimid)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Du hast nicht die erforderlichen Berechtigungen, um diesen Command zu verwenden.")
        end
    end, false)

end