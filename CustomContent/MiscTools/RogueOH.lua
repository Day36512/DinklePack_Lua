local function EquipDaggerOnRogue(event, player)
    if player:GetClass() == 4 then
        player:EquipItem(20982, 16)
    end
end

RegisterPlayerEvent(1, EquipDaggerOnRogue)
