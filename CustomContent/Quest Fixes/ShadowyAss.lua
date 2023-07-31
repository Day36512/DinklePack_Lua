local creatureID = 2434 
local range = 10 
local spellID = 1786 
local auraID = 42347 
local delay = 3000 


local function SHADOW_ASS_CheckNearbyCreatures(event, creature)
   
    creature:AddAura(spellID, creature)

    local creaturesNearby = creature:GetCreaturesInRange(range, creatureID)
  --  print("[INFO] Spawned creature with GUID " .. tostring(creature:GetGUID()) .. " at (" .. tostring(creature:GetX()) .. ", " .. tostring(creature:GetY()) .. ", " .. tostring(creature:GetZ()) .. ")")
  --  print("[INFO] Checking for nearby creatures...")
    if #creaturesNearby > 0 then
   --     print("[INFO] Another creature of ID " .. creatureID .. " found within " .. range .. " yards. Despawning newly spawned creature.")
        creature:DespawnOrUnsummon(0)
    else
    --    print("[INFO] No other creatures of ID " .. creatureID .. " found within " .. range .. " yards.")
    end
end


local function SHADOW_ASS_AddAuraOnLeaveCombat(event, creature)
creature:AddAura(spellID, creature)
end


RegisterCreatureEvent(creatureID, 5, SHADOW_ASS_CheckNearbyCreatures)
RegisterCreatureEvent(creatureID, 2, SHADOW_ASS_AddAuraOnLeaveCombat)
