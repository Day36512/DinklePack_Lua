local NPC_ID = 90008
local GOSSIP_ICON = 0
local REFRESH_INTERVAL = 3000 
local MAP_ID = 532  -- The map ID where the event is active
local MINIMUM_LEVEL = 61
local MAXIMUM_LEVEL = 80
local CREATURE_SPELL_ID = 108000
local PLAYER_SPELL_ID = 108001
local ALL_PLAYER_SPELL_ID = 108002  -- New aura for all players in the dungeon
local SPELL_TO_CAST = 19484

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
        if playerInRange:GetMapId() == MAP_ID then
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
    local range = 100
    local creaturesInRange = player:GetCreaturesInRange(range)
    local playerLevel = player:GetLevel()

    for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()

        if creature:GetInstanceId() == player:GetInstanceId() and (creatureID < 70000 or creatureID > 82000) then
            if apply then
                if not creature:HasAura(CREATURE_SPELL_ID) then
                    creature:SetData("OriginalLevel", creature:GetLevel())
                    creature:AddAura(CREATURE_SPELL_ID, creature)
                    creature:SetLevel(playerLevel + 2)
                end
            else
                local originalLevel = creature:GetData("OriginalLevel")
                if originalLevel == nil then
                    originalLevel = creature:GetLevel()
                end
                creature:RemoveAura(CREATURE_SPELL_ID)
                creature:SetLevel(originalLevel)
            end
        end
    end

    -- Only apply PLAYER_SPELL_ID and ALL_PLAYER_SPELL_ID to the specified player, not all players in range
    if apply then
        if not player:HasAura(PLAYER_SPELL_ID) then
            player:AddAura(PLAYER_SPELL_ID, player)
            player:AddAura(ALL_PLAYER_SPELL_ID, player)  -- Main player gets both auras
        end
    else
        player:RemoveAura(PLAYER_SPELL_ID)
        player:RemoveAura(ALL_PLAYER_SPELL_ID)  -- Remove both auras from the main player
    end
end

local function RefreshTimewalkingBuff(eventId, delay, repeats, player)
    print("Refresh Karazhan Auras")  -- Debug print

    -- If the player isn't on the correct map, remove the event and return early.
    if player:GetMapId() ~= MAP_ID then
        local playerEventId = playerEvents[player:GetGUID()]
        if playerEventId then
            player:RemoveEvents(playerEventId)
            playerEvents[player:GetGUID()] = nil
            ApplyTimewalkingBuff(player, false)
            ApplyAllPlayerBuff(player, false)
            player:SendBroadcastMessage("You have abandonded your Level 60 Karazhan event.")
        end
        return
    end

    -- If the player has the 108001 aura
    if player:HasAura(PLAYER_SPELL_ID) then
        -- Set aura stack 108000 to 1
        local aura = player:GetAura(CREATURE_SPELL_ID)
        if aura then
            aura:SetStackAmount(1)
        end

        -- Get all the creatures in range
        local range = 100
        local creaturesInRange = player:GetCreaturesInRange(range)

        for _, creature in ipairs(creaturesInRange) do
            local creatureID = creature:GetEntry()
            if creature:GetInstanceId() == player:GetInstanceId() and (creatureID < 70000 or creatureID > 82000) then
                creature:SetLevel(62)
            end
        end
    end

    -- Remove players level 61 or higher from the group
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
        player:GossipMenuAddItem(GOSSIP_ICON, "Level 60 Karazhan", 1, 1)  -- First option
        player:GossipSendMenu(1, object, 1)  -- object sent as the second argument

        -- Get player's position
        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()

        -- Teleport all group members to the player's current location and cast spell on them
        local group = player:GetGroup()
        if group then
            local members = group:GetMembers()
            for i, member in ipairs(members) do
                member:Teleport(mapId, x, y, z, o)
                member:CastSpell(member, SPELL_TO_CAST, true)  -- Cast spell on teleported player
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
    if player:HasAura(108002) and player:GetMapId() == MAP_ID then
        ApplyTimewalkingBuff(player, true)
    end
end

local function OnPlayerLeaveMap(event, player)
    if player:GetMapId() ~= MAP_ID and player:HasAura(108002) then
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