local changeHandler = nil

RegisterNetEvent("Characters:Client:Spawn", function()
	changeHandler = AddStateBagChangeHandler(
		"isMouthGagged",
		string.format("player:%s", LocalPlayer.state.serverID),
		function(bagName, key, value, _unused, replicated)
			if value then
				SetupMouthGag()
			else
				RemoveMouthGag()
			end
		end
	)

	if LocalPlayer.state.isMouthGagged then
		SetupMouthGag()
	end
end)

RegisterNetEvent("Characters:Client:Logout", function()
	if changeHandler ~= nil then
		RemoveStateBagChangeHandler(changeHandler)
		changeHandler = nil
	end

	RemoveMouthGag()
end)

AddEventHandler("HUD:Client:RemoveMouthGag", function(entity, data)
	if type(entity) == "table" and entity.serverId then
		Callbacks:ServerCallback("HUD:RemoveMouthGag", entity.serverId, function(s)
		end)
	end
end)

function SetupMouthGag()
	TriggerEvent("VOIP:Client:MouthGag:Set", true)
end

function RemoveMouthGag()
	TriggerEvent("VOIP:Client:MouthGag:Set", false)
end
