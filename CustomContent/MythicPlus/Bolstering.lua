local function OnKillCreature(event, killer, killed)
    if killer:HasAura(107093) then
        local creaturesInRange = killed:GetCreaturesInRange(25)
        for _, creature in pairs(creaturesInRange) do
            if creature:GetEntry() < 70000 or creature:GetEntry() > 82000 then
                creature:CastSpell(creature, 107092, true)
                creature:CastSpell(creature, 28126, true)
            end
        end
    else
    end
end

RegisterPlayerEvent(7, OnKillCreature)
