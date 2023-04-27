local RISEN_SPIRITS_ID = 23554
local RISEN_HUSKS_ID = 23555
local RESTLESS_SPIRITS_ID = 23861
local DESPAWN_TIME = 8000 -- 8 seconds in milliseconds

local function SpawnRestlessSpirit(event, creature, killer)
    if creature:GetEntry() == RISEN_SPIRITS_ID or creature:GetEntry() == RISEN_HUSKS_ID then
        local x, y, z, o = creature:GetLocation()
        local spawnedCreature = creature:SpawnCreature(RESTLESS_SPIRITS_ID, x, y, z, o, 3, DESPAWN_TIME)
    end
end

RegisterCreatureEvent(RISEN_SPIRITS_ID, 4, SpawnRestlessSpirit)
RegisterCreatureEvent(RISEN_HUSKS_ID, 4, SpawnRestlessSpirit)
