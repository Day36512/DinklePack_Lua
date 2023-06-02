local function PVP_OnPlayerCastSpell(event, player, spell, skipCheck)
    local spellID = spell:GetEntry()
    if spellID ~= 89998 then
        return
    end
    
    local map = player:GetMap()
    if map:IsDungeon() or map:IsBattleground() or map:IsArena() or map:IsRaid() then
        spell:Cancel()
        player:StopSpellCast(89998)
    end
end

local function PVP_OnPlayerChangeMap(event, player)
    if not player:HasAura(89998) then
        return
    end
    
    local map = player:GetMap()
    if map:IsDungeon() or map:IsBattleground() or map:IsRaid() or map:IsArena() then
        player:RemoveAura(89998)
    end
end

RegisterPlayerEvent(28, PVP_OnPlayerChangeMap)
RegisterPlayerEvent(5, PVP_OnPlayerCastSpell)
