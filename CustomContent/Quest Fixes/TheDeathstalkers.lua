local NPC_ID = 6497 -- Set this to the NPC ID you wish to interact with
local QUEST_ID = 1886 -- Set this to the Quest ID to check if the player has it
local FACTION_HOSTILE = 1630 -- Set this to the faction ID for hostile

local function OnGossipHello(event, player, object)

    if player:HasQuest(QUEST_ID) then
      
        object:SendUnitYell("The Deathstalkers will not be getting their way today!", 0)
        object:SetFaction(FACTION_HOSTILE)
        object:AttackStart(player)
    else
       
        return false -- This will allow the default gossip menu to be displayed
    end
end
RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
