local LitheStalker = {};

local function CastWhirlingTip(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 24048, true)
end

local function CastSweepingSlam(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 53399, true)
end

function LitheStalker.OnEnterCombat(event, creature, target)
    if math.random(1, 100) <= 25 then
        creature:SendUnitYell("The Master will have your guts!", 0)
    end
    creature:RegisterEvent(CastWhirlingTip, 5000, 0)
    creature:RegisterEvent(CastSweepingSlam, 10000, 0)
end

function LitheStalker.OnLeaveCombat(event, creature)
    if math.random(1, 100) <= 25 then
        creature:SendUnitSay("Mmmm....", 0)
    end
    creature:RemoveEvents()
end

function LitheStalker.OnDied(event, creature, killer)
if(killer:GetObjectType() == "Player") then
killer:SendBroadcastMessage("You killed " ..creature:GetName().."!")
end
creature:RemoveEvents()
end

RegisterCreatureEvent(400015, 1, LitheStalker.OnEnterCombat)
RegisterCreatureEvent(400015, 2, LitheStalker.OnLeaveCombat)
RegisterCreatureEvent(400015, 4, LitheStalker.OnDied)