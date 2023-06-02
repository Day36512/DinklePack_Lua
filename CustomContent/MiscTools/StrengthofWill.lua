local itemId = 60202
local auraId = 80012
local newSpellId = 80018

local healthCheckEventRegistered = {}

local function SoW_CastSpellIfHealthAbove80(player)
    if player:GetClass() ~= 6 or not player:HasAura(auraId) then
        return
    end

    local healthPercent = player:GetHealthPct()

    if healthPercent > 80 then
        if not player:HasAura(newSpellId) then
            player:CastSpell(player, newSpellId, true)
        end
    elseif healthPercent < 60 then
        if player:HasAura(newSpellId) then
            player:RemoveAura(newSpellId)
        end
    end
end

local function CheckPlayerHealth(eventId, delay, repeats, player)
    if not player:HasAura(auraId) then
        player:RemoveEvents(CheckPlayerHealth)
        healthCheckEventRegistered[player:GetGUID()] = false
        return
    end

    SoW_CastSpellIfHealthAbove80(player)
end

local function SoW_OnEquip(event, player, item, bag, slot)
    if player:GetClass() ~= 6 then
        return
    end

    if slot == 8 and item:GetEntry() == itemId and player:HasAura(auraId) then
        if not healthCheckEventRegistered[player:GetGUID()] then
            player:RegisterEvent(CheckPlayerHealth, 2000, 0, player)
            healthCheckEventRegistered[player:GetGUID()] = true
        end
    elseif player:HasAura(newSpellId) then
        player:RemoveAura(newSpellId)
    end
end

local function SoW_OnLogout(event, player)
    player:RemoveEvents(CheckPlayerHealth)
    healthCheckEventRegistered[player:GetGUID()] = false
end

local function SoW_OnLogin(event, player)
    if player:GetClass() == 6 then
        local item = player:GetEquippedItemBySlot(8)
        SoW_OnEquip(nil, player, item, 0, 8)
    end
end

RegisterPlayerEvent(29, SoW_OnEquip)
RegisterPlayerEvent(4, SoW_OnLogout)
RegisterPlayerEvent(3, SoW_OnLogin)
