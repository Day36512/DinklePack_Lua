-- SQL script to create a new table
local CreateTableSQL = [[
CREATE TABLE IF NOT EXISTS player_morph_displayids (
    `guid` INT UNSIGNED NOT NULL,
    `displayId` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
]]
CharDBExecute(CreateTableSQL)

-- Function to handle custom commands
local function onCustomCommand(event, player, command)
    
    -- Morph command
    local cmd, displayId = string.match(command, "^(m?orph) (%d+)$")
    if cmd and displayId then
        displayId = tonumber(displayId)
        player:SetDisplayId(displayId)
        
        local query = ("INSERT INTO player_morph_displayids (guid, displayId) VALUES (%d, %d) ON DUPLICATE KEY UPDATE displayId = %d"):format(player:GetGUIDLow(), displayId, displayId)
        CharDBExecute(query)
        return false
    end
    
    -- Demorph command
    if command:lower() == "demorph" then
        player:DeMorph()
        
        -- Delete player's row from the player_morph_displayids table
        local deleteQuery = ("DELETE FROM player_morph_displayids WHERE guid = %d"):format(player:GetGUIDLow())
        CharDBExecute(deleteQuery)
        return false
    end
    
    -- Display command
    if command:lower() == "display" then
        local target = player:GetSelection()
        if target then
            local displayId = target:GetDisplayId()
            player:SendBroadcastMessage("Target's Display ID: " .. displayId)
        else
            player:SendBroadcastMessage("No target selected.")
        end
        return false
    end
end

-- Function to set player's display ID on login
local function onPlayerLogin(event, player)
    local guid = player:GetGUIDLow()
    local query = ("SELECT displayId FROM player_morph_displayids WHERE guid = %d"):format(guid)
    local result = CharDBQuery(query)
    
    if result then
        local displayId = result:GetUInt32(0)
        player:SetDisplayId(displayId)
    end
end

-- Register the events
RegisterPlayerEvent(42, onCustomCommand)
RegisterPlayerEvent(3, onPlayerLogin)
