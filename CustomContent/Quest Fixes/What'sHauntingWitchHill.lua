local RISEN_SPIRITS_ID = 23554
local RISEN_HUSKS_ID = 23555
local RESTLESS_SPIRITS_ID = 23861
local DESPAWN_TIME = 8000 -- 8 seconds in milliseconds
local RANGE_TO_GIVE_CREDIT = 30

local function GiveKillCredit(eventId, delay, repeats, player)
    if player then
        player:KilledMonsterCredit(RESTLESS_SPIRITS_ID)
    end
end

local function SpawnRestlessSpirit(event, creature, killer)
    if creature:GetEntry() == RISEN_SPIRITS_ID or creature:GetEntry() == RISEN_HUSKS_ID then
        local x, y, z, o = creature:GetLocation()
        local spawnedCreature = creature:SpawnCreature(RESTLESS_SPIRITS_ID, x, y, z, o, 3, DESPAWN_TIME)

        if spawnedCreature then
            local playersInRange = creature:GetPlayersInRange(RANGE_TO_GIVE_CREDIT)

            for _, player in pairs(playersInRange) do
                if player:IsPlayer() then
                    player:RegisterEvent(GiveKillCredit, 2000, 1)
                end
            end
        end
    end
end

RegisterCreatureEvent(RISEN_SPIRITS_ID, 4, SpawnRestlessSpirit)
RegisterCreatureEvent(RISEN_HUSKS_ID, 4, SpawnRestlessSpirit)
