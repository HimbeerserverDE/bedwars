bedwars.echest_fs = "size[10,7]" ..
"list[current_player;ec;1,1;8,3;]" ..
"list[current_player;main;1,5;8,1;]"

bedwars.chest_fs = "size[10,7]" ..
"list[context;tc;1,1;8,3;]" ..
"list[current_player;main;1,5;8,1;]"

minetest.register_node("bedwars:echest", {
	description = "Ender chest",
	tiles = {"echest_top.png", "echest_bottom.png", "echest_right.png", "echest_left.png", "echest_back.png", "echest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sunlight_propagates = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	groups = {choppy = 3},
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("formspec", bedwars.echest_fs)
	end,
})

minetest.register_node("bedwars:chest", {
	description = "Team chest",
	tiles = {"chest_top.png", "chest_bottom.png", "chest_right.png", "chest_left.png", "chest_back.png", "chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sunlight_propagates = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	groups = {choppy = 3},
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("formspec", bedwars.chest_fs)
		minetest.get_inventory({type = "node", pos = pos}):set_size("tc", 24)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if bedwars.get_team_by_pos(pos) == bedwars.get_player_team(player:get_player_name()) then return count end
		return 0
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if bedwars.get_team_by_pos(pos) == bedwars.get_player_team(player:get_player_name()) then return stack:get_count() end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if bedwars.get_team_by_pos(pos) == bedwars.get_player_team(player:get_player_name()) then return stack:get_count() end
		return 0
	end,
})

minetest.register_on_joinplayer(function(player)
	player:get_inventory():set_size("ec", 24)
end)
