local NPC_ID = 90009
local GOSSIP_ICON = 0
local KARAZHAN_MAP_ID = 532
local KARAZHAN_X = -11089.735
local KARAZHAN_Y = -1988.7
local KARAZHAN_Z = 49.755
local KARAZHAN_ORIENTATION = 6

local function OnGossipHello(event, player, object)
    player:GossipClearMenu()

    -- Check player level
    local playerLevel = player:GetLevel()
    if playerLevel >= 61 and playerLevel <= 80 then
        player:SendBroadcastMessage("You must be level 60 to access this feature.")
        return
    end

    -- Add teleport option
    player:GossipMenuAddItem(GOSSIP_ICON, "Teleport me to Karazhan.", 0, 1)

    player:GossipSendMenu(1, object)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        -- Teleport the player to Karazhan
        player:Teleport(KARAZHAN_MAP_ID, KARAZHAN_X, KARAZHAN_Y, KARAZHAN_Z, KARAZHAN_ORIENTATION)
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
