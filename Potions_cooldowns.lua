--[[
--Manages the cooldown for a list of potion items that players can use. 
--When a player uses a potion item from the list, the script registers an event to reset the cooldown of that potion item for the player after a set period of time (3 seconds in this case). 
--This allows the player to use the same potion item again after the cooldown has been reset. The script only runs if the enabled variable is set to true.

local enabled = false
local cooldown = 3000 --1000 = 1 second
local spellid = 0
local itemid = 0
local Potions = {118, 858, 929, 1710, 2454, 2455, 2456, 2457, 2458, 2459, 2633, 3087, 3382, 3383, 3384, 3385, 3386, 3387, 3388, 3389, 3390, 3391, 3823, 3825, 3826, 3827, 3828, 3928, 4596, 4623, 5631, 5633, 5634, 5816, 5996, 5997, 6048, 6049, 6050, 6051, 6052, 6149, 6372, 6373, 6662, 8529, 8949, 8951, 9030, 9036, 9088, 9144, 9154, 9155, 9172, 9179, 9187, 9197, 9206, 9224, 9233, 9264, 10592, 12190, 12820, 13442, 13443, 13444, 13445, 13446, 13447, 13452, 13453, 13454, 13455, 13456, 13457, 13458, 13459, 13461, 13462, 13506, 17348, 17349, 17351, 17352, 17708, 18253, 18294, 18839, 18841, 20002, 20004, 20007, 20008, 21546, 22823, 22824, 22825, 22826, 22827, 22828, 22829, 22830, 22831, 22832, 22833, 22834, 22835, 22836, 22837, 22838, 22839, 22840, 22841, 22842, 22844, 22845, 22846, 22847, 22848, 22849, 22850, 22871, 23444, 23578, 23579, 23822, 23823, 23871, 25539, 28100, 28101, 28102, 28103, 28104, 31676, 31677, 31679, 31838, 31839, 31840, 31841, 31852, 31853, 31854, 31855, 32062, 32063, 32067, 32068, 32783, 32784, 32840, 32844, 32845, 32846, 32847, 32902, 32903, 32904, 32905, 32909, 32910, 32947, 32948, 8827, 33092, 33093, 34440, 33934, 33935, 34130, 34537, 2460, 13460, 33447, 33448, 36770, 37449, 38351, 39327, 39666, 39671, 40067, 40068, 40070, 40072, 40073, 40076, 40077, 40078, 40081, 40087, 40093, 40097, 40109, 40211, 40212, 40213, 40214, 40215, 40216, 40217, 41166, 42545, 43530, 43531, 43569, 43570, 44012, 44325, 44327, 44328, 44329, 44330, 44331, 44332, 45621, 5632, 32762, 32763, 44728, 45276, 45277, 1450 }


local function ResetCooldown(player)

if spellid ~= 0 then
player:ResetSpellCooldown( spellid, true )
end

end

local function cooldownevent(eventid, delay, repeats, player)
ResetCooldown(player)
end


local function Item_cooldown(event, player, item, target)
spellid = item:GetSpellId(0)
itemid = item:GetEntry()
--player:AddItem( itemid, 1 ) --unlimited item
player:RegisterEvent(cooldownevent, cooldown, 0, player)
end

if enabled then
for k,v in pairs(Potions) do
RegisterItemEvent( v, 2, Item_cooldown )
end
end
]]