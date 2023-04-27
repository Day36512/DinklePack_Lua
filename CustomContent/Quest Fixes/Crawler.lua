local CRAWLER_BOI = 3812

local function CastClaw(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 16829, true)
end
    
local function CrawlerBoi_OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastClaw, 4000, 0)
end

local function CrawlerBoi_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function CrawlerBoi_OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(CRAWLER_BOI, 1, CrawlerBoi_OnEnterCombat)
RegisterCreatureEvent(CRAWLER_BOI, 2, CrawlerBoi_OnLeaveCombat)
RegisterCreatureEvent(CRAWLER_BOI, 4, CrawlerBoi_OnDied)
