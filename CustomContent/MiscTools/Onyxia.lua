--[[local ENTRY_ONYXIAN_WHELP = 301001

local teleportLocations = {
    {x = -31.71, y = -170.55, z = -89.72, o = 0},
    {x = -32.086, y = -258.55, z = -89.72, o = 0},
}

local function NearTeleportOnyxianWhelpOnSpawn(event, creature)
    local location = teleportLocations[math.random(1, #teleportLocations)]
    local randomizedX = location.x + math.random(-5, 5)
    local randomizedY = location.y + math.random(-5, 5)
    creature:NearTeleport(randomizedX, randomizedY, location.z, location.o)

    local middleY = (teleportLocations[1].y + teleportLocations[2].y) / 2
    creature:MoveTo(1, randomizedX, middleY, location.z)
end

RegisterCreatureEvent(ENTRY_ONYXIAN_WHELP, 5, NearTeleportOnyxianWhelpOnSpawn)
]]--