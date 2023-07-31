local SPELL_ID = 100191
local AURA_1 = 100003
local AURA_2 = 100168
local AURA_3 = 80112
local SOUND_ID = 183255

local function PlaySound(eventId, delay, repeats, killed)
    killed:PlayDirectSound(SOUND_ID)
end

function OnKilledByCreature(event, killer, killed)
    if (killed:HasAura(AURA_1) or killed:HasAura(AURA_2) or killed:HasAura(AURA_3)) then
        if not killed:HasSpellCooldown(SPELL_ID) then
            killed:CastSpell(killed, SPELL_ID, false)
            killed:RegisterEvent(PlaySound, 4500, 1) 
        end
    end
end

RegisterPlayerEvent(8, OnKilledByCreature)
