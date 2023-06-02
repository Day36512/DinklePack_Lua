local SpellId = 100265 -- The SMF Spell
local RequiredAuraId = 49152 -- The TG aura

local EQUIPMENT_SLOT_MAINHAND = 15
local EQUIPMENT_SLOT_OFFHAND = 16

local function PlayerUsingOneHandedSword(player)
    local mainHand = player:GetEquippedItemBySlot(EQUIPMENT_SLOT_MAINHAND)
    local offHand = player:GetEquippedItemBySlot(EQUIPMENT_SLOT_OFFHAND)

    if not mainHand or not offHand then
        return false
    end

    local mainHandType = mainHand:GetClass()
    local mainHandSubType = mainHand:GetSubClass()
    local offHandType = offHand:GetClass()
    local offHandSubType = offHand:GetSubClass()

    return (mainHandType == 2 and mainHandSubType == 7) and (offHandType == 2 and offHandSubType == 7)
end

local function OnItemEquip(event, player, item, bag, slot)
    if player:GetClass() ~= 1 then -- Exit the function if the player is not a warrior
        return
    end

    if player:HasAura(RequiredAuraId) then
        if PlayerUsingOneHandedSword(player) then
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
