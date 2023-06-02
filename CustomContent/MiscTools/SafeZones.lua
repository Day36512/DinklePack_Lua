local PlayerEvent = 27 -- PLAYER_EVENT_ON_UPDATE_ZONE
local AuraID = 89998
local AreaIDList = {976, 541, 3425, 1446, 69, 42, 35, 2268, 152, 108, 1099, 392, 99, 117, 608, 2255}

-- Convert the array into a set for faster access
local AreaIDSet = {}
for _, id in ipairs(AreaIDList) do
    AreaIDSet[id] = true
end

-- Event Handler
local function OnPlayerUpdateZone(event, player, newZone, newArea)
    -- If the new area id is in the list and the player does not have the aura, apply it
    if AreaIDSet[newArea] and not player:HasAura(AuraID) then
        player:AddAura(AuraID, player)
    -- If the new area id is not in the list and the player has the aura, remove it
    elseif not AreaIDSet[newArea] and player:HasAura(AuraID) then
        player:RemoveAura(AuraID)
    end
end

RegisterPlayerEvent(PlayerEvent, OnPlayerUpdateZone)
