local NPC_ID = 90010
local GOSSIP_ICON = 0
local REFRESH_INTERVAL = 3000 
local MAP_IDs = {409, 249, 533, 37, 531}  -- Add all your map IDs here
local MINIMUM_LEVEL = 61
local MAXIMUM_LEVEL = 80
local CREATURE_SPELL_ID = 80022
local PLAYER_SPELL_ID = 108001
local ALL_PLAYER_SPELL_ID = 108002  -- New aura for all players in the dungeon
local SPELL_TO_CAST = 19484

local MAX_GROUP_MEMBERS = 10  -- Maximum allowed group members

local function isPlayerInCorrectMap(player)
    local playerMapId = player:GetMapId()
    for _, mapId in ipairs(MAP_IDs) do
        if playerMapId == mapId then
            return true
        end
    end
    return false
end

local function CheckGroupSizeAndDisband(player)
    local group = player:GetGroup()
    if group then
        local members = group:GetMembers()
        if #members > MAX_GROUP_MEMBERS then
            for i, member in ipairs(members) do
                member:RemoveFromGroup()
                member:SendBroadcastMessage("You may only run this event with 10 players in the raid.")
            end
            return false
        end
    end
    return true
end

local playerEvents = {}

local function IsEventActive()
    for _, eventActive in pairs(playerEvents) do
        if eventActive then
            return true
        end
    end
    return false
end

local function ApplyAllPlayerBuff(player, apply)
    local range = 70
    local playersInRange = player:GetPlayersInRange(range)

    for _, playerInRange in ipairs(playersInRange) do
        if isPlayerInCorrectMap(playerInRange) then  -- Change here
            if apply then
                if not playerInRange:HasAura(ALL_PLAYER_SPELL_ID) then
                    playerInRange:AddAura(ALL_PLAYER_SPELL_ID, playerInRange)
                end
            else
                playerInRange:RemoveAura(ALL_PLAYER_SPELL_ID)
            end
        end
    end
end

local function RemoveHighLevelPlayersFromGroup(player)
    local group = player:GetGroup()
    if group then
        local members = group:GetMembers()
        for i, member in ipairs(members) do
            if member:GetLevel() >= MINIMUM_LEVEL then
                member:RemoveFromGroup()
                member:SendBroadcastMessage("You have been removed from the group due to your level.")
            end
        end
    end
end

local function ApplyTimewalkingBuff(player, apply)
    local range = 200
    local creaturesInRange = player:GetCreaturesInRange(range)

    for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()

        if creature:GetInstanceId() == player:GetInstanceId() and (creatureID < 70000 or creatureID > 82000) then
            if apply then
                if not creature:HasAura(CREATURE_SPELL_ID) then
                    creature:AddAura(CREATURE_SPELL_ID, creature)
                end
            else
                creature:RemoveAura(CREATURE_SPELL_ID)
            end
        end
    end

    if apply then
        if not player:HasAura(PLAYER_SPELL_ID) then
            player:AddAura(PLAYER_SPELL_ID, player)
            player:AddAura(ALL_PLAYER_SPELL_ID, player)
        end
    else
        player:RemoveAura(PLAYER_SPELL_ID)
        player:RemoveAura(ALL_PLAYER_SPELL_ID)
    end
end

local function RefreshTimewalkingBuff(eventId, delay, repeats, player)
    print("Refresh Molten Core Auras")  

    if not isPlayerInCorrectMap(player) then
        local playerEventId = playerEvents[player:GetGUID()]
        if playerEventId then
            player:RemoveEvents(playerEventId)
            playerEvents[player:GetGUID()] = nil
            ApplyTimewalkingBuff(player, false)
            ApplyAllPlayerBuff(player, false)
            player:SendBroadcastMessage("You have abandonded your 10-man event.")
        end
        return
    end

    if player:HasAura(PLAYER_SPELL_ID) then
        local aura = player:GetAura(CREATURE_SPELL_ID)
        if aura then
            aura:SetStackAmount(1)
        end
    end

    RemoveHighLevelPlayersFromGroup(player)

    ApplyTimewalkingBuff(player, true)
end

local function OnGossipHello(event, player, object)
    local playerLevel = player:GetLevel()
    if playerLevel >= MINIMUM_LEVEL and playerLevel <= MAXIMUM_LEVEL then
        player:SendBroadcastMessage("Your level is too high to interact with this event.")
        return
    end
    if not player:HasAura(ALL_PLAYER_SPELL_ID) then  -- Check if the player doesn't have the 108002 aura
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON, "10-man Scaled Raid", 1, 1)  -- First option
        player:GossipSendMenu(1, object, 1)  -- object sent as the second argument

        -- Get player's position
        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()

        -- Teleport all group members to the player's current location and cast spell on them
        local group = player:GetGroup()
        if group then
            local members = group:GetMembers()
            for i, member in ipairs(members) do
                if isPlayerInCorrectMap(member) then  -- Change here
                    member:Teleport(mapId, x, y, z, o)
                    member:CastSpell(member, SPELL_TO_CAST, true)  -- Cast spell on teleported player
                end
            end
        end
    end
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON, "Please ensure all raid members are present prior to starting the event. As raid leader, should you leave the raid at any point, the event will cease to continue and scaling will no longer persist.\n\nProceed to speak with me again if you are prepared and wish to activate this event.", 1, 2)  -- Second option
        player:GossipSendMenu(1, object, 2)  -- object sent as the second argument
    elseif intid == 2 then
        if player:HasAura(PLAYER_SPELL_ID) then
            local playerEventId = playerEvents[player:GetGUID()]
            if playerEventId then
                player:RemoveEvents(playerEventId)  -- This should remove all events for the player
                playerEvents[player:GetGUID()] = nil
            end
            ApplyTimewalkingBuff(player, false)
            ApplyAllPlayerBuff(player, false)  -- Remove ALL_PLAYER_SPELL_ID from all players
        else
            local eventId = player:RegisterEvent(RefreshTimewalkingBuff, REFRESH_INTERVAL, 0, player)
            playerEvents[player:GetGUID()] = eventId
            ApplyTimewalkingBuff(player, true)
            ApplyAllPlayerBuff(player, true)  -- Apply ALL_PLAYER_SPELL_ID to all players
        end
        player:GossipComplete()
    end
end

local function OnPlayerResurrect(event, player)
    if player:HasAura(108002) and isPlayerInCorrectMap(player) then  -- Change here
        ApplyTimewalkingBuff(player, true)
    end
end

local function OnPlayerLeaveMap(event, player)
    if not isPlayerInCorrectMap(player) and player:HasAura(108002) then  -- Change here
        player:RemoveEvents(true)
        playerEvents[player:GetGUID()] = nil
        ApplyTimewalkingBuff(player, false)
        ApplyAllPlayerBuff(player, false)

        player:SendBroadcastMessage("You have left the dungeon. Timewalking has been reset.")
    end
end

RegisterPlayerEvent(28, OnPlayerLeaveMap)
RegisterPlayerEvent(36, OnPlayerResurrect)
RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)