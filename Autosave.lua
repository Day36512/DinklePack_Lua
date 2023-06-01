local SCRIPT_ENABLED = true  -- Set this to false to disable the script
local eventStarted = false -- don't change me. 

local function saveAllPlayers(eventId, delay, repeats)
    if SCRIPT_ENABLED then
        print("Event Triggered: Saving all players")
        local players = GetPlayersInWorld()
        for i, player in ipairs(players) do
            print("Saving player: " .. player:GetName())
            player:SaveToDB()
        end
        print("All active players saved successfully")
    end
end

local function onPlayerLogin(event, player)
    if SCRIPT_ENABLED then
        print("Player " .. player:GetName() .. " has logged in")
        if not eventStarted then
            print("Save event not started yet, starting now")
            CreateLuaEvent(saveAllPlayers, 60000, 0) -- 60000 milliseconds = 1 minute, 0 means repeat infinitely
            eventStarted = true
            print("Save event started, will save all players every minute")
        else
            print("Save event already initiated, will not initiate again")
        end
    end
end

if SCRIPT_ENABLED then
    RegisterPlayerEvent(3, onPlayerLogin) -- 3 is PLAYER_EVENT_ON_LOGIN
end
