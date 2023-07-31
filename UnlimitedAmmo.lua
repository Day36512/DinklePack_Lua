-- This script was made by Dinkledork
-- Make sure you only have one type of ammo on your character
-- Updated by TurekSY

local ENABLED = false -- Set this to false to disable the script

local ARROW_ITEM_IDS = {3464, 2512, 2515, 3030, 9399, 10579, 11285, 19316, 18042, 12654, 28053, 24417, 33803, 24412, 28056, 30611, 31949, 34581, 30319, 32760, 31737, 41165, 41586, 52021} 

local BULLET_ITEM_IDS = {3465, 4960, 2516, 8067, 2519, 5568, 8068, 3033, 8069, 10512, 11284, 10513, 11630, 19317, 15997, 28060, 13377, 23772, 23773, 29885, 28061, 30612, 32883, 32882, 34582, 32761, 31735, 41164, 41584, 52020} 
local BOW_SUBCLASS_ID = 2 
local GUN_SUBCLASS_ID = 3 
local CROSSBOW_SUBCLASS_ID = 18 
local MAX_AMMO = 1000 -- Maximum ammunition allowed
local MIN_AMMO_THRESHOLD = 52 -- Ammo count threshold to add max ammo
local SPELL_IDS = {75} -- Add another Spell If you want

local function GetArrowItemId(player)
    for _, arrowId in ipairs(ARROW_ITEM_IDS) do -- arrow
        if player:HasItem(arrowId) then
            return arrowId
        end
    end
    return nil
end

local function GetBulletItemId(player)
    for _, bulletId in ipairs(BULLET_ITEM_IDS) do -- bullet
        if player:HasItem(bulletId) then
            return bulletId
        end
    end
    return nil
end

local function IsRelevantSpell(spellId)
    for _, id in ipairs(SPELL_IDS) do
        if spellId == id then
            return true
        end
    end
    return false
end

local function IsBowEquipped(player)
    local weapon = player:GetEquippedItemBySlot(17) -- 17 is the ranged weapon slot
    if weapon then
        local itemSubclass = weapon:GetSubClass()
        if itemSubclass == BOW_SUBCLASS_ID then
            return true
        end
    end
    return false
end

local function IsGunEquipped(player)
    local weapon = player:GetEquippedItemBySlot(17) -- 17 is the ranged weapon slot
    if weapon then
        local itemSubclass = weapon:GetSubClass()
        if itemSubclass == GUN_SUBCLASS_ID then
            return true
        end
    end
    return false
end

local function IsCrossbowEquipped(player)
    local weapon = player:GetEquippedItemBySlot(17) -- 17 is the ranged weapon slot
    if weapon then
        local itemSubclass = weapon:GetSubClass()
        if itemSubclass == CROSSBOW_SUBCLASS_ID then
            return true
        end
    end
    return false
end

local function Ammo_OnPlayerSpellCast(event, player, spell, skipCheck)
    if not ENABLED then
        return
    end

    local spellId = spell:GetEntry()
    if IsRelevantSpell(spellId) then
        if IsBowEquipped(player) then
            local arrowItemId = GetArrowItemId(player)
            if arrowItemId then
                local currentAmmoCount = player:GetItemCount(arrowItemId)
                if currentAmmoCount < MIN_AMMO_THRESHOLD then
                    player:AddItem(arrowItemId, MAX_AMMO - currentAmmoCount)
                    player:RemoveItem(10579, 800)
                    player:RemoveItem(32760, 800)
                end
            end
        elseif IsGunEquipped(player) then
            local bulletItemId = GetBulletItemId(player)
            if bulletItemId then
                local currentAmmoCount = player:GetItemCount(bulletItemId)
                if currentAmmoCount < MIN_AMMO_THRESHOLD then
                    player:AddItem(bulletItemId, MAX_AMMO - currentAmmoCount)
                    player:RemoveItem(32761, 800)
                    player:RemoveItem(29885, 800)
                end
            end
        elseif IsCrossbowEquipped(player) then
            local arrowItemId = GetArrowItemId(player)
            if arrowItemId then
                local currentAmmoCount = player:GetItemCount(arrowItemId)
                if currentAmmoCount < MIN_AMMO_THRESHOLD then
                    player:AddItem(arrowItemId, MAX_AMMO - currentAmmoCount)
                    player:RemoveItem(10579, 800)
                    player:RemoveItem(32760, 800)
                end
            end
        end
    end
end

local function EnableScript(event, player, command, chatHandler)
    if (command:lower() == "ua") then
        ENABLED = true
        player:SendBroadcastMessage("Unlimited Ammo script enabled.")
        return false -- Consumes the command, no further processing
    end
end



RegisterPlayerEvent(5, Ammo_OnPlayerSpellCast)
RegisterPlayerEvent(42, EnableScript)
