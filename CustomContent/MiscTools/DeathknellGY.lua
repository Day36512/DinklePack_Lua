local NewArea = 5692

local NewTargetMap = 0
local NewTargetX = 1708.75
local NewTargetY = 1643.5
local NewTargetZ = 124.831
local NewTargetO = 3.162

local function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

local function TeleportAndRevive(player, targetMap, targetX, targetY, targetZ, targetO)
    player:Teleport(targetMap, targetX, targetY, targetZ, targetO)
    player:ResurrectPlayer(100, false)
end

local function PlayerReleasesSpiritNewArea(event, player)
    local playerMap = player:GetMap()
    local playerX, playerY, playerZ = player:GetX(), player:GetY(), player:GetZ()

    local playerAreaId = playerMap:GetAreaId(playerX, playerY, playerZ)

    local closestLocation = 1
    local closestDistance = distance(playerX, playerY, NewTargetX, NewTargetY)

    if playerAreaId == NewArea then
        player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, NewTargetMap, NewTargetX, NewTargetY, NewTargetZ, NewTargetO) end, 2000, 1)
    end
end

RegisterPlayerEvent(6, PlayerReleasesSpiritNewArea)
