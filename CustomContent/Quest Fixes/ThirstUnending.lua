local QUEST_ID = 8346
local SPELL_ID = 80025
local TARGET_CREATURE_ID = 15274

local function OnPlayerSpellCast(event, player, spell, skipCheck)
    -- Check if the spell casted is the one we are interested in
    if spell:GetEntry() == SPELL_ID then
        -- Check if the target of the spell is the creature with the ID we are interested in
        local target = spell:GetUnitTarget()
        if target and target:GetEntry() == TARGET_CREATURE_ID then
            -- Check if the player has the quest with the ID we are interested in
            if player:HasQuest(QUEST_ID) then
                -- Complete the quest for the player
                player:CompleteQuest(QUEST_ID)
            end
        end
    end
end

RegisterPlayerEvent(5, OnPlayerSpellCast) -- 5 is the PLAYER_EVENT_ON_SPELL_CAST
