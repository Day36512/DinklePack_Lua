local StormwindGuards = {68, 1976, 29712} 
local spellId = 80200
local auraId = 80200
local questId = 30035 
local chanceToReveal = 15

local playerInterrogationPhrases = {"I know about the Defias in the city. Tell me what you know or face the consequences!", "Speak up! Are you colluding with the Defias?", "Don't play innocent with me! I know you let the Defias enter the City!"}
local guardRevealPhrases = {"I... I had to, alright? I have mouths to feed at home. They paid us a bit to turn a blind eye... They're getting in over the wall behind the High Elf Embassy. Please... just don't throw me in a cell."}
local guardNoIdeaPhrases = {"I have no idea what you're talking about!", "Defias? In the city? Ridiculous!", "You're talking nonsense!"}

local function IsStormwindGuard(unit)
    local entry = unit:GetEntry()
    for i = 1, #StormwindGuards do
        if StormwindGuards[i] == entry then
            return true
        end
    end
    return false
end

local function GuardDespawn(eventId, delay, repeats, unit)
    unit:DespawnOrUnsummon(0)
end

local function GuardQuestSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == spellId then
        local unit = player:GetSelection()
        local playerGUID = player:GetGUID()
        if unit and IsStormwindGuard(unit) then
            if unit:HasAura(auraId) then
                spell:Cancel()
                player:SendBroadcastMessage("You've already interrogated this guard. Try interrogating a different one.")
                return false
            else
                player:SendUnitSay(playerInterrogationPhrases[math.random(#playerInterrogationPhrases)], 0)
                local function GuardResponse(eventId, delay, repeats, unit)
                    local player = GetPlayerByGUID(playerGUID)
                    if player then
                        local rand = math.random(100)
                        if rand <= chanceToReveal then
                            unit:PerformEmote(20) 
                            unit:SendUnitSay(guardRevealPhrases[math.random(#guardRevealPhrases)], 0)
                            unit:RegisterEvent(GuardDespawn, 10000, 1)
                            unit:AddAura(auraId, unit)
                            if player:HasQuest(questId) then
                                player:CompleteQuest(questId)
                            end
                        else
                            unit:SendUnitSay(guardNoIdeaPhrases[math.random(#guardNoIdeaPhrases)], 0)
                        end
                    end
                end
                unit:RegisterEvent(GuardResponse, 4000, 1)
            end
        else
            spell:Cancel()
            player:SendBroadcastMessage("You can only interrogate a Stormwind Guard.")
            return false
        end
    end
end

RegisterPlayerEvent(5, GuardQuestSpellCast)
