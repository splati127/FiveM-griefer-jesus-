state = false 
ESX = nil
OldPlayerPed = nil

if Config.UseESX then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Wait(Config.Intervall)

        local randomNumber = math.random(1, Config.Chance) 

        if randomNumber == 1 then
            TriggerEvent("griefer-jesus:letsgooo", 0, "default")
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

        TriggerEvent('melody_backgroundmusic:musicstatus', false, false)

        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = 'griefer-jesus.mp3'
        })

        SetTimeout(16000, function()
            TriggerEvent('melody_backgroundmusic:musicstatus', true, false)
            SendNUIMessage({
                transactionType = 'stopSound'
            })
        end)
    end
end)

RegisterNetEvent("griefer-jesus:letsgooo")
AddEventHandler("griefer-jesus:letsgooo", function(aggressive, typemsg)
    TriggerServerEvent("griefer-jesus:playSoundForNearbyPlayers")

    TriggerServerEvent('melody_legacy:giveaward', GetPlayerServerId(PlayerId()), "Griefer Jesus", "auto")

    local npcModel = Config.PEDModel
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    RequestModel(npcModel)

    while not HasModelLoaded(npcModel) do
        Wait(500)
    end

    local jesus = CreatePed(4, npcModel, playerCoords.x + 14, playerCoords.y + 14, playerCoords.z, 0.0, true, false)
    GiveWeaponToPed(jesus, GetHashKey("WEAPON_RAILGUN"), 1000, true, true)
    TaskGoToEntity(jesus, GetPlayerPed(-1), -1, 0.5, 2.0, 1073741824, 0)
    SetEntityInvincible(jesus, true)

    if aggressive == 1 or Config.AlwaysAggressive then
        SetEntityCoords(jesus, playerCoords.x + 4, playerCoords.y + 4, playerCoords.z)
        showaggressivemsg(5, typemsg)
        TaskCombatPed(jesus, GetPlayerPed(-1), 0, 16)
        SetPedFiringPattern(jesus, 2685983626)
        TaskShootAtEntity(jesus, GetPlayerPed(-1), -1, 2685983626)
    end

    Wait(16000)
    ClearPedTasks(jesus)
    DeletePed(jesus)
end)

RegisterNetEvent("griefer-jesus:letsgrief")
AddEventHandler("griefer-jesus:letsgrief", function(aggressive)
    if not state then
        TriggerEvent("griefer-jesus:awesomegod")
    end

    local model = Config.PEDModel
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(500)
    end

    if state then
        state = false
        local vehicledel = GetVehiclePedIsIn(PlayerId(), false)
        if DoesEntityExist(vehicledel) then
            SetEntityAsMissionEntity(vehicledel, true, true)
            SetEntityAsNoLongerNeeded(vehicledel)
            DeleteVehicle(vehicledel)
        end
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.NotJesusText)
        DrawNotification(0, 0, 1, -1)
        SetEntityInvincible(GetPlayerPed(-1), false)
        if Config.UseESX then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                local isMale = skin.sex == 0

                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        TriggerEvent('esx:restoreLoadout')
                    end)
                end)
            end)
        else
            OldPlayerPed = Config.NormalPED
            if IsModelInCdimage(OldPlayerPed) and IsModelValid(OldPlayerPed) then
                RequestModel(OldPlayerPed)
                while not HasModelLoaded(OldPlayerPed) do
                  Wait(0)
                end
                SetPlayerModel(PlayerId(), OldPlayerPed)
                SetModelAsNoLongerNeeded(OldPlayerPed)
            end
        end
    else
        OldPlayerPed = GetPlayerPed(-1)
        state = true
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.JesusText)
        DrawNotification(0, 0, 1, -1)

        SetPlayerModel(PlayerId(), model)
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_RAILGUN"), 1000, true, true)
        SetEntityInvincible(GetPlayerPed(-1), true)


        local vehiclemodel = "oppressor2"
        RequestModel(vehiclemodel)
        while not HasModelLoaded(vehiclemodel) do
            Wait(500)
        end
        local playercoords = GetEntityCoords(GetPlayerPed(-1))
        local playerheading = GetEntityHeading(GetPlayerPed(-1))
        local vehicle = CreateVehicle(vehiclemodel, playercoords.x, playercoords.y, playercoords.z, playerheading, true, false)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
        SetVehicleNumberPlateText(vehicle, "JESUS")
        SetVehicleNumberPlateTextIndex(vehicle, 5)
        SetVehicleFuelLevel(vehicle, 100)
        SetVehicleDirtLevel(vehicle, 0)
        SetEntityInvincible(vehicle, true)

        SetVehicleMod(vehicle, 48, 6, false)
    end
end)

local newsCamera = nil
function showaggressivemsg(duration, msgtype)
    if msgtype == "default" then
        msgtype = Config.aggrMsgType
    end
    if msgtype == "scale" then
    Citizen.CreateThread(function()
        local scaleformHandle = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(scaleformHandle) do
            Citizen.Wait(0)
        end

        BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") 
        PushScaleformMovieMethodParameterString(Config.aggressiveMsg1) 
        PushScaleformMovieMethodParameterString(Config.aggressiveMsg2) 
        PushScaleformMovieMethodParameterInt(5)
        EndScaleformMovieMethod() 

        showcount = 0
        show = true
        while true do 
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
            if show then
                showcount = showcount + 1
                if showcount > duration * 100 - 100 then 
                    show = false 
                end
                DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
            else
                SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
                return
            end
        end
    end)

    elseif msgtype == "news" then
        TriggerEvent('basics:hudtoggle', false)
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)

        newsCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", playerCoords.x - 3, playerCoords.y - 3, playerCoords.z + 6, 0.0, 0.0, playerHeading, 50.00, false, 0)
        
        NetworkSetInSpectatorMode(true, playerPed)
    
        SetCamActive(newsCamera, true)
        RenderScriptCams(true, false, 0, true, true)

        Citizen.CreateThread(function()
            local scaleformHandle = RequestScaleformMovie("breaking_news")
            while not HasScaleformMovieLoaded(scaleformHandle) do
                Citizen.Wait(0)
            end
    
            BeginScaleformMovieMethod(scaleformHandle, "SET_SCROLL_TEXT") 
            PushScaleformMovieMethodParameterString(Config.aggressiveMsg3)
            PushScaleformMovieMethodParameterInt(0)
            EndScaleformMovieMethod() 
    
            showcount = 0
            show = true
            while true do 
                Citizen.Wait(0)
                DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
                if show then
                    showcount = showcount + 1
                    if showcount > duration * 100 - 100 then 
                        show = false 
                    end
                    PointCamAtCoord(newsCamera, playerCoords)
                    DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
                else
                    SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
                    return
                end
            end
        end)
        
        Wait(duration * 1000 - 100)

        local playerPed = GetPlayerPed(-1)
    
        NetworkSetInSpectatorMode(false, playerPed)
    
        SetCamActive(newsCamera, false)
        RenderScriptCams(false, false, 0, true, true)

        newsCamera = nil
        TriggerEvent('basics:hudtoggle', true)
    else
        SetTextComponentFormat("STRING")
        AddTextComponentString(Config.aggressiveMsg2)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
end
