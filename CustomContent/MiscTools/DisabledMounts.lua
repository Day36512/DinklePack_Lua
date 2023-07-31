local function OnPlayerCastMountSpell(event, player, spell)
    local map = player:GetMap()
    if map and (map:IsDungeon() or map:IsBattleground()) then
        local spellId = spell:GetEntry()
        if spellId == 41515 or spellId == 60025 or spellId == 100150 or spellId == 80029 or spellId == 80097 or spellId == 100192 then
         --   player:InterruptSpell()
            spell:Cancel()
            player:StopSpellCast(spellId)
            player:SendBroadcastMessage("You cannot cast that spell in this map.")
        end
    end
end

RegisterPlayerEvent(5, OnPlayerCastMountSpell)
