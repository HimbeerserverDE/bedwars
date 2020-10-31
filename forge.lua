local dia_timer = 0
minetest.register_globalstep(function(dtime)
	local wait = 45
	if bedwars.event >= 3 then
		wait = 15
	elseif bedwars.event >= 1 then
		wait = 30
	end
	
	dia_timer = dia_timer + dtime
	if dia_timer >= wait then
		local map = bedwars.get_map_by_name(bedwars.current_map)
		local forges = {minetest.string_to_pos(map.diamond1), minetest.string_to_pos(map.diamond2), minetest.string_to_pos(map.diamond3), minetest.string_to_pos(map.diamond4)}
		for _, pos in ipairs(forges) do
			minetest.add_item(pos, "default:diamond")
		end
		dia_timer = 0
	end
end)

local mese_timer = 0
minetest.register_globalstep(function(dtime)
	local wait = 45
	if bedwars.event >= 4 then
		wait = 15
	elseif bedwars.event >= 2 then
		wait = 30
	end
	
	mese_timer = mese_timer + dtime
	if mese_timer >= wait then
		local map = bedwars.get_map_by_name(bedwars.current_map)
		local forges = {minetest.string_to_pos(map.mese1), minetest.string_to_pos(map.mese2), minetest.string_to_pos(map.mese3), minetest.string_to_pos(map.mese4)}
		for _, pos in ipairs(forges) do
			minetest.add_item(pos, "default:mese_crystal")
		end
		mese_timer = 0
	end
end)

local steel_timer = {red = 0, green = 0, blue = 0, yellow = 0}
minetest.register_globalstep(function(dtime)
	for k, v in pairs(steel_timer) do
		steel_timer[k] = v + dtime
	end
	local map = bedwars.get_map_by_name(bedwars.current_map)
	local forges = {minetest.string_to_pos(map.red), minetest.string_to_pos(map.green), minetest.string_to_pos(map.blue), minetest.string_to_pos(map.yellow)}
	for _, pos in ipairs(forges) do
		local team = bedwars.get_team_by_pos(pos)
		if steel_timer[team] >= (5 - bedwars.upgrades[team].forge) then
			minetest.add_item(pos, "default:steel_ingot")
			steel_timer[team] = 0
		end
	end
end)

local gold_timer = {red = 0, green = 0, blue = 0, yellow = 0}
minetest.register_globalstep(function(dtime)
	for k, v in pairs(gold_timer) do
		gold_timer[k] = v + dtime
	end
	local map = bedwars.get_map_by_name(bedwars.current_map)
	local forges = {minetest.string_to_pos(map.red), minetest.string_to_pos(map.green), minetest.string_to_pos(map.blue), minetest.string_to_pos(map.yellow)}
	for _, pos in ipairs(forges) do
		local team = bedwars.get_team_by_pos(pos)
		if steel_timer[team] >= (9 - bedwars.upgrades[team].forge) then
			minetest.add_item(pos, "default:gold_ingot")
			gold_timer[team] = 0
		end
	end
end)

local team_mese_timer = {red = 0, green = 0, blue = 0, yellow = 0}
minetest.register_globalstep(function(dtime)
	for k, v in pairs(team_mese_timer) do
		team_mese_timer[k] = v + dtime
	end
	local map = bedwars.get_map_by_name(bedwars.current_map)
	local forges = {minetest.string_to_pos(map.red), minetest.string_to_pos(map.green), minetest.string_to_pos(map.blue), minetest.string_to_pos(map.yellow)}
	for _, pos in ipairs(forges) do
		local team = bedwars.get_team_by_pos(pos)
		if team_mese_timer[team] >= 30 and bedwars.upgrades[team].forge >= 3 then
			minetest.add_item(pos, "default:mese_crystal " .. tostring(bedwars.upgrades[team].forge - 2))
			team_mese_timer[team] = 0
		end
	end
end)
