local CLOSE_DISTANCE = 5 -- Max distance when the player should get teleported

function ED_OnEnter(event, go, player)
	go:RegisterEvent(CheckForPlayersEntrance, 1000, 0)
end

function CheckForPlayersEntrance(event, delay, repeat_times, go, player)
	local players_in_range = go:GetPlayersInRange(CLOSE_DISTANCE)
	for _, player in pairs(players_in_range) do
		player:Teleport(169, 3233, 3040, 23.25, 3.15)
	end
end

RegisterGameObjectEvent(900000, 2, ED_OnEnter)