local enabled = false -- set to true to enable
local additionalAurasEnabled = true -- set to true if you want to use a spectral type aura visual instead of the ghost wolf or druid forms

-- enable or disable specific forms
local auraConfig = {
    [768] = false,   -- Cat Form
    [5487] = false,  -- Bear Form
    [9634] = false,  -- Dire Bear Form
    [783] = false,   -- Travel Form
    [2645] = false,  -- Ghost Wolf
    [24858] = true, -- Moonkin Form
    [33891] = true, -- Tree Form

}

local function OnSpellCast(event, player, spell, skipCheck)
    player:RegisterEvent(DisplayChange, 10, 1)
end

function DisplayChange(event, delay, pCall, player)
    local displayId = player:GetDisplayId()
    local PM = player:GetNativeDisplayId()

    local activeForm = (player:GetAura(768) and auraConfig[768]) or
                       (player:GetAura(5487) and auraConfig[5487]) or
                       (player:GetAura(9634) and auraConfig[9634]) or
                       (player:GetAura(783) and auraConfig[783]) or
                       (player:GetAura(2645) and auraConfig[2645]) or
                       (player:GetAura(24858) and auraConfig[24858]) or
                       (player:GetAura(33891) and auraConfig[33891]) -- Added Tree Form

    -- Apply additional auras if enabled and there is an active form
    if additionalAurasEnabled and activeForm then
        player:AddAura(35838, player)
        player:AddAura(22650, player)
    else
        -- Remove additional auras if they are not enabled or there is no active form
        player:RemoveAura(35838)
        player:RemoveAura(22650)
    end

    if activeForm then
        player:SetDisplayId(PM)
    end
end

if enabled then
    RegisterPlayerEvent(5, OnSpellCast)
end
