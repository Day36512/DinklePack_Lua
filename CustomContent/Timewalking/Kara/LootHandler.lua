local SCRIPT_ENABLED = false -- IDs need corrections

local LOOT_TABLE = {
    [16152] = {  -- Attumen
    { itemID = 73500, quantity = 1 },  
    { itemID = 73501, quantity = 1 },  
	{ itemID = 73499, quantity = 1 },
	{ itemID = 176498, quantity = 1 },
	{ itemID = 176497, quantity = 1 },
    },
    [15687] = {  -- Moroes
    { itemID = 176499, quantity = 1 },  
    { itemID = 176500, quantity = 1 },  
	{ itemID = 176501, quantity = 1 }, 
	{ itemID = 176502, quantity = 1 }, 
	{ itemID = 176503, quantity = 1 }, 
    },
	[16457] = {  -- Maiden
    { itemID = 176504, quantity = 1 },  
    { itemID = 176505, quantity = 1 },  
	{ itemID = 176506, quantity = 1 }, 
	{ itemID = 176507, quantity = 1 }, 
	{ itemID = 176508, quantity = 1 }, 
    },
	[18161] = {  -- Crone
    { itemID = 176509, quantity = 1 },  
    { itemID = 176510, quantity = 1 },  
	{ itemID = 176511, quantity = 1 }, 
	{ itemID = 176512, quantity = 1 }, 
	{ itemID = 176513, quantity = 1 }, 
	{ itemID = 176514, quantity = 1 },  
    { itemID = 176515, quantity = 1 },  
	{ itemID = 176516, quantity = 1 }, 
	{ itemID = 176517, quantity = 1 }, 
	{ itemID = 176518, quantity = 1 }, 
    },
	[17521] = {  -- Wolf
    { itemID = 176509, quantity = 1 },  
    { itemID = 176510, quantity = 1 },  
	{ itemID = 176511, quantity = 1 }, 
	{ itemID = 176512, quantity = 1 }, 
	{ itemID = 176513, quantity = 1 }, 
	{ itemID = 176514, quantity = 1 },  
    { itemID = 176515, quantity = 1 },  
	{ itemID = 176516, quantity = 1 }, 
	{ itemID = 176517, quantity = 1 }, 
	{ itemID = 176518, quantity = 1 }, 
    },
	[17533] = {  -- Julianne
    { itemID = 176509, quantity = 1 },  
    { itemID = 176510, quantity = 1 },  
	{ itemID = 176511, quantity = 1 }, 
	{ itemID = 176512, quantity = 1 }, 
	{ itemID = 176513, quantity = 1 }, 
	{ itemID = 176514, quantity = 1 },  
    { itemID = 176515, quantity = 1 },  
	{ itemID = 176516, quantity = 1 }, 
	{ itemID = 176517, quantity = 1 }, 
	{ itemID = 176518, quantity = 1 }, 
    },
	[15691] = {  -- Curator
    { itemID = 176519, quantity = 1 },  
    { itemID = 176520, quantity = 1 },  
	{ itemID = 176521, quantity = 1 }, 
	{ itemID = 176522, quantity = 1 }, 
	{ itemID = 176523, quantity = 1 }, 
	{ itemID = 176524, quantity = 1 },  
    { itemID = 176525, quantity = 1 },  
	{ itemID = 176526, quantity = 1 },  
    },
	[18062] = {  -- Nightbane
    { itemID = 176527, quantity = 1 },  
    { itemID = 176528, quantity = 1 },  
	{ itemID = 176529, quantity = 1 }, 
	{ itemID = 176530, quantity = 1 }, 
	{ itemID = 176531, quantity = 1 },  
	{ itemID = 176537, quantity = 1 },	
    },
	[15688] = {  -- Illhoof
    { itemID = 176531, quantity = 1 },  
    { itemID = 176532, quantity = 1 },  
	{ itemID = 176533, quantity = 1 }, 
	{ itemID = 176534, quantity = 1 }, 
	{ itemID = 176535, quantity = 1 },  
	{ itemID = 176536, quantity = 1 }, 	
	{ itemID = 176538, quantity = 1 },
    },
	[16524] = {  -- Shade of Aran
    { itemID = 176539, quantity = 1 },  
    { itemID = 176540, quantity = 1 },  
	{ itemID = 176541, quantity = 1 }, 
	{ itemID = 176542, quantity = 1 }, 
	{ itemID = 276544, quantity = 1 },  
	{ itemID = 276545, quantity = 1 }, 	
	{ itemID = 276546, quantity = 1 },
	{ itemID = 276547, quantity = 1 },
	{ itemID = 276548, quantity = 1 },
	{ itemID = 276549, quantity = 1 },
	{ itemID = 276550, quantity = 1 },
    },
	[15689] = {  -- Netherspite
    { itemID = 276551, quantity = 1 },  
    { itemID = 276552, quantity = 1 },  
	{ itemID = 276553, quantity = 1 }, 
	{ itemID = 276554, quantity = 1 }, 
	{ itemID = 276555, quantity = 1 },  
	{ itemID = 276556, quantity = 1 }, 	
	{ itemID = 276557, quantity = 1 },
	{ itemID = 276558, quantity = 1 },
    },
		[15690] = {  -- Prince Malch
    { itemID = 276559, quantity = 1 },  
    { itemID = 276560, quantity = 1 },  
	{ itemID = 276561, quantity = 1 }, 
	{ itemID = 276562, quantity = 1 }, 
	{ itemID = 276563, quantity = 1 },  
	{ itemID = 276564, quantity = 1 }, 	
	{ itemID = 276565, quantity = 1 },
	{ itemID = 276566, quantity = 1 },
	{ itemID = 276567, quantity = 1 },
	{ itemID = 276568, quantity = 1 },
    },
    -- Add more NPC ID and loot mappings as needed
}

