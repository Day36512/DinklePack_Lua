local StonekeeperEntry = 4857
local AltarOfTheKeepersEntry = 130511
local HostileFaction = 14 
local DoorEntry = 124367

local function StonekeepersBecomingHostile(target, stonekeeper, attack)
    if stonekeeper and stonekeeper:IsAlive() and not stonekeeper:IsInCombat() then
        stonekeeper:SetFaction(HostileFaction)
        stonekeeper:SetReactState(1) 
        if attack then
            stonekeeper:AttackStart(target)
        else
            stonekeeper:SetInCombatWith(target) 
        end
    end
end

local function compareDistance(a, b)
    return a.distance < b.distance
end

local function getSortedStonekeepers(target, stonekeepers)
    local sortedStonekeepers = {}
    for _, stonekeeper in ipairs(stonekeepers) do
        table.insert(sortedStonekeepers, {creature = stonekeeper, distance = target:GetDistance(stonekeeper)})
    end
    table.sort(sortedStonekeepers, compareDistance)
    return sortedStonekeepers
end

local function getNearestTarget(creature, range)
    local nearestTarget = nil
    local minDistance = math.huge
    local targets = creature:GetPlayersInRange(range)
    for _, target in ipairs(targets) do
        local distance = creature:GetDistance(target)
        if distance < minDistance then
            minDistance = distance
            nearestTarget = target
        end
    end
    return nearestTarget
end

local function StonekeeperDied(event, creature)
    local nearestTarget = getNearestTarget(creature, 100)
    if not nearestTarget then return end
    
    local stonekeepers = nearestTarget:GetCreaturesInRange(100, StonekeeperEntry)
    local sortedStonekeepers = getSortedStonekeepers(nearestTarget, stonekeepers)
    local aliveCount = 0

    for _, stonekeeperData in ipairs(sortedStonekeepers) do
        local stonekeeper = stonekeeperData.creature
        if stonekeeper:IsAlive() then
            aliveCount = aliveCount + 1
            if not stonekeeper:IsInCombat() then
                StonekeepersBecomingHostile(nearestTarget, stonekeeper, true)
                break
            end
        end
    end

    if aliveCount == 0 then
        local door = creature:GetNearObjects(100, 5, DoorEntry) -- 5 is the gameobject type
        if door and door[1] then
            door[1]:UseDoorOrButton(1)
        end
    end
end

local function AltarOfTheKeepersUse(event, go, player)
    if not player:IsInCombat() then
        player:SendBroadcastMessage("The Stonekeepers are waking up...")

        local stonekeepers = player:GetCreaturesInRange(100, StonekeeperEntry)
        local sortedStonekeepers = getSortedStonekeepers(player, stonekeepers)

        for i, stonekeeperData in ipairs(sortedStonekeepers) do
            local stonekeeper = stonekeeperData.creature
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
RegisterCreatureEvent(StonekeeperEntry, 4, StonekeeperDied)
