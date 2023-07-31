local restrictedItemId = 800048
local restrictedSpells = {
    33388, 33389, 33391, 33392, 34090, 34091, 34092, 34093
}

local function OnPlayerLearnSpell(event, player, spellId)
    if player:HasItem(restrictedItemId) then
        for _, restrictedSpell in ipairs(restrictedSpells) do
            if spellId == restrictedSpell then
                player:RemoveSpell(spellId)
				player:CastSpell(player, 12158, true)
                player:SendBroadcastMessage("|cffff0000Riding unlearned. You can't learn that spell while Slow and Steady mode is active.|r")
                break
            end
        end
    end
end

RegisterPlayerEvent(44, OnPlayerLearnSpell)
