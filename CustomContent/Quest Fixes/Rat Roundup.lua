local PLAYER_SPELL = 21050
local QUEST_TO_COMPLETE = 6661
local CREATURE_TO_CHECK = 12997
local CHECK_RANGE = 4.0

local playerSpellCastCount = {}
local checkRangeEventId = nil

local function IsCreatureInRange(player, creatureEntry, range)
    local creatures = player:GetCreaturesInRange(range, creatureEntry, 2) -- 2 for friendly
    return #creatures > 0
end

local function CheckRange(eventId, delay, repeats)
    for playerGuid, count in pairs(playerSpellCastCount) do
        if count >= 5 then
            local player = GetPlayerByGUID(playerGuid)
            if player and player:HasQuest(QUEST_TO_COMPLETE) then
                if IsCreatureInRange(player, CREATURE_TO_CHECK, CHECK_RANGE) then
                    player:CompleteQuest(QUEST_TO_COMPLETE)
                    playerSpellCastCount[playerGuid] = 0
                end
            end
        end
    end
end

RegisterPlayerEvent(5, function(_, player, spell)
    if spell:GetEntry() == PLAYER_SPELL then
        local playerGuid = player:GetGUIDLow()

        if not playerSpellCastCount[playerGuid] then
            playerSpellCastCount[playerGuid] = 0
        end

        playerSpellCastCount[playerGuid] = playerSpellCastCount[playerGuid] + 1

        if playerSpellCastCount[playerGuid] >= 5 and not checkRangeEventId then
            checkRangeEventId = CreateLuaEvent(CheckRange, 1000, 0)
        end
    end
end)
