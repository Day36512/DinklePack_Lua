local VGhoul = {}

local function CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 45462, true)
end

local function CastStun(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    local closeTargets = {}
    
    for _, target in pairs(targets) do
        if creature:GetDistance(target) <= 5 then
            table.insert(closeTargets, target)
        end
    end
    
    if #closeTargets > 0 then
        local randomTarget = closeTargets[math.random(1, #closeTargets)]
        creature:CastSpell(randomTarget, 56, true)
    end
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastPlague, math.random(8000, 12000), 0)
    creature:RegisterEvent(CastStun, math.random(10000, 15000), 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
    creature:PerformEmote(449)
end

RegisterCreatureEvent(400151, 1, OnEnterCombat)
RegisterCreatureEvent(400151, 2, OnLeaveCombat)
RegisterCreatureEvent(400151, 4, OnDied)
RegisterCreatureEvent(400151, 5, OnSpawn)
