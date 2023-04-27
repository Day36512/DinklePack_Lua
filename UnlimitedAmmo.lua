-- This script was made by Dinkledork
-- Make sure you only have one type of ammo on your character

local ENABLED = false -- Set this to false to disable the script

local ARROW_ITEM_IDS = {52021, 41165, 11285, 28056, 3030, 28053, 3029, 3464, 10579, 41586, 31737, 2515, 33803, 3031, 18042, 19316, 32760, 2512, 34581, 9399, 24412, 30611, 2514, 12654, 31949, 30319, 24417, 41164, 52020, 41584, 28061, 28060, 11284, 3033, 15997, 10513, 23773, 10512, 2516, 2519, 32883, 32882, 34582, 19317, 4960, 13377, 8069, 8068, 8067, 32761, 3465, 31735, 23772, 30612, 11630, 5568} -- Replace these with actual ammo IDs
local SPELL_IDS = {3674, 53209, 63672, 63670, 63671, 63668, 49049, 20901, 20903, 20900, 20904, 27065, 20902, 49050, 63671, 63669, 63668, 53301, 19434, 19386, 24132, 24133, 27068, 49011, 49012, 34490, 3034, 58433, 58434, 58432, 58431, 42234, 27022, 42245, 14295, 42244, 14294, 42243, 1510, 49052, 49051, 34120, 56641, 49001, 49000, 27016, 25295, 13555, 13554, 13553, 13552, 13551, 13550, 13549, 1978, 49048, 49047, 27021, 25294, 14290, 14289, 14288, 2643, 61006, 61005, 53351, 60192, 49045, 49044, 27019, 14287, 14286, 14285, 14284, 14283, 14282, 14281, 49045, 75} -- Add more spell IDs to this table such as serpent sting arcane shot etc, separated by commas. Right now it triggers on auto shot.

local function GetArrowItemId(player)
    for _, arrowId in ipairs(ARROW_ITEM_IDS) do
        if player:HasItem(arrowId) then
            return arrowId
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

local function OnPlayerSpellCast(event, player, spell, skipCheck)
    if not ENABLED then
        return
    end

    local spellId = spell:GetEntry()
    if IsRelevantSpell(spellId) then
        local arrowItemId = GetArrowItemId(player)
        if arrowItemId then
            player:AddItem(arrowItemId, 1) --can change this number to 2 or 3 or whatever if you're too lazy to add spells in. 
        end
    end
end

RegisterPlayerEvent(5, OnPlayerSpellCast)