local SaveAllPlayersModule = {}

SaveAllPlayersModule.SCRIPT_ENABLED = false  -- Set this to false to disable the script
local eventStarted = false -- don't change me. 

local function saveAllPlayers(eventId, delay, repeats)
    if SaveAllPlayersModule.SCRIPT_ENABLED then
        print("Event Triggered: Saving all players")
        local players = GetPlayersInWorld()
        for i, player in ipairs(players) do
            print("Saving player: " .. player:GetName())
            player:SaveToDB()
        end
        print("All active players saved successfully")
    end
end

local function SaveonPlayerLogin(event, player)
    local playerName = player:GetName()  -- Get player name here to use in the closure
    local startSaveEvent = function() -- Define the function with a closure
        print("Player " .. playerName .. " has logged in")
        if not eventStarted then
            print("Save event not started yet, starting now")
            CreateLuaEvent(saveAllPlayers, 60000, 0) -- 60000 milliseconds = 1 minute, 0 means repeat infinitely
            eventStarted = true
            print("Save event started, will save all players every minute")
        else
            print("Save event already initiated, will not initiate again")
        end
    end
    player:RegisterEvent(startSaveEvent, 8000, 1) -- Register a one-time event that will be executed 8 seconds after login
end

if SaveAllPlayersModule.SCRIPT_ENABLED then
    RegisterPlayerEvent(3, SaveonPlayerLogin) -- 3 is PLAYER_EVENT_ON_LOGIN
end
