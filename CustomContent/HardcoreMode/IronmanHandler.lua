local SPELL_ID = 80007
local IRONMAN_QUALITY_THRESHOLD = 2
local ITEM_ID = 800049
local BROADCAST_DELAY = 1 -- Delay in seconds
local FAILURE_SPELL_ID = 80090 

local function RemoveItemAndBroadcast(eventId, delay, repeats, player)
    player:RemoveItem(ITEM_ID, 1) -- Remove the item from the player's inventory

    SendWorldMessage("|cFFFF0000" .. player:GetName() .. " has failed the Ironman challenge.|r")
    print(player:GetName() .. " has failed the Ironman challenge.")
	player:PlayDirectSound(183253)
    player:CastSpell(player, FAILURE_SPELL_ID, true) 
end

local function OnEquip(event, player, item, bag, slot)
    if item:GetQuality() >= IRONMAN_QUALITY_THRESHOLD and player:HasItem(ITEM_ID) then
        player:RegisterEvent(RemoveItemAndBroadcast, BROADCAST_DELAY * 1000, 1, player) 
    end
end

RegisterPlayerEvent(29, OnEquip)
