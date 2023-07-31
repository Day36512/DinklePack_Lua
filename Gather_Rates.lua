--[[
Name: Gather_Rates
Version: 1.0.0
Made by: Dinkledork
Notes: use ingame command .ga 

]]


local enabled = true -- disable the script with true or false
local GMonly = false -- determine whether you want only GMs to be able to use said command

local function getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

local function GMONLY(player)
    -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

local function OnLogin(event, player)
    local PUID = getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT GatherRate FROM custom_gather_rates WHERE CharID=%i", PUID))

    if Q then
        local GatherRate = Q:GetUInt32(0)
        player:SendBroadcastMessage(string.format("|cff5af304Your gather rate is currently set to %dx|r", GatherRate))
    end
end

local function SetGatherRate(event, player, command)
    local mingmrank = 3
    local PUID = getPlayerCharacterGUID(player)

    if command:find("ga") then
        local rate = tonumber(command:sub(4))

        if command == "ga" then
            player:SendBroadcastMessage("|cff5af304To set your gather rate, type '.ga X' where X is a value between 1 and 10.|r")
            return false
        end

        if rate and rate >= 1 and rate <= 10 then
            if player:HasItem(800048, 1) then
                player:SendBroadcastMessage("|cffff0000You cannot use this command in Slow and Steady Mode.|r")
                return false
            end
            if GMonly and player:GetGMRank() < mingmrank then
                GMONLY(player)
                return false
            else
                CharDBExecute(string.format("REPLACE INTO custom_gather_rates (CharID, GatherRate) VALUES (%i, %d)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your gather rate to %dx|r", rate))
                return false
            end
        else
            player:SendBroadcastMessage("|cffff0000Invalid gather rate. Please enter a value between 1 and 10.|r")
            return false
        end
    end
end

local function onLootItem(event, player, item, count)
    local itemEntry = item:GetEntry()
    local PUID = getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT GatherRate FROM custom_gather_rates WHERE CharID=%i", PUID))
    local GatherRate = 1

    if Q then
        GatherRate = Q:GetUInt32(0)
    end

    if item:GetClass() == 7 then
        local additionalCount = (GatherRate - 1) * count
        
        if additionalCount > 0 then
            player:AddItem(itemEntry, additionalCount)
        end
    end
end

local function createGatherRatesTable()
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_gather_rates (
            CharID INT PRIMARY KEY,
            GatherRate INT DEFAULT 1
        );
    ]])
end

if enabled then
    createGatherRatesTable()
    RegisterPlayerEvent(3, OnLogin)
    RegisterPlayerEvent(32, onLootItem)
    RegisterPlayerEvent(42, SetGatherRate)
end
