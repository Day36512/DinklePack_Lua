local AURA_ID = 80081 -- Set the Aura ID you want to check for here

local function OnPlayerCreateItem(event, player, item, count)
    -- Check if the player has the specified aura
    if player:HasAura(AURA_ID) then
        -- Get the item entry ID
        local itemEntry = item:GetEntry()

        -- Create a duplicate of the item
        player:AddItem(itemEntry, count)
    end
end

RegisterPlayerEvent(52, OnPlayerCreateItem) -- 52 is the PLAYER_EVENT_ON_CREATE_ITEM
