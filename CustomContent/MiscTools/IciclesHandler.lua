local SPELL_AURA_FROST = 44572
local SPELL_AURA_FROST_STACK = 100240
local SPELL_ICE_LANCE_RANK_1 = 100241
local SPELL_ICE_LANCE_RANK_2 = 100242
local SPELL_ICE_LANCE_RANK_3 = 100243

local function OnSpellCast(event, player, spell)
    local spellId = spell:GetEntry()

    if spellId == SPELL_ICE_LANCE_RANK_1 or spellId == 30445 or spellId == 42913 or spellId == 42914 or spellId == SPELL_ICE_LANCE_RANK_2 or spellId == SPELL_ICE_LANCE_RANK_3 then
        return
    end

    if not player:HasSpell(SPELL_AURA_FROST) then
        return
    end

    local chance = math.random(1, 100)
    if chance > 33 then
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

RegisterPlayerEvent(5, OnSpellCast)