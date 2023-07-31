local ITEM_PACIFIST = 800051
local SPELL_FAILURE = 80092
local HasItem = function(player, itemId) return player:HasItem(itemId) end
local IsPlayer = function(unit) return unit:IsPlayer() end

local function OnKill(event, killer, killed)
    if IsPlayer(killer) and HasItem(killer, ITEM_PACIFIST) then
        killer:CastSpell(killer, SPELL_FAILURE, true)
        killer:RemoveItem(ITEM_PACIFIST, 1)
		killer:PlayDirectSound(183253)
        killer:SendBroadcastMessage("|cFFFF0000You have failed the pacifist challenge mode!|r")
    end
end

RegisterPlayerEvent(6, OnKill)
RegisterPlayerEvent(7, OnKill)
