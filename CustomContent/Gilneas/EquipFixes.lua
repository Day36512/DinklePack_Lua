local NPCID = 1400054
local ITEM_MAIN_HAND = 5956

local function EquipWeapon(player)
    local npc = player:GetNearestCreature(250, NPCID)
    if npc then
        npc:SetEquipmentSlots(ITEM_MAIN_HAND, 0, 0)
    end
end

local function OnPlayerLogin(event, player)
    EquipWeapon(player)
end

local function OnPlayerMapChange(event, player)
    EquipWeapon(player)
end

local function OnPlayerUpdateZone(event, player, newZone, newArea)
    EquipWeapon(player)
end

RegisterPlayerEvent(3, OnPlayerLogin)
RegisterPlayerEvent(28, OnPlayerMapChange)
RegisterPlayerEvent(27, OnPlayerUpdateZone)
