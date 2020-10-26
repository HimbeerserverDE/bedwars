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

-- TODO: Add team upgrades

local steel_timer = 0
minetest.register_globalstep(function(dtime)
	steel_timer = steel_timer + dtime
	if steel_timer >= 1 then
		local map = bedwars.get_map_by_name(bedwars.current_map)
		local forges = {minetest.string_to_pos(map.red), minetest.string_to_pos(map.green), minetest.string_to_pos(map.blue), minetest.string_to_pos(map.yellow)}
		for _, pos in ipairs(forges) do
			minetest.add_item(pos, "default:steel_ingot")
		end
		steel_timer = 0
	end
end)

local gold_timer = 0
minetest.register_globalstep(function(dtime)
	gold_timer = gold_timer + dtime
	if gold_timer >= 15 then
		local map = bedwars.get_map_by_name(bedwars.current_map)
		local forges = {minetest.string_to_pos(map.red), minetest.string_to_pos(map.green), minetest.string_to_pos(map.blue), minetest.string_to_pos(map.yellow)}
		for _, pos in ipairs(forges) do
			minetest.add_item(pos, "default:gold_ingot")
		end
		gold_timer = 0
	end
end)
