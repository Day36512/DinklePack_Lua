local spellIds = {49938, 43265, 49937, 49936} -- The spell IDs to watch for
local auraIdToCast = 80019 -- The aura to cast at the DnD location
local requiredAuraId = 80012 -- The required aura for event to occur

-- Function to check if a table contains a specific value
local function DnD_contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

local function DnD_OnSpellCast(event, player, spell, skipCheck)
    if player:GetClass() ~= 6 or not player:HasAura(requiredAuraId) then -- 6 is the class ID for Death Knight
        return
    end

    local spellId = spell:GetEntry()
    if not DnD_contains(spellIds, spellId) then -- check if the spell is in the spellIds table
        return
    end

    local spellX, spellY, spellZ = spell:GetTargetDest()

    if spellX == nil or spellY == nil or spellZ == nil then
        return
    end

    -- Cast the required aura at the DnD location
    player:CastSpellAoF(spellX, spellY, spellZ, auraIdToCast, true)
end

RegisterPlayerEvent(5, DnD_OnSpellCast) -- 5 is the event for "On Spell Cast"
