local Magmadar = {}
Magmadar.spellQueue = {}

local SPELL_FRENZY = 19451
local SPELL_PANIC = 19408
local SPELL_LAVA_BOMB = 19411
local SPELL_LAVA_BOMB_RANGED = 20474
local SPELL_SUMMON_CORE_HOUND = 364726
local SPELL_ENRAGE = 27680

local MELEE_TARGET_LOOKUP_DIST = 10.0

function Magmadar.CastFrenzy(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_FRENZY, targetType = 'self', emote = "Magmadar goes into a killing Frenzy!"})
end

function Magmadar.CastPanic(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_PANIC, targetType = 'victim'})
end

function Magmadar.CastLavaBomb(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_LAVA_BOMB, targetType = 'random', range = MELEE_TARGET_LOOKUP_DIST, maxRange = false})
end

function Magmadar.CastLavaBombRanged(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_LAVA_BOMB_RANGED, targetType = 'random', range = MELEE_TARGET_LOOKUP_DIST, maxRange = true})
end

function Magmadar.CastSummonCoreHound(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_SUMMON_CORE_HOUND, targetType = 'self'})
end

function Magmadar.CastEnrage(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_ENRAGE, targetType = 'self', emote = "Magmadar becomes enraged, significantly increasing attack speed and damage!"})
end

function Magmadar.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Magmadar.spellQueue > 0 then
        local nextSpell = table.remove(Magmadar.spellQueue, 1)
        local target

        if nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                if nextSpell.maxRange then
                    for _, t in pairs(targets) do
                        if t:GetDistance(creature) > nextSpell.range then
                            target = t
                            break
                        end
                    end
                else
                    target = targets[math.random(1, #targets)]
                end
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
            if nextSpell.emote then
                creature:SendUnitEmote(nextSpell.emote)
            end
        end
    end
end

function Magmadar.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Magmadar.CastFrenzy, math.random(12000, 16000), 0)
    creature:RegisterEvent(Magmadar.CastPanic, math.random(20000, 25000), 0)
    creature:RegisterEvent(Magmadar.CastLavaBomb, math.random(8000, 10000), 0)
    creature:RegisterEvent(Magmadar.CastLavaBombRanged, math.random(6000, 9000), 0)
    creature:RegisterEvent(Magmadar.CastSummonCoreHound, 45000, 0)
    creature:RegisterEvent(Magmadar.CastEnrage, 180000, 1) -- 3 minute enrage timer
    creature:RegisterEvent(Magmadar.ProcessSpellQueue, 2000, 0)
end

function Magmadar.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Magmadar.spellQueue = {}
end

function Magmadar.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Magmadar.spellQueue = {}
end

RegisterCreatureEvent(11982, 1, Magmadar.OnEnterCombat)
RegisterCreatureEvent(11982, 2, Magmadar.OnLeaveCombat)
RegisterCreatureEvent(11982, 4, Magmadar.OnDied)
