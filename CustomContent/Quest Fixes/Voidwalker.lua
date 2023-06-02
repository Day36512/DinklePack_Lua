local SPELL_ID = 7728  
local NPC_ENTRY = 5676  
local SUMMON_DISTANCE = 5  
local DESPAWN_TIMER = 60000 

local function SummonVoidwalker(event, player, spell, skipCheck)
    if spell:GetEntry() == SPELL_ID then
        local x, y, z, o = player:GetLocation()
        x = x + math.cos(o) * SUMMON_DISTANCE
        y = y + math.sin(o) * SUMMON_DISTANCE
        player:SpawnCreature(NPC_ENTRY, x, y, z, o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, DESPAWN_TIMER)
    end
end

RegisterPlayerEvent(5, SummonVoidwalker)
