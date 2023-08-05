local validDIET_itemIDs = {117, 118, 159, 414, 422, 724, 733, 787, 858, 929, 961, 1017, 1082, 1113, 1114, 1119, 1165, 1179, 1205, 1326, 1401, 1450, 1487, 1645, 1707, 1708, 1710, 2070, 2136, 2287, 2288, 2454, 2455, 2456, 2457, 2458, 2459, 2460, 2461, 2462, 2593, 2594, 2595, 2596, 2633, 2679, 2680, 2681, 2682, 2683, 2684, 2685, 2686, 2687, 2723, 2888, 2894, 3087, 3220, 3382, 3383, 3384, 3385, 3386, 3387, 3388, 3389, 3390, 3391, 3448, 3662, 3663, 3664, 3665, 3666, 3703, 3726, 3727, 3728, 3729, 3770, 3771, 3772, 3823, 3825, 3826, 3827, 3828, 3927, 3928, 4418, 4457, 4536, 4537, 4538, 4539, 4540, 4541, 4542, 4544, 4592, 4593, 4594, 4595, 4596, 4599, 4600, 4601, 4602, 4604, 4605, 4606, 4607, 4608, 4623, 4656, 4791, 5057, 5066, 5095, 5265, 5342, 5349, 5350, 5472, 5473, 5474, 5476, 5477, 5478, 5479, 5480, 5525, 5526, 5527, 5631, 5632, 5633, 5634, 5816, 5996, 5997, 6038, 6048, 6049, 6050, 6051, 6052, 6149, 6290, 6299, 6316, 6372, 6373, 6522, 6657, 6662, 6807, 6887, 6888, 6890, 7097, 7228, 7676, 7806, 7807, 7808, 8075, 8076, 8077, 8078, 8079, 8243, 8364, 8529, 8543, 8766, 8827, 8932, 8948, 8949, 8950, 8951, 8952, 8953, 8957, 9030, 9036, 9088, 9144, 9154, 9155, 9172, 9179, 9187, 9197, 9206, 9224, 9233, 9260, 9264, 9360, 9361, 9451, 9681, 10592, 10841, 11109, 11415, 11444, 11584, 11846, 11951, 12003, 12190, 12209, 12210, 12211, 12212, 12213, 12214, 12215, 12216, 12217, 12218, 12224, 12238, 12763, 12820, 13442, 13443, 13444, 13445, 13446, 13447, 13452, 13453, 13454, 13455, 13456, 13457, 13458, 13459, 13460, 13461, 13462, 13506, 13510, 13511, 13512, 13513, 13546, 13724, 13755, 13810, 13851, 13893, 13927, 13928, 13929, 13930, 13931, 13932, 13933, 13934, 13935, 16166, 16167, 16168, 16169, 16170, 16171, 16766, 16971, 17119, 17196, 17197, 17198, 17199, 17222, 17344, 17348, 17349, 17351, 17352, 17402, 17403, 17404, 17406, 17407, 17408, 17708, 18045, 18253, 18254, 18255, 18287, 18288, 18294, 18300, 18632, 18633, 18635, 18839, 18841, 19221, 19222, 19223, 19224, 19225, 19299, 19300, 19301, 19304, 19305, 19306, 19696, 19994, 19995, 19996, 20002, 20004, 20007, 20008, 20031, 20074, 20452, 20516, 20709, 20857, 21023, 21030, 21031, 21033, 21072, 21114, 21151, 21215, 21217, 21235, 21236, 21240, 21254, 21546, 21552, 21721, 22018, 22019, 22324, 22645, 22823, 22824, 22825, 22826, 22827, 22828, 22829, 22830, 22831, 22832, 22833, 22834, 22835, 22836, 22837, 22838, 22839, 22840, 22841, 22842, 22844, 22845, 22846, 22847, 22848, 22849, 22850, 22851, 22853, 22854, 22861, 22866, 22871, 22895, 23160, 23172, 23444, 23495, 23578, 23579, 23683, 23696, 23698, 23704, 23756, 23822, 23823, 23848, 23871, 24008, 24009, 24072, 24105, 24338, 24539, 25539, 27635, 27636, 27651, 27655, 27656, 27657, 27658, 27659, 27660, 27661, 27662, 27663, 27664, 27665, 27666, 27667, 27854, 27855, 27856, 27857, 27858, 27859, 27860, 28100, 28101, 28102, 28103, 28104, 28112, 28284, 28399, 28486, 28501, 29112, 29292, 29293, 29393, 29394, 29395, 29401, 29402, 29412, 29448, 29449, 29450, 29451, 29452, 29453, 29454, 30155, 30355, 30357, 30358, 30359, 30361, 30457, 30458, 30610, 30703, 30793, 30816, 31672, 31673, 31676, 31677, 31679, 31838, 31839, 31840, 31841, 31852, 31853, 31854, 31855, 32062, 32063, 32067, 32068, 32453, 32455, 32596, 32597, 32598, 32599, 32600, 32601, 32667, 32668, 32685, 32686, 32721, 32722, 32762, 32763, 32764, 32765, 32766, 32767, 32783, 32784, 32840, 32844, 32845, 32846, 32847, 32898, 32899, 32900, 32901, 32902, 32903, 32904, 32905, 32909, 32910, 32947, 32948, 33004, 33042, 33048, 33052, 33053, 33092, 33093, 33208, 33443, 33444, 33445, 33447, 33448, 33449, 33451, 33452, 33454, 33822, 33825, 33866, 33867, 33872, 33874, 33924, 33934, 33935, 34062, 34125, 34130, 34411, 34440, 34537, 34641, 34646, 34747, 34748, 34749, 34750, 34751, 34752, 34753, 34754, 34755, 34756, 34757, 34758, 34759, 34760, 34761, 34762, 34763, 34764, 34765, 34766, 34767, 34768, 34769, 34770, 34780, 34832, 35563, 35565, 35710, 35716, 35717, 35720, 35947, 35948, 35949, 35950, 35951, 35952, 35953, 35954, 36770, 36831, 36845, 37252, 37253, 37449, 37452, 37926, 38350, 38351, 38427, 38428, 38429, 38430, 38431, 38432, 38466, 38698, 38706, 39327, 39520, 39666, 39671, 39691, 39971, 40035, 40036, 40042, 40067, 40068, 40070, 40072, 40073, 40076, 40077, 40078, 40079, 40081, 40082, 40083, 40084, 40087, 40093, 40097, 40109, 40202, 40211, 40212, 40213, 40214, 40215, 40216, 40217, 40356, 40357, 40358, 40359, 40404, 40413, 40667, 40677, 41166, 41374, 41729, 41731, 41751, 42428, 42429, 42430, 42431, 42432, 42433, 42434, 42545, 42548, 42590, 42777, 42778, 42779, 42942, 42993, 42994, 42995, 42996, 42997, 42998, 42999, 43000, 43001, 43004, 43005, 43015, 43086, 43087, 43236, 43268, 43478, 43480, 43488, 43490, 43491, 43492, 43496, 43518, 43523, 43530, 43531, 43569, 43570, 43695, 43696, 44012, 44049, 44071, 44072, 44114, 44228, 44325, 44327, 44328, 44329, 44330, 44331, 44332, 44570, 44571, 44572, 44573, 44574, 44575, 44607, 44608, 44609, 44616, 44617, 44618, 44619, 44620, 44722, 44728, 44749, 44750, 44791, 44836, 44837, 44838, 44839, 44840, 44854, 44855, 44939, 44940, 44941, 44953, 45006, 45007, 45008, 45009, 45276, 45277, 45279, 45621, 45901, 45932, 46376, 46377, 46378, 46379, 46690, 46691, 46784, 46793, 46796, 46797, 46887, 47499, 49863, 50083, 50084, 50164, 50482, 50483, 50484, 60083, 800073} 

local function DIET_OnUse(event, player, item, target)
    if not player:HasItem(800084) then
        return
    end
	player:PlayDirectSound(183253)
    player:RemoveItem(800084, 1)
    player:CastSpell(player, 800003, true)
    local playerName = player:GetName()
    SendWorldMessage("|cFFFF0000Player " .. playerName .. " has failed the Diet Mode Challenge!|r")
end

for i, DIET_itemID in ipairs(validDIET_itemIDs) do
    RegisterItemEvent(DIET_itemID, 2, DIET_OnUse)
end
