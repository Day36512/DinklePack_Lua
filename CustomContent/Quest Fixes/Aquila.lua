local QUEST_ID = 30032
local NPC_ID_AQUILA = 100139
local NPC_ID_ANOTHER_NPC = 1500017
local NPC_ID_KLOVERIELL = 100140
local SPELL_ID = 80102
local SAY_TEXT_AQUILA = "Preparations are complete...now for the vital part."
local SAY_TEXT_ANOTHER_NPC = "Aquila, may I have a word? The messenger who just arrived has brought forth some intriguing information that demands immediate attention. Could I per chance borrow your little helper here?"
local SAY_TEXT_KLOVERIELL_RESPOND = "Yes, High Priestess"
local SAY_TEXT_AQUILA_RESPOND = "Oh very well. Kloveriell, see to it that these crystals are properly positioned around the city."

local function OnQuestComplete(event, player, quest)
    if quest:GetId() == QUEST_ID then
        local aquila = player:GetNearestCreature(20, NPC_ID_AQUILA) 
        local anotherNpc = player:GetNearestCreature(50, NPC_ID_ANOTHER_NPC)
        local kloveriell = player:GetNearestCreature(20, NPC_ID_KLOVERIELL)

        if aquila then
            aquila:CastSpell(aquila, SPELL_ID, false)
            local function AquilaSay(eventId, delay, repeats, worldobject)
                worldobject:SendUnitSay(SAY_TEXT_AQUILA, 0)
            end
            aquila:RegisterEvent(AquilaSay, 5500, 1) 
        end

        if anotherNpc then
            local function AnotherNpcSay(eventId, delay, repeats, worldobject)
                worldobject:SendUnitSay(SAY_TEXT_ANOTHER_NPC, 0)
                worldobject:PerformEmote(1) 
            end
            anotherNpc:RegisterEvent(AnotherNpcSay, 9000, 1)
        end

        if aquila then
            local function AquilaRespond(eventId, delay, repeats, worldobject)
                worldobject:SendUnitSay(SAY_TEXT_AQUILA_RESPOND, 0)
            end
            aquila:RegisterEvent(AquilaRespond, 14000, 1)
        end

        if kloveriell then
            local function KloveriellRespond(eventId, delay, repeats, worldobject)
                worldobject:SendUnitSay(SAY_TEXT_KLOVERIELL_RESPOND, 0)
                worldobject:PerformEmote(2)
            end
            kloveriell:RegisterEvent(KloveriellRespond, 20000, 1)
        end
    end
end

RegisterPlayerEvent(54, OnQuestComplete)
