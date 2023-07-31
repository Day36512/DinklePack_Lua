--[[
Name: Custom_XP
Version: 1.0.0
Made by: Dinkledork
Notes: use ingame command .xp 

]]


local enabled = true -- set to false to disable the entire script
local GMonly = false -- set to true to allow only GMs to change rates

local function getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

local function GMONLY(player)
   -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

local function OnLogin(event, player)
    local PUID = getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is curently set to %.1f|r", Rate))
    end
end

local function OnFirstLogin(event, player)
    local PUID = getPlayerCharacterGUID(player)
    local defaultRate = 1
    WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, defaultRate))
    player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is set to default: %.1fx|r", defaultRate))
end

local function SetRate(event, player, command)
    local mingmrank = 3
    local PUID = getPlayerCharacterGUID(player)
	

    if command:find("xp") or command:find("exp") then
	
	if player:HasItem(800048, 1) then
            player:SendBroadcastMessage("|cffff0000You do not have access to this feature in Slow and Steady Mode.|r")
            return false
        end

        
        if command:find("q") or command:find("Q") or command:find("?") or command == "xp" or command == "exp" then
            local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
            if Q then
                local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
                player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is currently set to %.1fx|r", Rate))
            else
                player:SendBroadcastMessage("|cff5af304Your experience rate is not found, default experience rate will be applied.|r")
            end
            
            player:SendBroadcastMessage("|cff5af304To set your experience rate, type '.xp X' or '.exp X' where X is a value between 0.01 and 10.|r")
            return false
        end

        local rate = tonumber(command:sub(command:find("xp") and 4 or 5))

		if rate and rate >= 0.01 and rate <= 10 then
    if GMonly and player:GetGMRank() < mingmrank then
        GMONLY(player)
        return false
		elseif not GMonly or player:GetGMRank() >= mingmrank then
        WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
        WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, rate))
        player:SendBroadcastMessage(string.format("|cff5af304You changed your experience rate to %.2fx|r", rate))
        return false
    end
	end

    end
end

local function OnXP(event, player, amount, victim)
    local PUID = getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
    local mingmrank = 3

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        Rate = tonumber(string.format("%.1f", Rate))

        if (GMonly and player:GetGMRank() < mingmrank) then
            return amount
        end

        if (GMonly and player:GetGMRank() >= mingmrank) then
            return amount * Rate
        end

        if (not GMonly) then
            return amount * Rate
        end
    else
        return amount
    end
end

if enabled then
    RegisterPlayerEvent(3, OnLogin)
    RegisterPlayerEvent(12, OnXP)
    RegisterPlayerEvent(42, SetRate)
    RegisterPlayerEvent(30, OnFirstLogin) 
end
