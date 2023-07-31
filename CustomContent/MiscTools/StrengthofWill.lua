local itemIds = {60202, 800024}
local auraId = 80012
local newSpellId = 80018
local DK_CLASS_ID = 6
local HEALTH_THRESHOLD_HIGH = 80
local HEALTH_THRESHOLD_LOW = 60

local healthCheckEventRegistered = {}

local function IsInTable(value, table)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local function SoW_CastSpellIfHealthAbove80(player, playerClass)
    if playerClass ~= DK_CLASS_ID or not player:HasAura(auraId) then
        return
    end

    local healthPercent = player:GetHealthPct()
    local hasNewSpellAura = player:HasAura(newSpellId)

    if healthPercent > HEALTH_THRESHOLD_HIGH and not hasNewSpellAura then
        player:CastSpell(player, newSpellId, true)
    elseif healthPercent < HEALTH_THRESHOLD_LOW and hasNewSpellAura then
        player:RemoveAura(newSpellId)
    end
end

local function CheckPlayerHealth(eventId, delay, repeats, player)
    if not player:HasAura(auraId) then
        player:RemoveEvents(CheckPlayerHealth)
        healthCheckEventRegistered[player:GetGUID()] = false
        return
    end

    local playerClass = player:GetClass()
    SoW_CastSpellIfHealthAbove80(player, playerClass)
end

local function SoW_OnEquip(event, player, item, bag, slot)
    local playerClass = player:GetClass()

    if playerClass ~= DK_CLASS_ID then
        return
    end

    if item:IsEquipped() and IsInTable(item:GetEntry(), itemIds) and player:HasAura(auraId) then
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
    local playerClass = player:GetClass()

    if playerClass == DK_CLASS_ID then
        for _, itemId in ipairs(itemIds) do
            local item = player:GetItemByEntry(itemId)
            if item and item:IsEquipped() then
                SoW_OnEquip(nil, player, item, 0, 8)
                break
            end
        end
    end
end

RegisterPlayerEvent(29, SoW_OnEquip)
RegisterPlayerEvent(4, SoW_OnLogout)
RegisterPlayerEvent(3, SoW_OnLogin)

