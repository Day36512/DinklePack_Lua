local TargetArea = {
    [5390] = true,
    [1519] = true,
    [5148] = true,
    [5150] = true,
    [5314] = true,
    [5346] = true,
    [5428] = true,
    [4921] = true,
    [5157] = true,
    [5151] = true,
    [7486] = true,
}
local TargetMap = 0
local TargetX = -8437.3
local TargetY = 942.03
local TargetZ = 98.6
local TargetO = 5.4

local function TeleportAndRevive(eventId, delay, repeats, player)
    player:Teleport(TargetMap, TargetX, TargetY, TargetZ, TargetO)
    player:ResurrectPlayer(100, false)
end

local function PlayerReleasesSpirit(event, player)
    local playerArea = player:GetAreaId()
    if TargetArea[playerArea] then
        player:RegisterEvent(TeleportAndRevive, 3000, 1)
    end
end

RegisterPlayerEvent(35, PlayerReleasesSpirit)
