local SpellId = 100265 -- The spell you want the player to learn or unlearn.
local RequiredAuraId = 49152 -- The required spell for the player to have.

-- Function to check if the player has a two-handed weapon equipped in either main hand or off-hand.
local function PlayerUsingTwoHandedWeapon(player)
    local mainHand = player:GetEquippedItemBySlot(16)
    local offHand = player:GetEquippedItemBySlot(17)
    local twoHanded = false

    if mainHand then
        local mainHandType = mainHand:GetClass()
        local mainHandSubType = mainHand:GetSubClass()

        -- Check if main hand item is a two-handed weapon.
        twoHanded = mainHandType == 2 and (mainHandSubType == 1 or mainHandSubType == 5 or mainHandSubType == 8)
    end

    if offHand and not twoHanded then
        local offHandType = offHand:GetClass()
        local offHandSubType = offHand:GetSubClass()

        -- Check if off hand item is a two-handed weapon.
        twoHanded = offHandType == 2 and (offHandSubType == 1 or offHandSubType == 5 or offHandSubType == 8)
    end

    return twoHanded
end

-- Function to check if the player has a shield equipped in either main hand or off-hand.
local function PlayerUsingShield(player)
    local mainHand = player:GetEquippedItemBySlot(16)
    local offHand = player:GetEquippedItemBySlot(17)
    local shield = false

    if mainHand then
        local mainHandType = mainHand:GetClass()
        local mainHandSubType = mainHand:GetSubClass()

        -- Check if main hand item is a shield.
        shield = mainHandType == 4 and mainHandSubType == 6
    end

    if offHand and not shield then
        local offHandType = offHand:GetClass()
        local offHandSubType = offHand:GetSubClass()

        -- Check if off hand item is a shield.
        shield = offHandType == 4 and offHandSubType == 6
    end

    return shield
end

local function OnItemEquip(event, player, item, bag, slot)
    if player:GetClass() ~= 1 then -- Exit the function if the player is not a warrior
        return
    end
    
    if player:HasAura(RequiredAuraId) then
        if not PlayerUsingTwoHandedWeapon(player) and not PlayerUsingShield(player) then
            if not player:HasSpell(SpellId) then
                player:LearnSpell(SpellId)
            end
        else
            if player:HasSpell(SpellId) then
                player:RemoveSpell(SpellId)
            end
        end
    else
        -- Player does not have the required aura
    end
end

RegisterPlayerEvent(29, OnItemEquip)
