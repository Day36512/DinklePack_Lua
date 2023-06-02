local NPCID = 90002
local DESTINATION_X = -4492 
local DESTINATION_Y = -1588 
local DESTINATION_Z = 509 
local CHECK_LOCATION_DELAY = 500 

local function CheckLocationAndResetDisplayId(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - DESTINATION_X) <= 1 and math.abs(y - DESTINATION_Y) <= 1 and math.abs(z - DESTINATION_Z) <= 1 then
        -- The player has reached the destination, reset their display and cancel the event
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

local function PlatformTransportOnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to the Airfield!", 0, 1)
    player:GossipSendMenu(1, creature)
end

local function PlatformTransportOnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(DESTINATION_X, DESTINATION_Y, DESTINATION_Z, 2000, 115)
        player:RegisterEvent(CheckLocationAndResetDisplayId, CHECK_LOCATION_DELAY, 200) -- 0 repeats means infinite repeats
    end
end

RegisterCreatureGossipEvent(NPCID, 1, PlatformTransportOnGossipHello)
RegisterCreatureGossipEvent(NPCID, 2, PlatformTransportOnGossipSelect)
