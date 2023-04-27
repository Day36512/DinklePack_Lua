Golemagg = {}

function Golemagg.CastPyroblast(eventId, delay, calls, creature)
local targets = creature:GetAITargets()
local target = targets[math.random(#targets)]
creature:CastSpell(target, 20228, true)
end

function Golemagg.CastEarthquake(eventId, delay, calls, creature)
creature:CastSpell(creature, 19798, false)
delay = math.max(5000, delay * 0.9) -- Decrease the delay by 10% each time, with a minimum delay of 4 seconds
creature:RegisterEvent(Golemagg.CastEarthquake, delay, 0)
end

function Golemagg.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Golemagg.CastPyroblast, math.random(3000, 7000), 0)
creature:RegisterEvent(Golemagg.CastEarthquake, 24000, 0) -- Schedule the first Earthquake
creature:CastSpell(creature, 13879, true)
creature:CastSpell(creature, 20556, true)
creature:CastSpell(creature, 18943, true)
end

function Golemagg.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Golemagg.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Golemagg.OnSpawn(event, creature)
--creature:SetMaxHealth(1652176)
end

RegisterCreatureEvent(11988, 1, Golemagg.OnEnterCombat)
RegisterCreatureEvent(11988, 2, Golemagg.OnLeaveCombat)
RegisterCreatureEvent(11988, 4, Golemagg.OnDied)
RegisterCreatureEvent(11988, 5, Golemagg.OnSpawn)
