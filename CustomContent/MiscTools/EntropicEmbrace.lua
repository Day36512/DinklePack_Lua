local SPELL_CAST_100234 = 100234
local SPELL_CAST_72313 = 72313
local EMOTE_ROAR = 53

local function OnCast100234(event, player, spell)
    if spell:GetEntry() == SPELL_CAST_100234 then
        player:CastSpell(player, SPELL_CAST_72313, true)
        player:PerformEmote(EMOTE_ROAR)
    end
end

RegisterPlayerEvent(5, OnCast100234)
