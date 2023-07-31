local NPC_DEFIAS_RITUALIST = 100165
local SPELL_CAST_ON_SPAWN = 67040

local function DefiasRitualist_OnSpawn(event, creature)
    creature:CastSpell(creature, SPELL_CAST_ON_SPAWN, false)
end

local function DefiasRitualist_RecastSpell(event, delay, pCall, creature)
    creature:CastSpell(creature, SPELL_CAST_ON_SPAWN, false)
end

local function DefiasRitualist_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:RegisterEvent(DefiasRitualist_RecastSpell, 8000, 1) 
end

RegisterCreatureEvent(NPC_DEFIAS_RITUALIST, 5, DefiasRitualist_OnSpawn)
RegisterCreatureEvent(NPC_DEFIAS_RITUALIST, 2, DefiasRitualist_OnLeaveCombat)
