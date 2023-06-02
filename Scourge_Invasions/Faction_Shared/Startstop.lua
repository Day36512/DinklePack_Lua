local holidayEventIds = {17, 91}

-- add a boolean flag
local hasScriptRun = false

local function OnPlayerLogin(event, player)
    -- check the flag
    if hasScriptRun then
        print("Event Fix Script has already run, skipping...")
        return
    else
        print("Running Event Fix Script for the first time...")
    end
    
    if not player:IsInWorld() then
        return
    end

    for _, eventId in ipairs(holidayEventIds) do
        local isHolidayActive = IsGameEventActive(eventId)

        if isHolidayActive then
            StopGameEvent(eventId)
            StartGameEvent(eventId)
        end
    end
    
    -- set the flag to true after the first run
    hasScriptRun = true
    print("Event Fix Script run complete, will not run again until server restart")
end

RegisterPlayerEvent(3, OnPlayerLogin)
