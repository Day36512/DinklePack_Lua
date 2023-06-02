local ENABLE_SCRIPT = true -- Set this to true or false to enable or disable the script

local REFRESH_INTERVAL = 5000 -- Refresh interval in milliseconds
local MAP_IDS = {529, 489} -- The map IDs where the event is active
local PLAYER_LEVEL = 60
local REFRESH_AURA_ID = 80020

local playerEvents = {}

local function IsMapIDValid(mapId)
    for _, validMapId in ipairs(MAP_IDS) do
        if mapId == validMapId then
            return true
        end
    end
    return false
end

local function BG_ApplyBuffToCreaturesInRange(player, apply)
    if not ENABLE_SCRIPT then
        return
    end
    local range = 1000
    local creaturesInRange = player:GetCreaturesInRange(range)

    for _, creature in ipairs(creaturesInRange) do
        if creature:GetInstanceId() == player:GetInstanceId() then
            if apply then
                if not creature:HasAura(REFRESH_AURA_ID) then
                    creature:AddAura(REFRESH_AURA_ID, creature)
                    creature:SetLevel(PLAYER_LEVEL) -- Set creature's level to 60
                    print("Applying debuff to npcbot", creature:GetEntry())
                end
            else
                creature:RemoveAura(REFRESH_AURA_ID)
            end
        end
    end
end

local function BG_RefreshBuff(eventId, delay, repeats, player)
    if not ENABLE_SCRIPT then
        return
    end
    print("Running BG_RefreshBuff")

    if IsMapIDValid(player:GetMapId()) then
        BG_ApplyBuffToCreaturesInRange(player, true)
    else
        print("BG_RefreshBuff: Player is not in a valid map")
        player:RemoveEvents()
        BG_ApplyBuffToCreaturesInRange(player, false)
        player:SendBroadcastMessage("You have left the map. Event has been reset.")
    end
end

local function BG_OnPlayerMapChange(event, player)
    if not ENABLE_SCRIPT then
        return
    end
    print("Running BG_OnPlayerMapChange")
    if player:GetLevel() >= 60 then   -- 'then' keyword was missing here
        local mapId = player:GetMapId()
        print("Player mapId: ", mapId)

        if IsMapIDValid(mapId) then
            if not playerEvents[player:GetGUID()] then
                local eventId = player:RegisterEvent(BG_RefreshBuff, REFRESH_INTERVAL, 0, player)
                playerEvents[player:GetGUID()] = eventId
                BG_ApplyBuffToCreaturesInRange(player, true)
            end
        else
            print("BG_OnPlayerMapChange: Player has moved to an invalid map. Event has been removed.")
            player:RemoveEvents()
            BG_ApplyBuffToCreaturesInRange(player, false)
            player:SendBroadcastMessage("You have left the map. Event has been reset.")
        end
    end
end

RegisterPlayerEvent(28, BG_OnPlayerMapChange) -- PLAYER_EVENT_ON_MAP_CHANGE
