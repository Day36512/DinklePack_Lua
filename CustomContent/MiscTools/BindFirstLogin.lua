local function OnFirstLogin(event, player)
    player:CastSpell(player, 26, true)
end

RegisterPlayerEvent(30, OnFirstLogin)
