local DEATH_KNIGHT_CLASS = 6
local POWER_TYPES = {
    0,  -- POWER_MANA
    1,  -- POWER_RAGE
    2,  -- POWER_FOCUS
    3,  -- POWER_ENERGY
    5,  -- POWER_RUNE
    6   -- POWER_RUNIC_POWER
}

local function OnPlayerLogin(event, player)
    if player:GetClass() == DEATH_KNIGHT_CLASS then
        for _, powerType in ipairs(POWER_TYPES) do
            player:SetPowerType(powerType)
        end
    end
end

RegisterPlayerEvent(3, OnPlayerLogin)

local DEATH_KNIGHT_CLASS = 6
local POWER_RUNIC_POWER = 6
local POWER_RAGE = 1

local SPELL_POWER_TYPES = {
    -- [spellId] = powerType
    [2048] = POWER_RAGE, -- Battle Shout
    -- Add more spells and their power types here
}

local function OnPlayerCastSpell(event, player, spell, skipCheck)
    if player:GetClass() == DEATH_KNIGHT_CLASS then
        local runicPower = player:GetPower(POWER_RUNIC_POWER)
        player:SetPower(runicPower, POWER_RAGE)

        local spellId = spell:GetEntry()
        local spellCost = spell:GetPowerCost()
        local spellPowerType = SPELL_POWER_TYPES[spellId]

        if spellPowerType then
            local currentPower = player:GetPower(spellPowerType)
            player:SetPower(currentPower - spellCost, spellPowerType)
        end
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell)
