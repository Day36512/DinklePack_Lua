local AURA_1 = 80043
local SPELL_1 = 48982
local BONUS_SPELL_1 = 80042

local AURA_2 = 80044
local SPELL_2 = 48707
local BONUS_SPELL_2 = 80046

local HAS_AURA = 59327
local EXTRA_SPELL = 80027

local function OnPlayerCastSpell(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()

    -- If player has aura 80043 and casts 48982, also cast 80042
    if spellId == SPELL_1 and player:HasAura(AURA_1) then
        player:CastSpell(player, BONUS_SPELL_1, true)
    end

    -- If player has aura 80044 and casts 48707, also cast 80046
    if spellId == SPELL_2 and player:HasAura(AURA_2) then
        player:CastSpell(player, BONUS_SPELL_2, true)
    end
    
    -- If player has aura 59327 and casts 48982, also cast 80027
    if spellId == SPELL_1 and player:HasAura(HAS_AURA) then
        player:CastSpell(player, EXTRA_SPELL, true)
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell)
