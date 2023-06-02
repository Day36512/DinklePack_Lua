local SPELL_ID = 80008  
local ITEM_ID = 5896

local function RemoveItemDelayed(eventId, delay, repeats, player)
    if player:HasItem(ITEM_ID) then
        player:RemoveItem(ITEM_ID, 1)
    end
end

local function OnPlayerCastSpell(event, player, spell, skipCheck)
    if spell:GetEntry() == SPELL_ID then
        player:RegisterEvent(RemoveItemDelayed, 500, 1) -- 500ms delay
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell)
