-- Val'kyr Protector entry ID
local VALKYR_PROTECTOR = 401119
local SPELL_FLASH_HEAL = 10916
local SPELL_SMITE = 10933
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

local function CastFlashHealOnLowHealthUnit(eventId, delay, repeats, creature)
    local lowHealthUnit = FindLowHealthUnit(creature)

    if lowHealthUnit then
        creature:CastSpell(lowHealthUnit, SPELL_FLASH_HEAL, false)
    end
end

local function CastSmiteOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, SPELL_SMITE, false)
    end
end

local function OnEnterCombat(event, creature)
    creature:RegisterEvent(CastFlashHealOnLowHealthUnit, 6000, 0)
    creature:RegisterEvent(CastSmiteOnVictim, 5000, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

-- Register the event handlers for Val'kyr Protector
RegisterCreatureEvent(VALKYR_PROTECTOR, 1, OnEnterCombat)
RegisterCreatureEvent(VALKYR_PROTECTOR, 2, OnLeaveCombat)
RegisterCreatureEvent(VALKYR_PROTECTOR, 4, OnCreatureDeath)
