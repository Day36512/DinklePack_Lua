local NPCID = 90004

local function ResetPlayerDisplayId(eventId, delay, repeats, player)
    if not player:IsMoving() then
        player:RegisterEvent(ResetPlayerDisplayId, 100, 1)
    else
        player:SetDisplayId(player:GetNativeDisplayId())
    end
end

local function PlatformTransportOnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to Ironforge!", 0, 1)
    player:GossipMenuAddItem(0, "Take me to the Airfields!", 0, 2)
    player:GossipSendMenu(1, creature)
end

local function PlatformTransportOnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(-5166.45, -877.49, 507.39, 2000, 165)

        player:RegisterEvent(ResetPlayerDisplayId, 26300, 1)
    elseif (intid == 2) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(-4492, -1588, 509, 2000, 85)

        player:RegisterEvent(ResetPlayerDisplayId, 12300, 1)
    end
end

RegisterCreatureGossipEvent(NPCID, 1, PlatformTransportOnGossipHello)
RegisterCreatureGossipEvent(NPCID, 2, PlatformTransportOnGossipSelect)
