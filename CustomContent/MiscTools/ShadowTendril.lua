-- Shadow Tendril entry ID
local SHADOW_TENDRIL = 401118

local SPELL_SHADOW_WORD_PAIN = 10892
local SPELL_MIND_BLAST = 10945
local SPELL_ON_SPAWN = 80000
local SPELL_STEALTH = 16592
local SET_POWER_VALUE = 10000

local function CastSlow(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), 30283, true)
end

local function CastShadowWordPain(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_WORD_PAIN, true)
end

local function CastMindBlast(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_MIND_BLAST, true)
end

local function OnEnterCombat(event, creature)
    creature:CastSpell(creature, SPELL_STEALTH, true)
    creature:CastSpell(creature, SPELL_ON_SPAWN, true)
	creature:RegisterEvent(CastSlow, 100, 1)
    creature:RegisterEvent(CastShadowWordPain, 100, 1)
    creature:RegisterEvent(CastShadowWordPain, 10000, 0)
    creature:RegisterEvent(CastMindBlast, 5000, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:CastSpell(creature, SPELL_STEALTH, true)
    creature:CastSpell(creature, SPELL_ON_SPAWN, true)
end

local function OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

local function OnCreatureSpawn(event, creature)
    creature:CastSpell(creature, SPELL_STEALTH, true)
    creature:CastSpell(creature, SPELL_ON_SPAWN, true)
end

local function OnCreatureReset(event, creature)
    creature:CastSpell(creature, SPELL_STEALTH, true)
    creature:CastSpell(creature, SPELL_ON_SPAWN, true)
end

RegisterCreatureEvent(SHADOW_TENDRIL, 1, OnEnterCombat)
RegisterCreatureEvent(SHADOW_TENDRIL, 2, OnLeaveCombat)
RegisterCreatureEvent(SHADOW_TENDRIL, 4, OnCreatureDeath)
RegisterCreatureEvent(SHADOW_TENDRIL, 5, OnCreatureSpawn)
RegisterCreatureEvent(SHADOW_TENDRIL, 23, OnCreatureReset)
