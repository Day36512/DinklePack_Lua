local function tableContains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local SPELL_AURA_FROST = 44572
local SPELL_AURA_FROST_STACK = 100240
local SPELL_ICE_LANCE_RANK_1 = 100241
local SPELL_ICE_LANCE_RANK_2 = 100242
local SPELL_ICE_LANCE_RANK_3 = 100243

local SPELL_FROSTBOLT = {
    116,   -- Rank 1
    205,   -- Rank 2
    837,   -- Rank 3
    7322,  -- Rank 4
    8406,  -- Rank 5
    8407,  -- Rank 6
    8408,  -- Rank 7
    10179, -- Rank 8
    10180, -- Rank 9
    10181, -- Rank 10
    25304, -- Rank 11
    27071, -- Rank 12
    27072, -- Rank 13
    38697, -- Rank 14
    42841, -- Rank 15
    42842, -- Rank 16
}

local SPELL_FROSTFIREBOLT = {
    44614, -- Rank 1
    47610, -- Rank 2
}

local function FB_ICE_OnSpellCast(event, player, spell)
    local spellId = spell:GetEntry()

    if spellId == SPELL_ICE_LANCE_RANK_1 then
        player:CastSpell(player:GetSelection(), 107104, true)
    elseif spellId == SPELL_ICE_LANCE_RANK_2 then
        player:CastSpell(player:GetSelection(), 107105, true)
    elseif spellId == SPELL_ICE_LANCE_RANK_3 then
        player:CastSpell(player:GetSelection(), 107106, true)
    end

    if not (tableContains(SPELL_FROSTBOLT, spellId) or tableContains(SPELL_FROSTFIREBOLT, spellId)) then
        return
    end

    if not player:HasSpell(SPELL_AURA_FROST) then
        return
    end

    local chance = math.random(1, 100)
    if chance > 66 then
        return
    end
    
    local aura = player:GetAura(SPELL_AURA_FROST_STACK)
    if not aura then
        player:AddAura(SPELL_AURA_FROST_STACK, player)
    else
        aura:SetStackAmount(aura:GetStackAmount() + 1)
        if aura:GetStackAmount() >= 6 then
            local target = player:GetSelection()
            if not target or not target:IsInWorld() then
                return
            end
            
            local level = player:GetLevel()
            local iceLanceSpell = SPELL_ICE_LANCE_RANK_1
            
            if level >= 72 and level <= 77 then
                iceLanceSpell = SPELL_ICE_LANCE_RANK_2
            elseif level >= 78 then
                iceLanceSpell = SPELL_ICE_LANCE_RANK_3
            end
            
            player:CastSpell(target, iceLanceSpell, true)
            player:RemoveAura(SPELL_AURA_FROST_STACK)
        end
    end
end


RegisterPlayerEvent(5, FB_ICE_OnSpellCast)
