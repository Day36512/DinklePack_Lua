local SEARCH_RANGE = 40
local CREATURE_ENTRIES = {4344, 4345}
local KILL_CREDIT = 23811
local TOTEM_CREATURE = 23811

local function OnCreatureDied(event, creature, killer)
    local totemsInRange = creature:GetCreaturesInRange(SEARCH_RANGE, TOTEM_CREATURE)
    
    for _, totem in ipairs(totemsInRange) do
        if creature:GetDistance(totem) <= SEARCH_RANGE then
            local playersInRange = totem:GetPlayersInRange(SEARCH_RANGE, 0, 1)
            
            for _, player in ipairs(playersInRange) do
                local owner = totem:GetOwner()
                if owner and owner:GetGUID() == player:GetGUID() then
                    player:KilledMonsterCredit(KILL_CREDIT)
                end
            end
        end
    end
end

for _, entry in ipairs(CREATURE_ENTRIES) do
    RegisterCreatureEvent(entry, 4, OnCreatureDied)
end
