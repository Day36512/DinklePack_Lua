local REQUIRED_ITEM_ID = 60102
local JUGGERNAUT_SPELL_ID = 100248
local EXECUTE_SPELL_IDS = {47471, 47470, 25236, 25234, 20662, 20661, 20660, 20658, 5308}

local VANGUARD_DEFENSE_SPELL_ID = 100250
local DEVASTATE_SPELL_IDS = {47498, 20243, 30016, 30022, 47497}

local function WarriorL_OnAbilityCast(event, player, spell, skipCheck)
    local requiredItem = player:GetItemByEntry(REQUIRED_ITEM_ID)
    if not requiredItem or not requiredItem:IsEquipped() then
        return
    end

    local spellId = spell:GetEntry()
    
    -- Convert EXECUTE_SPELL_IDS and DEVASTATE_SPELL_IDS to sets for fast lookup
    local execute_spell_set = {}
    for _, v in ipairs(EXECUTE_SPELL_IDS) do
        execute_spell_set[v] = true
    end

    local devastate_spell_set = {}
    for _, v in ipairs(DEVASTATE_SPELL_IDS) do
        devastate_spell_set[v] = true
    end

    -- If the spell is not an Execute or Devastate spell, return early
    if not execute_spell_set[spellId] and not devastate_spell_set[spellId] then
        return
    end

    -- Now cast the corresponding spell
    if execute_spell_set[spellId] then
        player:CastSpell(player, JUGGERNAUT_SPELL_ID, true)
    elseif devastate_spell_set[spellId] then
        player:CastSpell(player, VANGUARD_DEFENSE_SPELL_ID, true)
    end
end

RegisterPlayerEvent(5, WarriorL_OnAbilityCast)
