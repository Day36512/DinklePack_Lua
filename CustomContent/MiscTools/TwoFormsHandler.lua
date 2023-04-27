local function OnFirstLogin(event, player)
    local race = player:GetRace()
    local gender = player:GetGender()

    if race == 16 then
        if gender == 1 then
            player:LearnSpell(97710) -- Female
        elseif gender == 0 then
            player:LearnSpell(97709) -- Male
        end
    end
end

RegisterPlayerEvent(30, OnFirstLogin)
