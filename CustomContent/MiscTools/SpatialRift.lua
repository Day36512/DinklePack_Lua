local SAVE_LOCATION_SPELL = 100232
local TELEPORT_BACK_SPELL = 100232
local TELEPORT_BACK_DURATION = 180 -- 3 minutes in seconds
local SPELL_ON_TELEPORT = 72313

local savedLocations = {}
local spellUsage = {}

local function OnSpellCast(event, player, spell)
    local playerGuid = player:GetGUIDLow()

    if spell:GetEntry() == SAVE_LOCATION_SPELL then
        if not savedLocations[playerGuid] then
            local mapId, x, y, z, orientation = player:GetMapId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO()
            savedLocations[playerGuid] = { mapId = mapId, x = x, y = y, z = z, orientation = orientation }
            player:SendBroadcastMessage("Your rift location has been saved for 3 minutes.")
            
            -- Reset spell cooldown if it's the first, third, or any odd-numbered use
            if not spellUsage[playerGuid] then
                spellUsage[playerGuid] = 1
            else
                spellUsage[playerGuid] = spellUsage[playerGuid] + 1
            end

            if spellUsage[playerGuid] % 2 == 1 then
                player:ResetSpellCooldown(SAVE_LOCATION_SPELL, true)
            end

            -- Remove saved location after 3 minutes
            local function RemoveSavedLocation(eventId, delay, repeats, player)
                savedLocations[playerGuid] = nil
                player:SendBroadcastMessage("Your saved location has expired.")
            end
            CreateLuaEvent(RemoveSavedLocation, TELEPORT_BACK_DURATION * 1000, 1, player)
        else
            local savedLocation = savedLocations[playerGuid]
            player:Teleport(savedLocation.mapId, savedLocation.x, savedLocation.y, savedLocation.z, savedLocation.orientation)
            player:CastSpell(player, SPELL_ON_TELEPORT, true)
            savedLocations[playerGuid] = nil
            player:SendBroadcastMessage("You have been teleported back to your saved location.")
            
            -- Remove saved location after teleport
            savedLocations[playerGuid] = nil
            player:SendBroadcastMessage("Your saved location has expired.")
        end
    end
end

RegisterPlayerEvent(5, OnSpellCast)
