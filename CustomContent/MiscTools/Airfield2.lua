local NPCID = 90003
local DESTINATION_X1 = -5166.45 
local DESTINATION_Y1 = -877.49 
local DESTINATION_Z1 = 507.39 
local DESTINATION_X2 = -4028.206 
local DESTINATION_Y2 = -1415.7199 
local DESTINATION_Z2 = 156.94 
local CHECK_LOCATION_DELAY = 500 -- Adjust the delay time based on how long it takes to reach the destination

local function CheckLocationAndResetDisplayId1(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X1) <= 1 and math.abs(y - DESTINATION_Y1) <= 1 and math.abs(z - DESTINATION_Z1) <= 1 then
        -- The player has reached the destination, reset their display and cancel the event
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

local function CheckLocationAndResetDisplayId2(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X2) <= 1 and math.abs(y - DESTINATION_Y2) <= 1 and math.abs(z - DESTINATION_Z2) <= 1 then
        -- The player has reached the destination, reset their display and cancel the event
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

local function PlatformTransportOnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to Ironforge!", 0, 1)
    player:GossipMenuAddItem(0, "Take me to Wetland Highlands!", 0, 2)
    player:GossipSendMenu(1, creature)
end

local function PlatformTransportOnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(DESTINATION_X1, DESTINATION_Y1, DESTINATION_Z1, 2000, 115)
        player:RegisterEvent(CheckLocationAndResetDisplayId1, CHECK_LOCATION_DELAY, 200) 
    elseif (intid == 2) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(DESTINATION_X2, DESTINATION_Y2, DESTINATION_Z2, 2000, 70)
        player:RegisterEvent(CheckLocationAndResetDisplayId2, CHECK_LOCATION_DELAY, 200) 
    end
end

RegisterCreatureGossipEvent(NPCID, 1, PlatformTransportOnGossipHello)
RegisterCreatureGossipEvent(NPCID, 2, PlatformTransportOnGossipSelect)

