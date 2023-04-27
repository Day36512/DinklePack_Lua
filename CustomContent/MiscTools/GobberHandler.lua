local GOBBER_ENTRY = 36613
local SUMMON_SPELL = 69046

local function OnSpellCast(event, player, spell)
    if spell:GetEntry() == SUMMON_SPELL then
        local x, y, z, o = player:GetLocation()
        local gobber = player:SpawnCreature(GOBBER_ENTRY, x, y, z, o, 3, 60000) -- 3 for TEMPSUMMON_TIMED_DESPAWN, 60000 ms (1 minute) for despawnTimer
        if gobber then
            gobber:MoveFollow(player, 1, math.pi / 2)
        end
    end
end

RegisterPlayerEvent(5, OnSpellCast)
