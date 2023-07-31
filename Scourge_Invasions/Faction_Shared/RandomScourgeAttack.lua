local ITEM_ID = 800050 
local MAX_NPC_SPAWN = 3 
local ATTACK_CHANCE = 15
local DAZE_SPELL_ID = 100201 

local creatureEntriesByLevelBracket = {
    [1] = {38},
    [11] = {16303},
    [21] = {485},
    [31] = {4147}, 
    [41] = {5255}, 
    [51] = {6513}, 
    [61] = {16951}, 
    [71] = {26948}, 
}

local extraCreatureEntriesByLevelBracket = {
    [1] = {99},
    [11] = {11519},
    [21] = {4829},
    [31] = {7345}, 
    [41] = {5256}, 
    [51] = {10317}, 
    [61] = {19997}, 
    [71] = {28793}, 
}

local function HasRequiredItem(player)
    return player:HasItem(ITEM_ID)
end

local function GetCreatureEntriesForLevel(level)
    local sortedBrackets = {}
    for bracket, _ in pairs(creatureEntriesByLevelBracket) do
        table.insert(sortedBrackets, bracket)
    end
    table.sort(sortedBrackets, function(a, b) return a > b end)  -- sort in descending order

    for _, bracket in ipairs(sortedBrackets) do
        if level >= bracket then
            return creatureEntriesByLevelBracket[bracket]
        end
    end
    return {} 
end


local function GetRandomPositionWithinLOS(player)
    local x, y, z, o = player:GetLocation()
    local tries = 0
    local max_tries = 20
    local new_x, new_y
    while tries < max_tries do
        new_x = x + math.random(-18, 18)
        new_y = y + math.random(-18, 18)
        if player:IsWithinLoS(new_x, new_y, z) then
            return new_x, new_y
        end
        tries = tries + 1
    end
    return x, y -- if no position found within LOS, return original player position
end

local function SetCreatureHealthRelativeToPlayer(player, creature)
    local playerHealth = player:GetHealth()
    local newHealth = playerHealth * 0.92
    creature:SetMaxHealth(newHealth)
    creature:SetHealth(newHealth)
end


local function SpawnAttacker(event, player)
	if player:GetMap():IsBattleground() then
        return
    end
    if not HasRequiredItem(player) then
        return
    end
    
    local chance = math.random(100)
    if chance <= ATTACK_CHANCE then 
        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()
        local level = player:GetLevel()
        local npcCount = math.random(1, MAX_NPC_SPAWN)
        local creatureEntries = GetCreatureEntriesForLevel(level)

        if player:IsMounted() and not player:IsFlying() then
            local dazeChance = math.random(100)
            if dazeChance <= 50 then
                player:Dismount()
                player:CastSpell(player, DAZE_SPELL_ID, true)
                player:SendBroadcastMessage("You have been knocked off your mount!")
            end
        end

        if not player:IsOnVehicle() then
            if #creatureEntries > 0 then
                for i = 1, npcCount do
                    local selectedCreature = creatureEntries[math.random(#creatureEntries)]
                    local randomX, randomY = GetRandomPositionWithinLOS(player)
                    local spawnedCreature = player:SpawnCreature(selectedCreature, randomX, randomY, z, o, 4, 130000)
                    SetCreatureHealthRelativeToPlayer(player, spawnedCreature)
                    spawnedCreature:SetLevel(level)
                    spawnedCreature:AttackStart(player)
					spawnedCreature:DespawnOrUnsummon(180000)
                end

                -- 1% chance to spawn an extra creature
                local extraChance = math.random(100)
                if extraChance <= 1 then
                    local extraCreatureEntry = extraCreatureEntriesByLevelBracket[level]
                    if extraCreatureEntry then
                        local randomX, randomY = GetRandomPositionWithinLOS(player)
                        local spawnedExtraCreature = player:SpawnCreature(extraCreatureEntry, randomX, randomY, z, o, 4, 180000)
                        spawnedExtraCreature:SetLevel(level)
                        spawnedExtraCreature:AttackStart(player)
                    end
                end
            else
                player:SendBroadcastMessage("No creatures to spawn for your level.")
            end
        end
    end
end

RegisterPlayerEvent(27, SpawnAttacker)