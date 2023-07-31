local CLOSE_DISTANCE = 5 

function GRIMBATOL_OnExit(event, go, player)
    go:RegisterEvent(GRIMBATOL_CheckForPlayersEXIT, 1000, 0)
end

function GRIMBATOL_CheckForPlayersEXIT(event, delay, repeat_times, go, player)
    local players_in_range = go:GetPlayersInRange(CLOSE_DISTANCE)
    for _, player in pairs(players_in_range) do
            player:Teleport(0, -4076.992188, -3458.102539, 281.254150, 3.58)
        end
    end

RegisterGameObjectEvent(900003, 2, GRIMBATOL_OnExit)
