local NPC_BONE_CONSTRUCT = 14605 
local SPELL_EXPLOIT_WEAKNESS = 8355

local function ExploitWeakness(eventId, delay, repeats, creature)
    local target = creature:GetVictim()

    if target then
        creature:CastSpell(target, SPELL_EXPLOIT_WEAKNESS, false)
    end
end

local function OnSpawn(event, creature)
    local playersInRange = creature:GetPlayersInRange(100, 1) -- 100 yards range, hostile players

    for _, player in pairs(playersInRange) do
        creature:AttackStart(player)
        break -- Attack only one player
    end
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(ExploitWeakness, 6000, 0) -- Every 6 seconds
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_BONE_CONSTRUCT, 5, OnSpawn) 
RegisterCreatureEvent(NPC_BONE_CONSTRUCT, 1, OnEnterCombat) 
RegisterCreatureEvent(NPC_BONE_CONSTRUCT, 2, OnLeaveCombat) 
