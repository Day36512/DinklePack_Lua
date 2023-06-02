-- Cenarion Hold Sentry (NPC ID: 15184)
local NPC_CENARION_HOLD_SENTRY = 15184

-- This function will be called when the NPC enters combat.
local function OnEnterCombat(event, creature, target)
    creature:SendUnitYell("For Cenarion Hold!", 0)
    -- Add more custom combat code here if necessary.
end

-- This function will be called when the NPC leaves combat.
local function OnLeaveCombat(event, creature)
    -- Add your custom code here.
end

-- This function will be called when the NPC's target dies.
local function OnTargetDied(event, creature, victim)
    creature:SendUnitSay("Another enemy falls!", 0)
    -- Add more custom code here if necessary.
end

-- This function will be called when the NPC dies.
local function OnDied(event, creature, killer)
    -- Add your custom code here.
end

-- Register the event handlers.
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 1, OnEnterCombat)
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 2, OnLeaveCombat)
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 3, OnTargetDied)
RegisterCreatureEvent(NPC_CENARION_HOLD_SENTRY, 4, OnDied)
