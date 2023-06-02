local GameObjectId = 600010 -- GameObject Entry ID
local SpellId1 = 100273 -- First Spell Entry ID
local SpellId2 = 2481 -- Second Spell Entry ID
local ChanceToLearnSpell1 = 0.0055 
local ChanceToLearnSpell2 = 0.009 

-- This function will be called whenever our target GameObject is used.
local function OnGameObjectUse(event, go, player)
    local playerLevel = player:GetLevel()
    local ExperienceIncrease = 0

    -- Define experience increase based on player's level bracket
    if playerLevel <= 10 then
        ExperienceIncrease = playerLevel * 11 + 50
    elseif playerLevel <= 20 then
        ExperienceIncrease = playerLevel * 11 + 150 
    elseif playerLevel <= 30 then
        ExperienceIncrease = playerLevel * 11 + 250 
    elseif playerLevel <= 40 then
        ExperienceIncrease = playerLevel * 11 + 400 
    elseif playerLevel <= 50 then
        ExperienceIncrease = playerLevel * 11 + 520 
    elseif playerLevel < 60 then
        ExperienceIncrease = playerLevel * 1 + 625 
    end

    -- Give the calculated experience to the player.
    player:GiveXP(ExperienceIncrease)

    -- Broadcast to the player about their experience increase.
    player:SendBroadcastMessage("You've gained an additional " .. ExperienceIncrease .. " experience!")

    -- Check if player already has the first spell, if not, randomly decide if the player learns it
    if not player:HasSpell(SpellId1) and math.random() <= ChanceToLearnSpell1 then
        player:LearnSpell(SpellId1)
        player:SendBroadcastMessage("Your knack at finding stuff has really paid off! You've learned a new spell '|cffffffffFind Stuff|r'")
    end

    -- Check if player already has the second spell, if not, randomly decide if the player learns it
    if not player:HasSpell(SpellId2) and math.random() <= ChanceToLearnSpell2 then
        player:LearnSpell(SpellId2)
        player:SendBroadcastMessage("You've gained a new mount!")
    end
end

-- Register our function to be called when our target GameObject is used.
RegisterGameObjectEvent(GameObjectId, 14, OnGameObjectUse)
