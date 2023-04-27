local NPCID = 1400057

local marketText = {
    "Fresh fruits and vegetables here! Get them while they're still ripe!",
    "Step right up! I have the juiciest apples in all of Azeroth!",
    "Come take a look at my homegrown pumpkins! Perfect for making pies or carving for the upcoming festival.",
	"Looking for some herbs for your latest potion? I have just what you need.",
    "Don't go hungry on your travels! Stock up on my homemade bread and cheese.",
    "Need some feed for your mount? I have the finest oats and hay in the land.",
	"Hey, adventurer! I have some special mushrooms that will give you a little extra boost on your next quest.",
	"Looking to add some flavor to your meals? Try my assortment of spices and seasonings.",
	"Freshly laid eggs from my chickens! Perfect for breakfast or baking.",
	"Attention all cooks! I have some rare ingredients that will take your recipes to the next level.",
}

local function SendMarketText(eventId, delay, repeats, npc)
    local index = npc:GetData("marketIndex") or 1
    npc:SendUnitSay(marketText[index], 0)
	npc:PerformEmote(396)
    index = index + 1
    
    if index > #marketText then
        index = 1 
    end

    npc:SetData("marketIndex", index)
    npc:RegisterEvent(SendMarketText, 10000, 1)
end

local function StartMarket(player)
    local priest = player:GetNearestCreature(500, NPCID)
    if priest and not priest:GetData("marketStarted") then
        priest:SetData("marketStarted", true)
        priest:RegisterEvent(SendMarketText, 3000, 1)
    end
end

local function OnPlayerLogin(event, player)
    StartMarket(player)
end

local function OnPlayerMapChange(event, player)
    StartMarket(player)
end

local function OnPlayerUpdateZone(event, player, newZone, newArea)
    StartMarket(player)
end

RegisterPlayerEvent(3, OnPlayerLogin)
RegisterPlayerEvent(28, OnPlayerMapChange)
RegisterPlayerEvent(27, OnPlayerUpdateZone)