-- IDs of the spells in question
local SPELL_23989 = 23989
local SPELL_80028 = 80028
local SPELL_2641 = 2641
local SPELL_883 = 883

-- Event handler for when the player learns a new spell
local function OnLearnSpell(event, player, spellId)
    if spellId == SPELL_23989 then
        player:CastSpell(player, SPELL_80028, true)
        player:CastSpell(player, SPELL_2641, true)
    end
end

-- Event handler for when the player casts a spell
local function OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if player:HasSpell(SPELL_23989) then
        if spellId == SPELL_883 then
            if player:HasAura(SPELL_80028) then
                player:RemoveAura(SPELL_80028)
            end
        elseif spellId == SPELL_2641 then
            player:CastSpell(player, SPELL_80028, true)
        end
    end
end

-- Event handler for when the player resets talents
local function OnTalentsReset(event, player, noCost)
    if player:HasAura(SPELL_80028) then
        player:RemoveAura(SPELL_80028)
    end
end

-- Register the event handlers
RegisterPlayerEvent(44, OnLearnSpell)
RegisterPlayerEvent(5, OnSpellCast)
RegisterPlayerEvent(17, OnTalentsReset)
