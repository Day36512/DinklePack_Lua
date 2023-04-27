-- 				Created and programmed by Senkuma				--

local function deathgateoncreate(event, player)
	if player:GetClass() == 6 then
	player:LearnSpell(50977)		-- Learn Death Gate (needed to leave dk starting zone)
	end
end


RegisterPlayerEvent(3, deathgateoncreate)