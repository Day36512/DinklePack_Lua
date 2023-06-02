-- Constants
local NPC_ID = 3838
local QUEST_ID = 6342
local MOUNT_ID = 31992
local DESTINATION_X = 6344.46 -- Replace with actual value
local DESTINATION_Y = 557.44 -- Replace with actual value
local DESTINATION_Z = 16 -- Replace with actual value
local Z_SPEED = 1850 -- Replace with actual value
local MAX_HEIGHT = 30 -- Replace with actual value
local CHECK_LOCATION_DELAY = 500

local function CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X) <= 1 and math.abs(y - DESTINATION_Y) <= 1 and math.abs(z - DESTINATION_Z) <= 1 then
        -- The player has reached the destination, dismount them and cancel the event
        player:Dismount()
        player:RemoveEventById(eventId)
    end
end

local function OnGossipHello(event, player, object)
    -- Check if the player has the quest
    if player:HasQuest(QUEST_ID) then
        -- Mount the player
        player:Mount(MOUNT_ID)
        -- Move jump to the specified location
        player:MoveJump(DESTINATION_X, DESTINATION_Y, DESTINATION_Z, Z_SPEED, MAX_HEIGHT)
		-- Check if the player has reached the destination every half second, and dismount them when they have
        player:RegisterEvent(CheckLocationAndDismount, CHECK_LOCATION_DELAY, 200) -- 0 repeats means infinite repeats

        return true
    end
    -- If the player doesn't have the quest, allow the default gossip window to open
    return false
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)

