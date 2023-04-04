local StonekeeperEntry = 4857
local AltarOfTheKeepersEntry = 130511
local HostileFaction = 14 

local function StonekeepersBecomingHostile(player, stonekeeper, attack)
    if stonekeeper and stonekeeper:IsAlive() and not stonekeeper:IsInCombat() then
        stonekeeper:SetFaction(HostileFaction)
        stonekeeper:SetReactState(1) 
        if attack then
            stonekeeper:AttackStart(player)
        else
            stonekeeper:SetInCombatWith(player) 
        end
    end
end

local function StonekeeperDied(event, creature, killer)
    local stonekeepers = killer:GetCreaturesInRange(50, StonekeeperEntry)
    for _, stonekeeper in ipairs(stonekeepers) do
        if not stonekeeper:IsInCombat() then
            StonekeepersBecomingHostile(killer, stonekeeper, true)
            break
        end
    end
end

local function AltarOfTheKeepersUse(event, go, player)
    if not player:IsInCombat() then
        player:SendBroadcastMessage("The Stonekeepers are waking up...")

        local stonekeepers = player:GetCreaturesInRange(50, StonekeeperEntry)

        for i, stonekeeper in ipairs(stonekeepers) do
            if i == 1 then
                StonekeepersBecomingHostile(player, stonekeeper, true)
            else
                StonekeepersBecomingHostile(player, stonekeeper, false)
            end
        end
    else
        player:SendBroadcastMessage("You cannot use the Altar of the Keepers while in combat.")
    end
    return true
end

RegisterGameObjectEvent(AltarOfTheKeepersEntry, 14, AltarOfTheKeepersUse)
RegisterCreatureEvent(StonekeeperEntry, 5, StonekeeperDied)
