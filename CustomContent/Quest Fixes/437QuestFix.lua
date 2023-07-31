local function OnLootItem(event, player, item, count)
    local ITEM_ID = 3622
    local QUEST_ID = 437

    if item:GetEntry() == ITEM_ID then
        if player:HasQuest(QUEST_ID) then
            player:CompleteQuest(QUEST_ID)
        end
    end
end

RegisterPlayerEvent(32, OnLootItem)
