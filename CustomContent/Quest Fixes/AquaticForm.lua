local function OnQuestComplete(event, player, quest)
    if quest:GetId() == 5061 or quest:GetId() == 31 then
        player:LearnSpell(1066)
    end
end

RegisterPlayerEvent(54, OnQuestComplete)
