local Lucifron = {}
Lucifron.enrageCasted = false

function Lucifron.CastImpendingDoom(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19702, false)
end

function Lucifron.CastLucifronCurse(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19703, false)
end

function Lucifron.CastShadowShock(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 20603, false)
end

function Lucifron.CastFlamestrike(eventId, delay, calls, creature)
local targets = creature:GetAITargets()
local targetCount = creature:GetAITargetsCount()
local randomTarget = targets[math.random(1, targetCount)]
creature:CastSpell(randomTarget, 10216, true)
end

function Lucifron.CastChaosNova(eventId, delay, calls, creature)
creature:CastSpell(creature, 30852, false)
end

function Lucifron.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Lucifron.CastImpendingDoom, math.random(4000, 8000), 0) -- Reduced delay for Impending Doom
creature:RegisterEvent(Lucifron.CastLucifronCurse, math.random(8000, 12000), 0) -- Reduced delay for Lucifron Curse
creature:RegisterEvent(Lucifron.CastShadowShock, 5000, 0) -- Reduced delay for Shadow Shock
creature:RegisterEvent(Lucifron.CastFlamestrike, 12000, 0) -- Reduced delay for Flamestrike
creature:RegisterEvent(Lucifron.CastChaosNova, 180000, 0) -- Added new ability: Chaos Nova
end

function Lucifron.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Lucifron.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Lucifron.OnDamageTaken(event, creature, attacker, damage)
if(not Lucifron.enrageCasted and creature:HealthBelowPct(30)) then -- Enrage triggers at 30% health
creature:CastSpell(creature, 38166, true)
Lucifron.enrageCasted = true
end
end

function Lucifron.OnSpawn(event, creature)
--creature:SetMaxHealth(748000 * 1.25) -- Increase health pool by 25%
end

RegisterCreatureEvent(12118, 1, Lucifron.OnEnterCombat)
RegisterCreatureEvent(12118, 2, Lucifron.OnLeaveCombat)
RegisterCreatureEvent(12118, 4, Lucifron.OnDied)
RegisterCreatureEvent(12118, 9, Lucifron.OnDamageTaken)
RegisterCreatureEvent(12118, 5, Lucifron.OnSpawn)