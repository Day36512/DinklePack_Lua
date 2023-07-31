local NPC_ID = 18930
local MOUNT_ID = 31992 -- Rocket mount is easiest. If you use another mount, fall annimation ensues. 
local DESTINATION_X = 141.855 -- XYZ of where you want to go.
local DESTINATION_Y = 2673.81
local DESTINATION_Z = 85.7
local Z_SPEED = 1850
local MAX_HEIGHT = 72
local CHECK_LOCATION_DELAY = 500
local REPUTATION_FACTION = 947 -- Thrallmar. Just switch to something else or comment out these sections. This is just to debug tbh. 
local REPUTATION_AMOUNT = 10
local TEAM_ALLIANCE = 1 -- Horde, 0 is Alliance

local function CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X) <= 1 and math.abs(y - DESTINATION_Y) <= 1 and math.abs(z - DESTINATION_Z) <= 1 then
        player:Dismount()
        player:RemoveEventById(eventId)
        
        
        local currentReputation = player:GetReputation(REPUTATION_FACTION)
        player:SetReputation(REPUTATION_FACTION, currentReputation + REPUTATION_AMOUNT)
    end
end

local function ThrallmarOnGossipHello(event, player, object)
    if player:GetTeam() == TEAM_ALLIANCE then
        player:GossipMenuAddItem(0, "Take me to Thrallmar!", 0, 1)
        player:GossipSendMenu(1, object)
        return true
    end
    return false
end

local function ThrallmarOnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        player:GossipComplete()       
        player:Mount(MOUNT_ID)       
        player:MoveJump(DESTINATION_X, DESTINATION_Y, DESTINATION_Z, Z_SPEED, MAX_HEIGHT)        
        player:RegisterEvent(CheckLocationAndDismount, CHECK_LOCATION_DELAY, 150) 
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, ThrallmarOnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, ThrallmarOnGossipSelect)
