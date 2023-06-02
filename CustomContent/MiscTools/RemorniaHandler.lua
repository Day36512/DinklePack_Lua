local AURA_ID = 80006
local CAST_SPELL_ID = 72313
local HEAL_PERCENT = 5
local EMOTE_ID = 53

local function OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()

    -- Cast spell 72313 and play emote 53 when the player casts spell 80006
    if spellId == 80006 then
        player:CastSpell(player, CAST_SPELL_ID, true)
        player:PerformEmote(EMOTE_ID)
    end

    -- Check if the player has the specified aura active
    if player:HasAura(AURA_ID) then
        -- Calculate the healing amount
        local healAmount = player:GetMaxHealth() * (HEAL_PERCENT / 100)

        -- Apply the healing effect
        player:DealHeal(player, spellId, healAmount)
    end
end

RegisterPlayerEvent(5, OnSpellCast)
