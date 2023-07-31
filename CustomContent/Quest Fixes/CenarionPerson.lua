
local NPC_CENARION_HOLD_SENTRY = 15184

local SPELL_ABILITY_ONE = 845  
local SPELL_ABILITY_TWO = 1680  

local function CastAbilities(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_ABILITY_ONE, true)
    creature:CastSpell(creature:GetVictim(), SPELL_ABILITY_TWO, true)
end

local function Sentry_OnEnterCombat(event, creature, target)
	creature:SendUnitYell("For Cenarion Hold!", 0)
    creature:RegisterEvent(CastAbilities, 4000, 0)
end

local function Sentry_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function Sentry_OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 1, Sentry_OnEnterCombat)
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 2, Sentry_OnLeaveCombat)
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 4, Sentry_OnDied)
