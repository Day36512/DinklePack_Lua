local DeathTalonWyrmGuard = {}

function DeathTalonWyrmGuard.CastAbility1(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 845, false)
end

function DeathTalonWyrmGuard.CastAbility2(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 5164, false)
end

function DeathTalonWyrmGuard.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DeathTalonWyrmGuard.CastAbility1, math.random(8000, 15000), 0)
    creature:RegisterEvent(DeathTalonWyrmGuard.CastAbility2, math.random(20000, 25000), 0)
end

function DeathTalonWyrmGuard.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DeathTalonWyrmGuard.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400148, 1, DeathTalonWyrmGuard.OnEnterCombat)
RegisterCreatureEvent(400148, 2, DeathTalonWyrmGuard.OnLeaveCombat)
RegisterCreatureEvent(400148, 4, DeathTalonWyrmGuard.OnDied)
