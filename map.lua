bedwars.maps = minetest.deserialize(bedwars.storage:get_string("maps")) or {}

minetest.register_privilege("bedwars_maps", {
	description = "Player can manage maps.",
})

bedwars.map_exists = function(name)
	for _, map in ipairs(bedwars.maps) do
		if map.name == name then return true end
	end
	return false
end

bedwars.map_add = function(def)
	table.insert(bedwars.maps, def)
end

bedwars.map_remove = function(name)
	for k, map in ipairs(bedwars.maps) do
		if map.name == name then bedwars.maps[k] = nil end
	end
end

bedwars.get_map_by_name = function(name)
	for _, map in ipairs(bedwars.maps) do
		if map.name == name then return map end
	end
end

minetest.register_chatcommand("map_add", {
	description = "Add a map",
	params = "<name> <red_x,red_y,red_z> <green_x,green_y,green_z> <blue_x,blue_y,blue_z> <yellow_x,yellow_y,yellow_z> <diamond1_x,diamond1_y,diamond1_z> <diamond2_x,diamond2_y,diamond2_z> <diamond3_x,diamond3_y,diamond3_z> <diamond4_x,diamond4_y,diamond4_z> <mese1_x,mese1_y,mese1_z> <mese2_x,mese2_y,mese2_z> <mese3_x,mese3_y,mese3_z> <mese4_x,mese4_y,mese4_z>",
	privs = {bedwars_maps},
	func = function(name, param)
		local params = {}
		local paramnames = {
			1 = "name",
			2 = "red",
			3 = "green",
			4 = "blue",
			5 = "yellow",
			6 = "diamond1",
			7 = "diamond2",
			8 = "diamond3",
			9 = "diamond4",
			10 = "mese1",
			11 = "mese2",
			12 = "mese3",
			13 = "mese4",
		}
		if #param:split(" ") return false, "Invalid arguments" end
		for k, v in ipairs(param:split(" ")) do
			params[paramnames[k]] = v
		end
		if bedwars.map_exists(params.name) then return false, "Map with same name already exists" end
		bedwars.map_add(params)
		return true, "Map added"
	end,
})

minetest.register_chatcommand("map_remove", {
	description = "Remove a map",
	params = "<name>",
	privs = {bedwars_maps = true},
	func = function(name, param)
		if param == "" then return false, "Invalid arguments" end
		bedwars.map_remove(param)
		return true, "Map removed"
	end,
})

minetest.register_chatcommand("map_list", {
	description = "List all maps",
	params = "",
	privs = {bedwars_maps = true},
	func = function(name, param)
		return true, dump(bedwars.maps)
	end,
})
