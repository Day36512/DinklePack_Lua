local Magmadar = {};

local SPELL_FRENZY = 19451
local SPELL_PANIC = 19408
local SPELL_LAVA_BOMB = 19411
local SPELL_LAVA_BOMB_RANGED = 20474
local SPELL_SUMMON_CORE_HOUND = 364726
local SPELL_ENRAGE = 27680

local MELEE_TARGET_LOOKUP_DIST = 10.0

function Magmadar.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Magmadar.Frenzy, math.random(12000, 16000), 0)
creature:RegisterEvent(Magmadar.Panic, math.random(20000, 25000), 0)
creature:RegisterEvent(Magmadar.LavaBomb, math.random(8000, 10000), 0)
creature:RegisterEvent(Magmadar.LavaBombRanged, math.random(6000, 9000), 0)
creature:RegisterEvent(Magmadar.CastSummonCoreHound, 45000, 0)
creature:RegisterEvent(Magmadar.Enrage, 180000, 1) -- 3 minute enrage timer
end

function Magmadar.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Magmadar.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Magmadar.Frenzy(event, delay, calls, creature)
creature:CastSpell(creature, SPELL_FRENZY, false)
creature:SendUnitEmote("Magmadar goes into a killing Frenzy!")
end

function Magmadar.Panic(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), SPELL_PANIC, false)
end

function Magmadar.LavaBomb(event, delay, calls, creature)
local targets = creature:GetAITargets()
local targetCount = creature:GetAITargetsCount()
if targetCount > 0 then
local targetIndex = math.random(1, targetCount)
local target = targets[targetIndex]
if target:GetDistance(creature) <= MELEE_TARGET_LOOKUP_DIST then
creature:CastSpell(target, SPELL_LAVA_BOMB, false)
end
end
end

function Magmadar.LavaBombRanged(event, delay, calls, creature)
local targets = creature:GetPlayersInRange(100.0)
for _, target in pairs(targets) do
if target:GetDistance(creature) > MELEE_TARGET_LOOKUP_DIST then
creature:CastSpell(target, SPELL_LAVA_BOMB_RANGED, false)
break
end
end
end

function Magmadar.CastSummonCoreHound(event, delay, calls, creature)
creature:CastSpell(creature, SPELL_SUMMON_CORE_HOUND, true)
end

function Magmadar.Enrage(event, delay, calls, creature)
creature:CastSpell(creature, SPELL_ENRAGE, false)
creature:SendUnitEmote("Magmadar becomes enraged, significantly increasing attack speed and damage!")
end

RegisterCreatureEvent(11982, 1, Magmadar.OnEnterCombat)
RegisterCreatureEvent(11982, 2, Magmadar.OnLeaveCombat)
RegisterCreatureEvent(11982, 4, Magmadar.OnDied)