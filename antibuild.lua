bedwars.buyable_nodes = {"wool:red", "wool:green", "wool:blue", "wool:yellow", "default:wood", "default:obsidian"}

bedwars.is_buyable_node = function(node)
	for _, bnode in ipairs(bedwars.buyable_nodes) do
		if node.name == bnode then return true end
	end
	return false
end

minetest.register_privilege("build", {
	description = "Player can build and dig nodes",
})

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	itemstack:set_count(0)
	return itemstack
end)

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if not minetest.check_player_privs(placer:get_player_name(), {build = true}) and not bedwars.is_buyable_node(oldnode) then
		minetest.set_node(pos, oldnode)
		minetest.chat_send_player(placer:get_player_name(), "You can't place this node.")
	end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
	if not minetest.check_player_privs(digger:get_player_name(), {build = true}) and not bedwars.is_buyable_node(oldnode) then
		minetest.set_node(pos, oldnode)
		minetest.chat_send_player(digger:get_player_name(), "You can't dig this node.")
	end
end)
