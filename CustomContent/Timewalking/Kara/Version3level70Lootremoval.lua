local function RemoveItems(eventId, delay, repeats, player)
    
    local lootTable = player:GetData("temp_lootTable")
    if lootTable then
        
        for _, loot in ipairs(lootTable) do
            player:RemoveItem(loot.itemID, loot.itemCount)
            if loot.itemID == 29434 then
                player:SendBroadcastMessage("An unseen force blocked your acquisition of Badges.")
            else
                player:SendBroadcastMessage("The looted item has mysteriously vanished from your bags...the power must've been too great to hold on to...")
            end
        end
        player:SetData("temp_lootTable", {})
        
    end

end

local function OnLoot(event, player, item, count)
    
    local mapId = player:GetMapId()
    local playerLevel = player:GetLevel()
    if mapId == 532 and playerLevel <= 60 then
        
        local itemId = item:GetEntry()
        if itemId >= 10000 and itemId <= 40000 then
            local lootTable = player:GetData("temp_lootTable") or {}
            table.insert(lootTable, {itemID = itemId, itemCount = count})
            
            player:SetData("temp_lootTable", lootTable)
            if not player:GetData("removeItemsEventStarted") then
              
                local eventId = player:RegisterEvent(RemoveItems, 50, 0)
                player:SetData("removeItemsEventId", eventId)
                player:SetData("removeItemsEventStarted", true)
            end
        end
    end
   
end

RegisterPlayerEvent(53, OnLoot)
RegisterPlayerEvent(32, OnLoot)
RegisterPlayerEvent(56, OnLoot)
