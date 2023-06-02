local KARAZHAN_MAP_ID = 532  -- Map ID for Karazhan
local MAX_LOW_LEVEL = 60
local MIN_HIGH_LEVEL = 61

local function CheckGroupOnMapChange(event, player)
    if player:GetMapId() == KARAZHAN_MAP_ID then  -- Check if player entered Karazhan
        local group = player:GetGroup()
        if group then
            local members = group:GetMembers()
            local lowLevelGroup = true
            local highLevelGroup = true
            for i, member in ipairs(members) do
                local level = member:GetLevel()
                if level > MAX_LOW_LEVEL then
                    lowLevelGroup = false
                end
                if level < MIN_HIGH_LEVEL then
                    highLevelGroup = false
                end
            end
            if not lowLevelGroup and not highLevelGroup then
                player:RemoveFromGroup()
                player:SendBroadcastMessage("Your group must be either all level 60 and below, or all 61 and above, to enter Karazhan.")
            end
        end
    end
end

RegisterPlayerEvent(28, CheckGroupOnMapChange)
