local NPC_ENTRY = 400163
local DESPAWN_TIME = 60000 -- 1 minute in milliseconds
local SPELLS = {6668, 11540, 11541, 11542, 11543, 11544, 55420}
local LOCATIONS = {
    {-8896.97, 1029.82, 126.82},
    {-889.738, 1024.24, 126.82},
    {-8907.96, 1027.43, 126.82},
    {-8891.89, 1008, 150.76},
    {-8920.6, 1078.23, 130.25},
    {-8895.75, 1083.37, 130.23},
    {-8854.7, 1077, 120.2},
    {-8834.075, 1000.2, 140.48},
    {-8915.52, 1012.86, 148.46},
    {-8898, 1068.36, 126.55},
    {-8887.459, 1076.43, 126.49},
    {-8889.88, 1024.14, 126.81},
    {-8887.615, 1016.58, 128.8},
    {-8829.35, 1080.13, 134.4},
    {-8835.101, 994.2, 140.1},
    {-8827.25, 1003.2, 140.118},
    {-8819.76, 1029.31, 133.88},
    {-8886.66, 991.123, 148.5},
    {-8882.54, 977.442, 160.6},
    {-8871.88, 974.58, 160.6},
    {-8925.901, 1049.93, 156},
    {-8932.68, 1046.43, 156},
    {-8927.4277, 1057.37, 156}
}

local function CastRandomSpell(eventId, delay, repeats, creature)
    local spellId = SPELLS[math.random(#SPELLS)]
    creature:CastSpell(creature, spellId, true)
end

local function OnSpawn(event, creature)
    creature:RegisterEvent(CastRandomSpell, 3000, 0) -- 3 seconds
end

local function OnQuestComplete(event, player, quest)
    if quest:GetId() == 30039 then
        for i, location in ipairs(LOCATIONS) do
            local x, y, z = table.unpack(location)
            player:SpawnCreature(NPC_ENTRY, x, y, z, 0, 1, DESPAWN_TIME)
        end
    end
end

RegisterPlayerEvent(54, OnQuestComplete)
RegisterCreatureEvent(NPC_ENTRY, 5, OnSpawn)
