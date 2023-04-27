local CREATURE_ID = 23841
local ITEM_ID = 33110
local ITEM_COUNT = 1
local REQUIRED_QUEST_ID = 1203

local CREATURE_ID = 23841
local REQUIRED_QUEST_ID = 1203

local function OnCreatureKill(event, player, creature)
    if creature:GetEntry() == CREATURE_ID and player:HasQuest(REQUIRED_QUEST_ID) then
		player:AddItem(ITEM_ID, ITEM_COUNT)
        player:CompleteQuest(REQUIRED_QUEST_ID)
    end
end

RegisterPlayerEvent(7, OnCreatureKill)
