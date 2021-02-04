ESX = nil

local IsAnimated = false
local playanim = config.playanimation
local prop_desk = {
1844244923, 
-1727936540, 
1844244923, 
1844244923, 
-1593767197, 
1598545299, 
973800157, 
1272292978, 
-1572018818, 
-314623274, 
-555690024,
48898026, 
-1100726734, 
-386283689, 
502827120, 
794001094, 
-380698483,
1982532724,
-232870343,
-46621628,
-679720048,
-382013683,
-40724548,
909487668,
-692384911,
-1367418948,
-182643788,
-1788992133,
-1848238485,
386059801,
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('otsar', function()
    Citizen.Wait(0)
    if not IsAnimated then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for i = 1, #prop_desk do
            local propdeskw = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, prop_desk[i], false, false, false)
            local propdeskPos = GetEntityCoords(propdeskw)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, propdeskPos.x, propdeskPos.y, propdeskPos.z, true)
            if dist < 1.8 then
                local loc = vector3(propdeskPos.x, propdeskPos.y, propdeskPos.z + 1.0)
                if not IsAnimated then
                    prop_name = prop_name or prop_process
                    IsAnimated = true

                    RequestAnimDict("mini@repair")
                    while (not HasAnimDictLoaded("mini@repair")) do
                        Wait(20)
                    end

                    TaskPlayAnim(ped,"mini@repair","fixing_a_ped",8.0, -8, -1, 49, 0, true, false, false)
                    exports["np-taskbar"]:taskBar(config.processtime * 1000, "Sarılıyor")
                    TriggerServerEvent('progresser:processpaper')
                    
                    Citizen.Wait(config.processtime * 1000)
                    ClearPedSecondaryTask(ped)
                    IsAnimated = false  
                end
            end
        end
    end
end)