local function OnPlayerLevelUp(event, player, newLevel)
  if newLevel == 59 and player:HasItem(90000, 1) then
    player:AddItem(36941, 1)
    player:LearnSpell(100125)
	player:LearnSpell(53082)
    SendWorldMessage(player:GetName() .. " has reached level 60 without dying on Hardcore Mode! CONGRATULATIONS!")
  end
end

RegisterPlayerEvent(13, OnPlayerLevelUp)