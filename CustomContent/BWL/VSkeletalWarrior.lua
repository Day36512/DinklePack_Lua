local VSkeletalWarrior = {}

local function CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 15496, true)
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastCleave, math.random(8000, 12000), 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
    creature:CastSpell(creature, 51908, true)
end

RegisterCreatureEvent(400150, 1, OnEnterCombat)
RegisterCreatureEvent(400150, 2, OnLeaveCombat)
RegisterCreatureEvent(400150, 4, OnDied)
RegisterCreatureEvent(400150, 5, OnSpawn)
