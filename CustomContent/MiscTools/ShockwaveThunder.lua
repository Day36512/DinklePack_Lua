local SPELL_SHOCKWAVE = 46968
local SPELL_TO_LEARN = 920356
local SPELL_TO_UNLEARN = 920356

local function OnLearnSpell(event, player, spellId)
    if spellId == SPELL_SHOCKWAVE then
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
