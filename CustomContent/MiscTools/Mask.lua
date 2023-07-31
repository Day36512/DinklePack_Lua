local MasksTable = {
    ["Alliance_races"] = {1, 3, 4, 7, 11, 12, 13, 15, 16, 19}, -- Replace with your actual Alliance race IDs
    ["Horde_races"] = {2, 5, 6, 8, 9, 10, 14, 17, 18, 20}, -- Replace with your actual Horde race IDs
    ["Classes"] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15},
    ["Demon_Hunter_Races"] = {14, 15}	-- Replace with your actual class IDs
}

local function calculateMaskForRaces(player, ids)
    local mask = 0
    for _, id in ipairs(ids) do
        mask = mask + player:GetRaceMask(id)
    end
    return mask
end


local function calculateMask(ids)
    local mask = 0
    for _, id in ipairs(ids) do
        mask = mask + 2^(id - 1)
    end
    return mask
end

local function MasksCommand(event, player, command)
    if command:lower() == "masks" then
        -- Get the player's race and class masks
        local raceMask = player:GetRaceMask()
        local classMask = player:GetClassMask()

        -- Send the mask IDs to the player
        player:SendBroadcastMessage("Your race mask ID is: " .. tostring(raceMask))
        player:SendBroadcastMessage("Your class mask ID is: " .. tostring(classMask))

        -- Calculate and send the overall masks for Alliance races, Horde races, and classes
        local allianceMask = calculateMask(MasksTable["Alliance_races"])
        local hordeMask = calculateMask(MasksTable["Horde_races"])
        local classesMask = calculateMask(MasksTable["Classes"])
        player:SendBroadcastMessage("The overall mask for Alliance races is: " .. tostring(allianceMask))
        player:SendBroadcastMessage("The overall mask for Horde races is: " .. tostring(hordeMask))
		player:SendBroadcastMessage("The overall mask for Alliance/Horde races is: " .. tostring(hordeMask + allianceMask))
        player:SendBroadcastMessage("The overall mask for classes is: " .. tostring(classesMask))

    elseif command:lower() == "dhmask" then
        local dhMask = calculateMask(MasksTable["Demon_Hunter_Races"])
        player:SendBroadcastMessage("The overall mask for Demon Hunter races is: " .. tostring(dhMask))

    else
        return
    end

    -- Prevent the command from being handled by other scripts
    return false
end

RegisterPlayerEvent(42, MasksCommand)