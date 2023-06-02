local VALK_GUARD = 600018
local SPELL_FLASH_OF_LIGHT = 19942
local HAMMER_OF_WRATH = 24275
local HOLY_NOVA = 27799
local AVENGING_WRATH = 31884
local HEALTH_PERCENT_THRESHOLD = 90
local SEARCH_RANGE = 40
local MIN_CREATURE_ENTRY = 70000
local MAX_CREATURE_ENTRY = 81000

local function FindLowHealthUnit(creature)
    local lowHealthUnit = nil
    local minHealthPercent = HEALTH_PERCENT_THRESHOLD

    for _, unit in ipairs(creature:GetFriendlyUnitsInRange(SEARCH_RANGE)) do
        local unitEntry = unit:GetEntry()
        local isPlayer = unit:IsPlayer()
        local isCreatureInRange = (unitEntry >= MIN_CREATURE_ENTRY) and (unitEntry <= MAX_CREATURE_ENTRY)
        if isPlayer or isCreatureInRange then
            local healthPercent = (unit:GetHealth() / unit:GetMaxHealth()) * 100
            if healthPercent < minHealthPercent then
                minHealthPercent = healthPercent
                lowHealthUnit = unit
            end
        end
    end

    return lowHealthUnit
end

local function CastFOLowHealthUnit(eventId, delay, repeats, creature)
    local lowHealthUnit = FindLowHealthUnit(creature)

    if lowHealthUnit then
        creature:CastSpell(lowHealthUnit, SPELL_FLASH_OF_LIGHT, true)
    end
end

local function CastHammerVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, HAMMER_OF_WRATH, true)
    end
end

local function CastHolyNova(eventId, delay, repeats, creature)
    creature:CastSpell(creature, HOLY_NOVA, true)
end

local function OnSpawn(event, creature)
    local owner = creature:GetOwner()
    if owner then
        owner:AddAura(AVENGING_WRATH, owner)
    end
end

local function OnEnterCombat(event, creature)
    creature:RegisterEvent(CastFOLowHealthUnit, math.random(3000, 7000), 0)
    creature:RegisterEvent(CastHammerVictim, math.random(4000, 7000), 0)
    creature:RegisterEvent(CastHolyNova, math.random(4000, 9000), 0)
end
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end


RegisterCreatureEvent(VALK_GUARD, 1, OnEnterCombat)
RegisterCreatureEvent(VALK_GUARD, 2, OnLeaveCombat)
RegisterCreatureEvent(VALK_GUARD, 4, OnCreatureDeath)
RegisterCreatureEvent(VALK_GUARD, 5, OnSpawn)