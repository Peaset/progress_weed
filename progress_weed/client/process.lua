
local juices = {}
local isPickingUp, isProcessing = false, false
local IsRiding = false



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("İşlemek için ~INPUT_CONTEXT~ tuşuna ~g~ bas ~y~")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				local timeLeft = config.processtime * 1000
				exports["np-taskbar"]:taskBar(timeLeft, "İşleniyor")
				Process()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Process()
	isProcessing = true

	TriggerServerEvent('progresser:process')
	
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
	Citizen.Wait(5000)
	ClearPedTasks(playerPed)
	isProcessing = false
end