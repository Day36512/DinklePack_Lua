local REQUIRED_ITEM_ID = 60102
local JUGGERNAUT_SPELL_ID = 100248
local EXECUTE_SPELL_IDS = {47471, 47470, 25236, 25234, 20662, 20661, 20660, 20658, 5308}

local VANGUARD_DEFENSE_SPELL_ID = 100250
local DEVASTATE_SPELL_IDS = {47498, 20243, 30016, 30022, 47497}

local function OnAbilityCast(event, player, spell, skipCheck)
    local requiredItem = player:GetItemByEntry(REQUIRED_ITEM_ID)
    if not requiredItem or not requiredItem:IsEquipped() then
        return
    end

    local spellId = spell:GetEntry()

    for _, executeId in ipairs(EXECUTE_SPELL_IDS) do
        if spellId == executeId then
            player:CastSpell(player, JUGGERNAUT_SPELL_ID, true)
            break
        end
    end

    for _, devastateId in ipairs(DEVASTATE_SPELL_IDS) do
        if spellId == devastateId then
            player:CastSpell(player, VANGUARD_DEFENSE_SPELL_ID, true)
            break
        end
    end
end

RegisterPlayerEvent(5, OnAbilityCast)
