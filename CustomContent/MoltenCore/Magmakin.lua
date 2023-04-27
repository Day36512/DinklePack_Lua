Magmakin = {}

function Magmakin.CastFlameBuffet(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 23341, false)
end
end

function Magmakin.CastMagmaBlast(eventId, delay, calls, creature)
if not creature:IsCasting() then
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 20565, false)
end
end

function Magmakin.CastLavaBurst(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 49232, false)
end
end

function Magmakin.CastFireNova(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature, 23462, false)
end
end

function Magmakin.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Magmakin.CastFlameBuffet, 16000, 0) -- Reduced delay for Flame Buffet
creature:RegisterEvent(Magmakin.CastMagmaBlast, 10000, 0) -- Reduced delay for Magma Blast
creature:RegisterEvent(Magmakin.CastLavaBurst, 6000, 0) 
creature:RegisterEvent(Magmakin.CastFireNova, 20000, 0) -- Added new ability: Fire Nova
end

function Magmakin.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Magmakin.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Magmakin.OnSpawn(event, creature)
creature:SetMaxPower(0, 10000000)
--creature:SetMaxHealth(349000 * 1.5) -- Increase health pool by 50%
end

RegisterCreatureEvent(12806, 1, Magmakin.OnEnterCombat)
RegisterCreatureEvent(12806, 2, Magmakin.OnLeaveCombat)
RegisterCreatureEvent(12806, 4, Magmakin.OnDied)
RegisterCreatureEvent(12806, 5, Magmakin.OnSpawn)