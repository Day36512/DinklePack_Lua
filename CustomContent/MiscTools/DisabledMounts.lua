local function OnPlayerCastSpell(event, player, spell)
    local map = player:GetMap()
    if map and (map:IsDungeon() or map:IsBattleground()) then
        local spellId = spell:GetEntry()
        if spellId == 41515 or spellId == 60025 or spellId == 100150 then
            spell:Cancel()
            player:SendBroadcastMessage("You cannot cast that spell in this map.")
        end
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell) -- PLAYER_EVENT_ON_CAST_SPELL
