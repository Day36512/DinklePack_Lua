local Zone1 = 4714
local Zone2 = 5435

local TargetMap1 = 0
local TargetX1 = -1594.44
local TargetY1 = 1904.70
local TargetZ1 = 12.98
local TargetO1 = 1.57

local TargetMap2 = 0
local TargetX2 = -1389.73
local TargetY2 = 1373.48
local TargetZ2 = 35.75
local TargetO2 = 3.17

local TargetMap3 = 0
local TargetX3 = -1916.49
local TargetY3 = 2577.45
local TargetZ3 = 1.635
local TargetO3 = 1.18

local TargetMap4 = 0
local TargetX4 = -1941.6 
local TargetY4 = 970.86 
local TargetZ4 = 75.895 
local TargetO4 = 0.4677

local TargetMap5 = 0
local TargetX5 = -2151.961 
local TargetY5 = 1670.61 
local TargetZ5 = -38.0146 
local TargetO5 = 4.626

local function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

local function TeleportAndRevive(player, targetMap, targetX, targetY, targetZ, targetO)
    player:Teleport(targetMap, targetX, targetY, targetZ, targetO)
    player:ResurrectPlayer(100, false)
end

local function PlayerReleasesSpirit(event, player)
    local playerZone = player:GetZoneId()
    local playerX, playerY = player:GetX(), player:GetY()

    local closestLocation = 1
    local closestDistance = distance(playerX, playerY, TargetX1, TargetY1)

    local distance2 = distance(playerX, playerY, TargetX2, TargetY2)
    if distance2 < closestDistance then
        closestLocation = 2
        closestDistance = distance2
    end

    local distance3 = distance(playerX, playerY, TargetX3, TargetY3)
    if distance3 < closestDistance then
        closestLocation = 3
        closestDistance = distance3
    end

    local distance4 = distance(playerX, playerY, TargetX4, TargetY4)
    if distance4 < closestDistance then
        closestLocation = 4
        closestDistance = distance4
    end

    local distance5 = distance(playerX, playerY, TargetX5, TargetY5)
    if distance5 < closestDistance then
        closestLocation = 5
    end

    if playerZone == Zone1 or playerZone == Zone2 then
                if closestLocation == 1 then
            player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, TargetMap1, TargetX1, TargetY1, TargetZ1, TargetO1) end, 2000, 1)
        elseif closestLocation == 2 then
            player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, TargetMap2, TargetX2, TargetY2, TargetZ2, TargetO2) end, 2000, 1)
        elseif closestLocation == 3 then
            player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, TargetMap3, TargetX3, TargetY3, TargetZ3, TargetO3) end, 2000, 1)
        elseif closestLocation == 4 then
            player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, TargetMap4, TargetX4, TargetY4, TargetZ4, TargetO4) end, 2000, 1)
        else
            player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, TargetMap5, TargetX5, TargetY5, TargetZ5, TargetO5) end, 2000, 1)
        end

end
end

RegisterPlayerEvent(35, PlayerReleasesSpirit)
