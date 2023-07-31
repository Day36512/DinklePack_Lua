local Patchqwerk = {};

local YELL_OPTIONS_COMBAT_ENTER = { 
    "Patchqwerk huuuuungry!", 
    "Time for a snack!", 
    "You're mine now!", 
    "You look delicious. Patchqwerk eat you now!", 
    "I not eat in days, time to feast!", 
    "Me smash and eat you now!", 
    "Me so hungry, me eat anything... even you!" 
}

local YELL_OPTIONS_COMBAT_LEAVE = { 
    "You not so tasty afterall...", 
    "I be back for seconds!", 
    "No more play? Too bad...", 
    "Maybe next time you taste better!",
    "Me still hungry, come back later!",
    "You not enough food, me go find more!", 
    "Aww...You no stay for dinner? You make Patchqwerk sad." 
}

function Patchqwerk.CastHatefulStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 28308, true)
end

function Patchqwerk.CastGore(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 48130, true)
end

function Patchqwerk.PoisonBoltVolley(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 25991, true)
end

local function SelectRandomYell(yellOptions)
    local randomIndex = math.random(1, #yellOptions)
    return yellOptions[randomIndex]
end

local function SendRandomYell(creature, yellOptions)
    if (math.random(1, 100) <= 25) then
        creature:SendUnitYell(SelectRandomYell(yellOptions), 0)
    end
end

function Patchqwerk.OnSpawn(event, creature)
    creature:SendUnitYell("Patchqwerk make Lich King proud! You die now!",0)
    creature:CastSpell(creature, 46587, true)
end

function Patchqwerk.OnEnterCombat(event, creature, target)
    SendRandomYell(creature, YELL_OPTIONS_COMBAT_ENTER)
    creature:RegisterEvent(Patchqwerk.PoisonBoltVolley, 7000, 0)
    creature:RegisterEvent(Patchqwerk.CastHatefulStrike, 15000, 0)
    creature:RegisterEvent(Patchqwerk.CastGore, 20000, 0)
end

function Patchqwerk.OnLeaveCombat(event, creature)
    SendRandomYell(creature, YELL_OPTIONS_COMBAT_LEAVE)

    creature:RemoveEvents()
end

function Patchqwerk.OnDied(event, creature, killer)
    creature:SendUnitYell("Patchqwerk forget to chew...", 0)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " ..creature:GetName().."!")
    end
    local x, y, z, o = creature:GetLocation()
    creature:SpawnCreature(400120, x, y, z, o, 3, 900000) 
    creature:RemoveEvents()
end

function Patchqwerk.CheckHealth(event, creature)
    if (creature:HealthBelowPct(20)) then
        creature:SendUnitYell("Patchqwerk go berserk!", 0)
        creature:CastSpell(creature, 41305, true)
    end
end

-- Registering events
RegisterCreatureEvent(400012, 1, Patchqwerk.OnEnterCombat)
RegisterCreatureEvent(400012, 2, Patchqwerk.OnLeaveCombat)
RegisterCreatureEvent(400012, 4, Patchqwerk.OnDied)
RegisterCreatureEvent(400012, 5, Patchqwerk.OnSpawn)
RegisterCreatureEvent(400012, 6, Patchqwerk.CheckHealth)