local AURA_ID = 108002
local LOOT_RADIUS = 100  -- Radius to check for nearby players for loot distribution


local function OnPlayerKillCreature(event, killer, killed)
local function OnPlayerKillCreature(event, killer, killed)
    -- Exit function if script is disabled
    if not SCRIPT_ENABLED then
        return
    end
    local npcId = killed:GetEntry()
    local loot = LOOT_TABLE[npcId]
    if loot then
        -- Check if the main killer character has the aura
        local mainKillerHasAura = killer:HasAura(AURA_ID)
        if mainKillerHasAura then
            -- Roll once for a random loot item for the main killer character
            local itemIndex = math.random(#loot)
            local itemData = loot[itemIndex]
            killer:AddItem(itemData.itemID, itemData.quantity)

            -- Remove the chosen item from a copy of the loot table
            local lootCopy = {}
            for i, v in ipairs(loot) do
                if i ~= itemIndex then
                    table.insert(lootCopy, v)
                end
            end

            -- 50% chance for a bonus roll
            if math.random() <= 0.5 and #lootCopy > 0 then
                local bonusItemData = lootCopy[math.random(#lootCopy)]
                killer:AddItem(bonusItemData.itemID, bonusItemData.quantity)
                killer:SendUnitSay("Congratulations " .. killer:GetName() .. ", you won a bonus roll item!", 0)
            end
        end

        -- Check nearby players for loot distribution
        local playerInRange = killer:GetPlayersInRange(LOOT_RADIUS)
        for _, player in ipairs(playerInRange) do
            if player:HasAura(AURA_ID) then
                -- Roll once for a random loot item for each player
                local itemIndex = math.random(#loot)
                local itemData = loot[itemIndex]
                player:AddItem(itemData.itemID, itemData.quantity)

                -- Remove the chosen item from a copy of the loot table
                local lootCopy = {}
                for i, v in ipairs(loot) do
                    if i ~= itemIndex then
                        table.insert(lootCopy, v)
                    end
                end

                -- 50% chance for a bonus roll
                if math.random() <= 0.5 and #lootCopy > 0 then
                    local bonusItemData = lootCopy[math.random(#lootCopy)]
                    player:AddItem(bonusItemData.itemID, bonusItemData.quantity)
                    player:SendUnitSay("Congratulations " .. player:GetName() .. ", you won a bonus roll item!", 0)
                end
            end
        end
    end
end
end
RegisterPlayerEvent(7, OnPlayerKillCreature)




