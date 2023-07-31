local CLOSE_DISTANCE = 5 

function RFD_OnEnter(event, go, player)
    go:RegisterEvent(RFD_CheckForPlayersEntrance, 1000, 0)
end

function RFD_CheckForPlayersEntrance(event, delay, repeat_times, go, player)
    local players_in_range = go:GetPlayersInRange(CLOSE_DISTANCE)
    for _, player in pairs(players_in_range) do
        if player:GetLevel() >= 25 then
            player:Teleport(129, 2593.040, 1106.7067, 51.36396, 4.7)
        else
            player:SendBroadcastMessage("You must be at least level 25 to enter.")
        end
    end
end


RegisterGameObjectEvent(900001, 2, RFD_OnEnter)
