--[[
Name: Crafting_Rates
Version: 1.0.0
Made by: Dinkledork
Notes: use ingame command .craft

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
    local Q = CharDBQuery(string.format("SELECT CraftRate FROM custom_craft_rates WHERE CharID=%i", PUID))

    if Q then
        local CraftRate = Q:GetUInt32(0)
        player:SendBroadcastMessage(string.format("|cff5af304Your craft rate is currently set to %dx|r", CraftRate))
    end
end

local function SetCraftRate(event, player, command)
    local mingmrank = 3
    local PUID = getPlayerCharacterGUID(player)

    if command:find("craft") then
        local rate = tonumber(command:sub(7))

        if command == "craft" then
            player:SendBroadcastMessage("|cff5af304To set your craft rate, type '.craft X' where X is a value between 1 and 10.|r")
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
                CharDBExecute(string.format("REPLACE INTO custom_craft_rates (CharID, CraftRate) VALUES (%i, %d)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your craft rate to %dx|r", rate))
                return false
            end
        else
            player:SendBroadcastMessage("|cffff0000Invalid craft rate. Please enter a value between 1 and 10.|r")
            return false
        end
    end
end

local function onCreateItem(event, player, item, count)
    local itemEntry = item:GetEntry()
    local PUID = getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT CraftRate FROM custom_craft_rates WHERE CharID=%i", PUID))
    local CraftRate = 1

    if Q then
        CraftRate = Q:GetUInt32(0)
    end

    local additionalCount = (CraftRate - 1) * count

    if additionalCount > 0 then
        player:AddItem(itemEntry, additionalCount)
    end
end

local function createCraftRatesTable()
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_craft_rates (
            CharID INT PRIMARY KEY,
            CraftRate INT DEFAULT 1
        );
    ]])
end

if enabled then
    createCraftRatesTable()
    RegisterPlayerEvent(3, OnLogin)
    RegisterPlayerEvent(52, onCreateItem)
    RegisterPlayerEvent(42, SetCraftRate)
end
