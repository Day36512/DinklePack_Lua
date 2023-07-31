local function OnPlayerKillCreature(event, killer, killed)
    if (killed:GetEntry() == 1412) then
        killer:AddItem(800071, 1)
    elseif (killed:GetEntry() == 4075) then
        killer:AddItem(800072, 1)
    end
end

RegisterPlayerEvent(7, OnPlayerKillCreature)
