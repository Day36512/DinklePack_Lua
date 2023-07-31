-- Constants
local NPC_ID = 18931
local MOUNT_ID = 31992
local DESTINATION_X = -669.166
local DESTINATION_Y = 2715.216
local DESTINATION_Z = 94.44
local Z_SPEED = 1850
local MAX_HEIGHT = 72
local CHECK_LOCATION_DELAY = 500
local REPUTATION_FACTION = 946
local REPUTATION_AMOUNT = 10
local TEAM_ALLIANCE = 0

local function CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X) <= 1 and math.abs(y - DESTINATION_Y) <= 1 and math.abs(z - DESTINATION_Z) <= 1 then
        -- The player has reached the destination, dismount them and cancel the event
        player:Dismount()
        player:RemoveEventById(eventId)
        
        -- Correct way to add reputation for faction 946
        local currentReputation = player:GetReputation(REPUTATION_FACTION)
        player:SetReputation(REPUTATION_FACTION, currentReputation + REPUTATION_AMOUNT)
    end
end

local function OnGossipHello(event, player, object)
    if player:GetTeam() == TEAM_ALLIANCE then
        player:GossipMenuAddItem(0, "Take me to Honor Hold!", 0, 1)
        player:GossipSendMenu(1, object)
        return true
    end
    return false
end

local function OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        player:GossipComplete()
        -- Mount the player
        player:Mount(MOUNT_ID)
        -- Move jump to the specified location
        player:MoveJump(DESTINATION_X, DESTINATION_Y, DESTINATION_Z, Z_SPEED, MAX_HEIGHT)
        -- Check if the player has reached the destination every half second, and dismount them when they have
        player:RegisterEvent(CheckLocationAndDismount, CHECK_LOCATION_DELAY, 150) -- 0 repeats means infinite repeats
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
