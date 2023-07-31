local NPC_AVERY = 100164
local SPELL_CAST_ON_SPAWN = 67040
local SPELL_SHADOW_BOLT = 695

local function Avery_OnSpawn(event, creature)
    creature:CastSpell(creature, SPELL_CAST_ON_SPAWN, false)
end

local function Avery_ShadowBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_BOLT, false)
end

local function Avery_RecastSpell(event, delay, pCall, creature)
    creature:CastSpell(creature, SPELL_CAST_ON_SPAWN, false)
end

local function Avery_OnEnterCombat(event, creature)
    creature:SendUnitYell("I will not permit you to interfere!", 0)
    creature:RegisterEvent(Avery_ShadowBolt, 3000, 0) -- Cast Shadow Bolt every 3 seconds
end

local function Avery_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:RegisterEvent(Avery_RecastSpell, 8000, 1) -- Recast the spell 5 seconds after leaving combat
end

local function Avery_OnDied(event, creature)
    creature:RemoveEvents()
    creature:SendUnitSay("We were so...close....", 0)
end

RegisterCreatureEvent(NPC_AVERY, 5, Avery_OnSpawn)
RegisterCreatureEvent(NPC_AVERY, 1, Avery_OnEnterCombat)
RegisterCreatureEvent(NPC_AVERY, 2, Avery_OnLeaveCombat)
RegisterCreatureEvent(NPC_AVERY, 4, Avery_OnDied)
