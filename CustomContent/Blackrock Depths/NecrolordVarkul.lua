local ENTRY_NEcROLORD_VARKUL = 400125 

-- Spell IDs
local SPELL_SHADOW_BOLT       = 12739
local SPELL_FROST_NOVA        = 9915
local SPELL_FROST_ARMOR       = 10220
local SPELL_RAISE_DEAD        = 52478 
local SPELL_BLINK             = 1953

-- Yell IDs
local YELL_AGGRO              = "The Scourge shall consume all who dare enter these depths!"
local YELL_RAISE_DEAD         = "Rise, my minions! Feast on their flesh!"
local YELL_KILLED_PLAYER      = "Your soul now belongs to the Scourge!"

local function CastShadowBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_BOLT, false)
end

local function CastFrostNova(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_FROST_NOVA, true)
end

local function CastFrostArmor(event, delay, pCall, creature)
    creature:CastSpell(creature, SPELL_FROST_ARMOR, true)
end

local function CastRaiseDead(event, delay, pCall, creature)
    creature:SendUnitYell(YELL_RAISE_DEAD, 0)
    creature:CastSpell(creature, SPELL_RAISE_DEAD, true)
end

local function CastBlink(event, delay, pCall, creature)
    creature:CastSpell(creature, SPELL_BLINK, true)
    local nearestCreature = creature:GetNearestPlayer(30, 1)
    if nearestCreature ~= nil then
        creature:AttackStart(nearestCreature)
    end
end

local function EnterCombat(event, creature, target)
    creature:SendUnitYell(YELL_AGGRO, 0)
    creature:RegisterEvent(CastShadowBolt, math.random(4000, 6000), 0)
    creature:RegisterEvent(CastFrostNova, math.random(10000, 14000), 0)
    creature:RegisterEvent(CastFrostArmor, 1000, 1)
    creature:RegisterEvent(CastRaiseDead, math.random(13000, 17000), 0)
    creature:RegisterEvent(CastBlink, math.random(16000, 20000), 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function KilledPlayer(event, creature, victim)
    creature:SendUnitYell(YELL_KILLED_PLAYER, 0)
end

local function JustDied(event, creature, killer)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
    creature:SetEquipmentSlots(60132, 0, 0)
end

RegisterCreatureEvent(ENTRY_NEcROLORD_VARKUL, 1, EnterCombat)
RegisterCreatureEvent(ENTRY_NEcROLORD_VARKUL, 2, OnLeaveCombat)
RegisterCreatureEvent(ENTRY_NEcROLORD_VARKUL, 3, KilledPlayer)
RegisterCreatureEvent(ENTRY_NEcROLORD_VARKUL, 4, JustDied)
RegisterCreatureEvent(ENTRY_NEcROLORD_VARKUL, 5, OnSpawn)
