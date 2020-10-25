bedwars.beds = {red = true, green = true, blue = true, yellow = true}

bedwars.str_to_colour = function(str)
	local codes = {red = "#FF0000", green = "#00FF00", blue = "#0000FF", yellow = "#FFFF00"}
	return codes[str]
end

minetest.register_on_dignode(function(pos, oldnode, digger)
	if oldnode.name == "beds:bed_bottom" then
		bedwars.beds[bedwars.get_team_by_pos(pos)] = false
		minetest.chat_send_all("Team " .. minetest.colorize(bedwars.str_to_colour(bedwars.get_team_by_pos(pos)), bedwars.get_team_by_pos(pos)) .. "'s bed has been destroyed by " .. digger:get_player_name())
		minetest.sound_play("bed_destruction", {
			pos = pos,
			max_hear_distance = 100,
			gain = 2.0,
		})
		bedwars.ui_update()
	end
end)

minetest.register_on_dieplayer(function(player)
	minetest.chat_send_all(minetest.colorize(bedwars.str_to_colour(bedwars.get_player_team(player:get_player_name())), player:get_player_name()) .. " died")
end)

minetest.register_on_respawnplayer(function(player)
	player:set_pos(minetest.string_to_pos(bedwars.get_map_by_name(bedwars.current_map)[bedwars.get_player_team(player:get_player_name())]))
	return true
end)
