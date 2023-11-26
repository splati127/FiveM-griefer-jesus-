Citizen.CreateThread(function()
    while true do
        Wait(900000)

        local randomNumber = math.random(1, 15) 

        if randomNumber == 1 then
            TriggerEvent("griefer-jesus:letsgooo")
        end
    end
end)

RegisterNetEvent("griefer-jesus:awesomegod")
AddEventHandler("griefer-jesus:awesomegod", function(original, player)
    local ogcoords = GetEntityCoords(GetPlayerPed(original))
    local playercoords = GetEntityCoords(GetPlayerPed(player))
    local distance = GetDistanceBetweenCoords(playercoords.x, playercoords.y, playercoords.z, ogcoords.x, ogcoords.y, ogcoords.z, true)
    maxDistance = 20.0

    if distance <= maxDistance then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = 'griefer-jesus.mp3'
        })

        SetTimeout(16000, function()
            SendNUIMessage({
                transactionType = 'stopSound'
            })
        end)
    end
end)

RegisterNetEvent("griefer-jesus:letsgooo")
AddEventHandler("griefer-jesus:letsgooo", function()
    TriggerServerEvent("griefer-jesus:playSoundForNearbyPlayers")

    local npcModel = "JesusChrist"
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    RequestModel(npcModel)

    while not HasModelLoaded(npcModel) do
        Wait(500)
    end

    local jesus = CreatePed(4, npcModel, playerCoords.x + 14, playerCoords.y + 14, playerCoords.z, 0.0, true, false)
    GiveWeaponToPed(jesus, GetHashKey("WEAPON_RAILGUN"), 1000, true, true)
    TaskGoToEntity(jesus, GetPlayerPed(-1), -1, 0.5, 2.0, 1073741824, 0)
    SetEntityInvincible(jesus, true)

    Wait(16000)
    ClearPedTasks(jesus)
    DeletePed(jesus)
end)