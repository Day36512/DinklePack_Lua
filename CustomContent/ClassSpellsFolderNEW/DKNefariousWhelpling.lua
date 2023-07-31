local NEFARIOUS_WHELPLING = 400154
local SPELL_SHADOW_WEAKNESS = 80041
local SPELL_SHADOW_BOLT = 11659

local function CastShadowWeaknessOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, SPELL_SHADOW_WEAKNESS, true)
    end
end

local function CastShadowBoltOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, SPELL_SHADOW_BOLT, true)
    end
end

local function OnEnterCombat(event, creature)
    creature:RegisterEvent(CastShadowWeaknessOnVictim, 5000, 0) -- every 5 seconds
    creature:RegisterEvent(CastShadowBoltOnVictim, 6000, 0) -- every 6 seconds
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

-- Register the event handlers for Nefarious Whelpling
RegisterCreatureEvent(NEFARIOUS_WHELPLING, 1, OnEnterCombat)
RegisterCreatureEvent(NEFARIOUS_WHELPLING, 2, OnLeaveCombat)
RegisterCreatureEvent(NEFARIOUS_WHELPLING, 4, OnCreatureDeath)
