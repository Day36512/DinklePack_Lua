local Suspects = {110000, 110001} 
local playerInterrogationPhrases = {"We know you're in cahoots with the Defias Brotherhood. Submit yourself quietly to arrest.", "You can't hide your allegiance to the Defias. Surrender now!", "Your association with the Defias Brotherhood is known. Give up peacefully.", "Your ties to the Defias are no longer a secret. Surrender or face justice!"}
local suspectRevealPhrases = {"Never! Vancleef was this city's hero!", "The Stonemasons deserve restitution!", "You'll never take me alive!", "For the Defias Brotherhood!"}


local function SuspectSpawn(event, unit)
    unit:SetFaction(11)
end

local function SuspectGossip(event, player, unit)
    local playerGUID = player:GetGUID()
    local suspectGUID = unit:GetGUIDLow()

    player:SendUnitSay(playerInterrogationPhrases[math.random(#playerInterrogationPhrases)], 0)

local function SuspectResponse(eventId, delay, repeats, unit)
    unit:SendUnitSay(suspectRevealPhrases[math.random(#suspectRevealPhrases)], 0)
    unit:SetFaction(1630)
    local playersInRange = unit:GetPlayersInRange(10) -- Adjust the range as needed
    if #playersInRange > 0 then
        local playerUnit = playersInRange[1] -- Get the first player in range
        unit:AttackStart(playerUnit)
    end
end


    unit:RegisterEvent(SuspectResponse, 4000, 1)
    return false 
end

for i = 1, #Suspects do
    RegisterCreatureEvent(Suspects[i], 5, SuspectSpawn)
    RegisterCreatureGossipEvent(Suspects[i], 1, SuspectGossip)
end