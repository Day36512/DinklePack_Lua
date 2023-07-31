local CLOSE_DISTANCE = 5 

function GRIM_OnEnter(event, go, player)
    go:RegisterEvent(GRIM_CheckForPlayersEntrance, 1000, 0)
end

function GRIM_CheckForPlayersEntrance(event, delay, repeat_times, go, player)
    local players_in_range = go:GetPlayersInRange(CLOSE_DISTANCE)

    for _, player in pairs(players_in_range) do
        if player:GetGMRank() >= 3 then
            -- GMs of rank 3 or higher are allowed in regardless of level or raid group
            player:Teleport(670, -620.997, -201.813, 271.998, 5.0454)  -- updated coordinates
        else
            if player:GetLevel() >= 60 then
                if player:IsInGroup() and player:GetGroup():IsRaid() then
					
                    player:Teleport(670, -620.997, -201.813, 271.998, 5.0454)  -- updated coordinates
                else
                    player:SendBroadcastMessage("You need to be in a raid group to use this portal.")
                end
            else
                player:SendBroadcastMessage("You need to be at least level 60 to use this portal.")
            end
        end
    end
end


RegisterGameObjectEvent(900002, 2, GRIM_OnEnter)
