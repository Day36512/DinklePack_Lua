local SPELL_TO_LISTEN_FOR = 80040 -- Kindling Fury
local AURA_TO_CHECK = 80040 -- the aura to check stacks for is the same as the spell
local SPELL_TO_CAST = 920353 -- Spell to cast when aura stacks reach 15
local REQUIRED_AURA_STACKS = 14

local function OnCast(event, player, spell, skipCheck)
    if spell:GetEntry() == SPELL_TO_LISTEN_FOR then
        local aura = player:GetAura(AURA_TO_CHECK)
        if aura and aura:GetStackAmount() >= REQUIRED_AURA_STACKS then
            player:CastSpell(player, SPELL_TO_CAST, true)
            player:RemoveAura(AURA_TO_CHECK) -- Remove the aura
        end
    end
end

RegisterPlayerEvent(5, OnCast) -- PLAYER_EVENT_ON_SPELL_CAST = 5
