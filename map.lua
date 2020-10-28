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

minetest.register_chatcommand("map_default", {
	description = "Add map with default attribs",
	params = "<name>",
	privs = {bedwars_maps = true},
	func = function(name, param)
		if not param or param == "" then return false, "Invalid arguments" end
		if bedwars.map_exists(param) then return false, "Map with same name already exists" end
		local template = {
			name = param,
			red = "100,100,100",
			green = "100,100,100",
			blue = "100,100,100",
			yellow = "100,100,100",
			diamond1 = "100,100,100",
			diamond2 = "100,100,100",
			diamond3 = "100,100,100",
			diamond4 = "100,100,100",
			mese1 = "100,100,100",
			mese2 = "100,100,100",
			mese3 = "100,100,100",
			mese4 = "100,100,100",
		}
		bedwars.map_add(template)
		return true, "Map added, please modify the attributes now with /map_modify"
	end,
})

minetest.register_chatcommand("map_modify", {
	description = "Modify map attributes",
	params = "<map_name> <attrib_name> [<x>,<y>,<z>]",
	privs = {bedwars_maps = true},
	func = function(name, param)
		local map_name = param:split(" ")[1]
		local key = param:split(" ")[2]
		local value = param:split(" ")[3]
		if not minetest.string_to_pos(value) then return false, "Invalid arguments" end
		if not map_name or not key then return false, "Invalid arguments" end
		local valid = false
		local valid_attribs = {"red", "green", "blue", "yellow", "diamond1", "diamond2", "diamond3", "diamond4", "mese1", "mese2", "mese3", "mese4"}
		for _, v in ipairs(valid_attribs) do
			if key == v then
				valid = true
				break
			end
		end
		
		bedwars.maps[map_name][key] = value or minetest.pos_to_string(minetest.get_player_by_name(name):get_pos())
		return true, "Attribute changed to current position"
	end,
})

minetest.register_chatcommand("map_add", {
	description = "Add a map",
	params = "<name> <red_x,red_y,red_z> <green_x,green_y,green_z> <blue_x,blue_y,blue_z> <yellow_x,yellow_y,yellow_z> <diamond1_x,diamond1_y,diamond1_z> <diamond2_x,diamond2_y,diamond2_z> <diamond3_x,diamond3_y,diamond3_z> <diamond4_x,diamond4_y,diamond4_z> <mese1_x,mese1_y,mese1_z> <mese2_x,mese2_y,mese2_z> <mese3_x,mese3_y,mese3_z> <mese4_x,mese4_y,mese4_z>",
	privs = {bedwars_maps = true},
	func = function(name, param)
		local params = {}
		local paramnames = {
			"name",
			"red",
			"green",
			"blue",
			"yellow",
			"diamond1",
			"diamond2",
			"diamond3",
			"diamond4",
			"mese1",
			"mese2",
			"mese3",
			"mese4",
		}
		if #param:split(" ") ~= 13 then return false, "Invalid arguments" end
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

minetest.register_on_shutdown(function()
	bedwars.storage:set_string("maps", minetest.serialize(bedwars.maps))
end)

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= 2 then
		local players = minetest.get_connected_players()
		for _, player in ipairs(players) do
			if player:get_pos().y < 80 then
				player:set_hp(0)
			end
		end
		timer = 0
	end
end)
