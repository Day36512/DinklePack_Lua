CoreRager = {}

-- Functiont to cast mangle, skipcheck set to true
function CoreRager.CastMangle(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19820, true)
end

-- Function to induce a spell cast on damage tkaen. When creature reaches 50%, will heal to full
function CoreRager.OnDamageTaken(event, creature, attacker, damage)
if creature:GetHealthPct() < 50 then
creature:CastSpell(creature, 17683, true)
creature:SendUnitEmote("Core Rager refuses to die while its master is in trouble.", 0) -- broadcasts raid-wide emote
end
end

-- function to register on entering combat
function CoreRager.OnEnterCombat(event, creature, target)
creature:RegisterEvent(CoreRager.CastMangle, 7000, 0)
end

function CoreRager.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function CoreRager.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function CoreRager.OnSpawn(event, creature)
creature:SetMaxHealth(200000)
end

-- This is a function to kill the corehounds when Golemagg dies. 
function CoreRager.OnGolemaggDeath(event, creature, boss)
local coreRagers = creature:GetCreaturesInRange(1000, 11672) -- searches for core ragers in range when golemagg dies. 
for _, coreRager in pairs(coreRagers) do
coreRager:CastSpell(coreRager, 13520, true) -- quiet suicide spell to cast on self
end
end

RegisterCreatureEvent(11672, 1, CoreRager.OnEnterCombat)
RegisterCreatureEvent(11672, 2, CoreRager.OnLeaveCombat)
RegisterCreatureEvent(11672, 4, CoreRager.OnDied)
RegisterCreatureEvent(11672, 5, CoreRager.OnSpawn)
RegisterCreatureEvent(11672, 9, CoreRager.OnDamageTaken)

RegisterCreatureEvent(11988, 4, CoreRager.OnGolemaggDeath)