-- Constants for our script
local GAMEOBJECT_ID = 2883
local CREATURE_ID = 100168
local SPAWN_TYPE = TEMPSUMMON_TIMED_OR_DEAD_DESPAWN
local DESPAWN_TIMER = 60000  


local function PumpkinOnCreatureSpawn(event, creature)
    local player = creature:GetNearestPlayer()
    if player then
        creature:AttackStart(player)
        creature:SendUnitSay("You no take pumpkin!", 0)
    end
end

local function PumpkinOnGameObjectUse(event, go, player)
    local x, y, z, o = go:GetLocation()
    go:SpawnCreature(CREATURE_ID, x, y, z, o, SPAWN_TYPE, DESPAWN_TIMER)
end

RegisterGameObjectEvent(GAMEOBJECT_ID, 14, PumpkinOnGameObjectUse)
RegisterCreatureEvent(CREATURE_ID, 5, PumpkinOnCreatureSpawn)
