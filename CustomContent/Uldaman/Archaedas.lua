local ArchaedasEntry = 2748
local EarthenGuardianEntry = 7076
local VaultWarderEntry = 10120
local RoomObjectEntry = 133234 
local HostileFaction = 14 

local function SetHostileAndEnterCombat(player, entry, activateOne)
    local creatures = player:GetCreaturesInRange(100, entry)
    for _, creature in ipairs(creatures) do
        if not creature:IsInCombat() then
            creature:SetFaction(HostileFaction)
            creature:SetReactState(1) 
            creature:RemoveAllAuras() -- Remove Auras with Crowd Control effect
            creature:AttackStart(player)
            if activateOne then
                break
            end
        end
    end
end

local function ActivateNextVaultWarder(event, creature, killer)
    local creatures = creature:GetCreaturesInRange(100, VaultWarderEntry)
    for _, nextCreature in ipairs(creatures) do
        if not nextCreature:IsInCombat() then
            nextCreature:SetFaction(HostileFaction)
            nextCreature:SetReactState(1) 
            nextCreature:RemoveAllAuras() -- Remove Auras with Crowd Control effect
            nextCreature:AttackStart(killer)
            break
        end
    end
end

local function RoomObjectUse(event, go, player)
    if not player:IsInCombat() then
        player:SendBroadcastMessage("Archaedas, the Earthen Guardians, and the Vault Warders are waking up...")

        SetHostileAndEnterCombat(player, ArchaedasEntry, false)
        SetHostileAndEnterCombat(player, EarthenGuardianEntry, false)
        SetHostileAndEnterCombat(player, VaultWarderEntry, true)
    else
        player:SendBroadcastMessage("You cannot use the object while in combat.")
    end

    return true
end

RegisterGameObjectEvent(RoomObjectEntry, 14, RoomObjectUse)
RegisterCreatureEvent(VaultWarderEntry, 4, ActivateNextVaultWarder)
