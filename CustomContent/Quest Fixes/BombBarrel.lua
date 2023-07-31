local SpellId = 80106
local QuestId = 30036
local CreatureId = 29692
local SpawnPosition = {-8936, 635, 98.88, 0}  
local SpawnDelay = 6000  
local DespawnDelay = 20 * 1000 

local function BARREL_OnSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == SpellId then
        local playerPos = {player:GetX(), player:GetY(), player:GetZ()}
        local distance = math.sqrt((playerPos[1] - SpawnPosition[1])^2 + (playerPos[2] - SpawnPosition[2])^2 + (playerPos[3] - SpawnPosition[3])^2)

        if distance <= 5 then
            player:CompleteQuest(QuestId)
            -- player:SendBroadcastMessage("Quest completed!")

            local function SpawnAndDespawnCreature(eventId, delay, repeats, worldobject)
                local spawnedCreature = worldobject:SpawnCreature(CreatureId, SpawnPosition[1], SpawnPosition[2], SpawnPosition[3], SpawnPosition[4], 3, DespawnDelay)
            end
            player:RegisterEvent(SpawnAndDespawnCreature, SpawnDelay, 1)  
        else
            spell:Cancel()
            player:SendBroadcastMessage("You need to be closer to the ladder to use that item.")
        end
    end
end

RegisterPlayerEvent(5, BARREL_OnSpellCast)


