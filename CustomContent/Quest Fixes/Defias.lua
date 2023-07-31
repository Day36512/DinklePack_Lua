local DefiasID = 100163


local function Defias_OnEnterCombat(event, creature, target)
    creature:SendUnitSay("You can't have our explosives!", 0)
end

local function Defias_OnDied(event, creature, killer)
    creature:SendUnitSay("Ugh...our grand entrance is ruined...", 0)
end

RegisterCreatureEvent(DefiasID, 1, Defias_OnEnterCombat)
RegisterCreatureEvent(DefiasID, 4, Defias_OnDied)
