local AURA_CHECK = 107103
local SPELLS_RENEW_FLASH_HEAL_SMITE = {585, 591, 598, 984, 1004, 10934, 25363, 48122, 48123, 2061, 9472, 9473, 9474, 10915, 10916, 10917, 25233, 25235, 48070, 48071, 10928, 10929}
local SPELLS_MIND_FLAY = {15407, 17311, 17312, 17313, 17314, 18807, 25387, 48155, 48156}
local CHANCE_RENEW_FLASH_HEAL_SMITE = 50
local CHANCE_MIND_FLAY = 50
local SPELL_TO_CAST_RENEW_FLASH_HEAL_SMITE = 107102
local SPELL_TO_CAST_MIND_FLAY = 107101
local COOLDOWN = 10

local playerLastCast = {}

local function IsInTable(value, table)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local function PRIEST_LEGGO_ONE_OnPlayerCastSpell(event, player, spell, skipCheck)
    if player:HasAura(AURA_CHECK) then
        local spellEntryId = spell:GetEntry()
        local currentTime = GetGameTime()
        local playerGuid = player:GetGUIDLow()

        if not playerLastCast[playerGuid] or (currentTime - playerLastCast[playerGuid]) >= COOLDOWN then
            if IsInTable(spellEntryId, SPELLS_RENEW_FLASH_HEAL_SMITE) then
                if math.random(100) <= CHANCE_RENEW_FLASH_HEAL_SMITE then
                    player:CastSpell(player, SPELL_TO_CAST_RENEW_FLASH_HEAL_SMITE, true)
                    playerLastCast[playerGuid] = currentTime
                end
            elseif IsInTable(spellEntryId, SPELLS_MIND_FLAY) then
                if math.random(100) <= CHANCE_MIND_FLAY then
                    player:CastSpell(player, SPELL_TO_CAST_MIND_FLAY, true)
                    playerLastCast[playerGuid] = currentTime
                end
            end
        end
    end
end

RegisterPlayerEvent(5, PRIEST_LEGGO_ONE_OnPlayerCastSpell)
