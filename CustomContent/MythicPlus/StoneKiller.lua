local function OnKillCreature(event, killer, killed)
    local creatureEntry = killed:GetEntry()
    if killer:GetMap():IsDungeon() and creatureEntry >= 1 and creatureEntry <= 30000 and creatureEntry ~= 4075 then
        local creaturesInRange = killer:GetCreaturesInRange(100)
        for i, creature in ipairs(creaturesInRange) do
            if creature:GetEntry() == 900001 then
                creature:DespawnOrUnsummon()
                killer:SendBroadcastMessage("The Mythic Keystone has vanished...")
                break
            end
        end
    end
end

RegisterPlayerEvent(7, OnKillCreature)
