local SPELL_BLADESTORM = 46924
local SPELL_TO_LEARN = 994999
local SPELL_TO_UNLEARN = 994999

local function OnLearnSpell(event, player, spellId)
    if spellId == SPELL_BLADESTORM then
        player:LearnSpell(SPELL_TO_LEARN)
    end
end

local function OnTalentsReset(event, player, noCost)
    if player:HasSpell(SPELL_TO_UNLEARN) then
        player:RemoveSpell(SPELL_TO_UNLEARN)
    end
end

RegisterPlayerEvent(44, OnLearnSpell)
RegisterPlayerEvent(17, OnTalentsReset)
