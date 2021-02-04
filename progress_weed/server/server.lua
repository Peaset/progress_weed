ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('progresser:processpaper')
AddEventHandler('progresser:processpaper', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(5000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMinW, xMax = xPlayer.getInventoryItem(config.weedpaper), xPlayer.getInventoryItem(config.processedweed), xPlayer.getInventoryItem(config.processedpaperweed)
			if xMin.count > 0 and xMinW.count > 0 then

				xPlayer.removeInventoryItem(config.processedweed, 1)
				Citizen.Wait(200)
				xPlayer.removeInventoryItem(config.weedpaper, 1)
				Citizen.Wait(200)
				xPlayer.addInventoryItem(config.processedpaperweed, 1)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "1 Adet Ot Sardın")
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Yeteri Kadar Malzeme Yok!")
			end

			playersProcessing[_source] = nil
		end)
	end
end)

RegisterServerEvent('progresser:process')
AddEventHandler('progresser:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(5000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMinW, xMax = xPlayer.getInventoryItem(config.weedprocesser), xPlayer.getInventoryItem(config.weed), xPlayer.getInventoryItem(config.processedweed)
			if xMin.count > 0 and xMinW.count > 0 then
				xPlayer.removeInventoryItem(config.weed, 1)
				Citizen.Wait(200)
				xPlayer.removeInventoryItem(config.weedprocesser, 1)
				Citizen.Wait(200)
				xPlayer.addInventoryItem(config.processedweed, 1)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "1 Adet Ot İşlenmiş Ot Aldın")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Yeteri Kadar Malzeme Yok!")
			end

			playersProcessing[_source] = nil
		end)
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('progresser:cancelProcessing')
AddEventHandler('progresser:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
