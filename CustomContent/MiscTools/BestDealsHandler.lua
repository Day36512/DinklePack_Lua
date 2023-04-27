local EventLootMoney = 37
local RaceBonus = 9
local BonusMultiplier = 0.05

local function FormatCurrency(amount)
    local gold = math.floor(amount / 10000)
    local silver = math.floor((amount - (gold * 10000)) / 100)
    local copper = amount % 100

    local currency = ""
    if gold > 0 then
        currency = currency .. gold .. " gold "
    end
    if silver > 0 then
        currency = currency .. silver .. " silver "
    end
    if copper > 0 then
        currency = currency .. copper .. " copper"
    end

    return currency
end

local function OnLootMoney(eventId, player, amount)
    -- Check if the player's race is the one eligible for the bonus
    if player:GetRace() == RaceBonus then
        -- Calculate the bonus amount
        local bonusAmount = math.floor(amount * BonusMultiplier)

        -- Add the bonus amount to the player's current money
        player:ModifyMoney(bonusAmount)

        -- Format the bonus amount as gold, silver, and copper
        local formattedBonus = FormatCurrency(bonusAmount)

        -- Send a message to the player to inform them of the bonus
        player:SendBroadcastMessage("You have received a 5% bonus of " .. formattedBonus .. ".")
    end
end

RegisterPlayerEvent(EventLootMoney, OnLootMoney)
