local creatureID = 2434 -- ID of the creature
local range = 3 -- Range in yards
local spellID = 1786 -- ID of the spell to cast
local auraID = 42347 -- ID of the aura to add
local delay = 3000 -- Delay in milliseconds

-- Function that checks for nearby creatures of the same ID and despawns the newly spawned one
local function SHADOW_ASS_CheckNearbyCreatures(event, creature)
    -- Add the aura on spawn
    creature:AddAura(spellID, creature)

    local creaturesNearby = creature:GetCreaturesInRange(range, creatureID)
    print("[INFO] Spawned creature with GUID " .. tostring(creature:GetGUID()) .. " at (" .. tostring(creature:GetX()) .. ", " .. tostring(creature:GetY()) .. ", " .. tostring(creature:GetZ()) .. ")")
    print("[INFO] Checking for nearby creatures...")
    if #creaturesNearby > 0 then
        print("[INFO] Another creature of ID " .. creatureID .. " found within " .. range .. " yards. Despawning newly spawned creature.")
        creature:DespawnOrUnsummon(0)
    else
        print("[INFO] No other creatures of ID " .. creatureID .. " found within " .. range .. " yards.")
    end
end


local function SHADOW_ASS_AddAuraOnLeaveCombat(event, creature)
creature:AddAura(spellID, creature)
end


RegisterCreatureEvent(creatureID, 5, SHADOW_ASS_CheckNearbyCreatures)
RegisterCreatureEvent(creatureID, 2, SHADOW_ASS_AddAuraOnLeaveCombat)
