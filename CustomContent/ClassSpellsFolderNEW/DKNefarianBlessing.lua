local EQUIPPED_ITEM = 80344
local SPELLS_TO_LISTEN_FOR = {49924, 49998, 49999, 45463, 49923, 47541, 49892, 49893, 49894, 49895}
local SPELL_TO_CAST = 80038
local CHANCE_TO_CAST = 10

local EQUIPMENT_SLOT_TRINKET1 = 12
local EQUIPMENT_SLOT_TRINKET2 = 13

local function IsItemEquipped(player, itemID)
    local trinket1 = player:GetEquippedItemBySlot(EQUIPMENT_SLOT_TRINKET1)
    local trinket2 = player:GetEquippedItemBySlot(EQUIPMENT_SLOT_TRINKET2)
    
    if trinket1 and trinket1:GetEntry() == itemID and trinket1:IsEquipped() then
        return true
    end
    
    if trinket2 and trinket2:GetEntry() == itemID and trinket2:IsEquipped() then
        return true
    end
    
    return false
end

local function OnCast(event, player, spell, skipCheck)
    if (player:GetClass() == 6) then -- 6 is Death Knight
        if (IsItemEquipped(player, EQUIPPED_ITEM)) then
            local spellEntry = spell:GetEntry()
            for _, spellID in ipairs(SPELLS_TO_LISTEN_FOR) do
                if (spellEntry == spellID) then
                    if (math.random(1, 100) <= CHANCE_TO_CAST and not player:HasAura(SPELL_TO_CAST)) then
                        player:CastSpell(player, SPELL_TO_CAST, true)
                    end
                    break
                end
            end
        end
    end
end

RegisterPlayerEvent(5, OnCast) 
