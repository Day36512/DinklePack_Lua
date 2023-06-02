local NPCID = 28377


local function OnQuestAccept(event, player, creature, quest)
    if quest:GetId() == 12701 then
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:Teleport(609, 2263.189, -6200.54, 13.16, 1.78) -- Teleport to new location
        player:RegisterEvent(ResetPlayerDisplayId, 19800, 1) -- Adjust the delay time based on how long it takes to reach the destination
    end
end

RegisterCreatureEvent(NPCID, 31, OnQuestAccept)
