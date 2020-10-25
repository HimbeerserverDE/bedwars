bedwars.huds = {}

bedwars.std_hud = {
	hud_elem_type = "text",
	position = {x = 0.9, y = 0.5},
	offset = {x = 20, y = 20},
	text = "You",
	alignment = {x = 1, y = 1},
	scale = {x = 100, y = 100},
	number = 0xFFFFFF,
}

minetest.register_on_joinplayer(function(player)
	bedwars.huds[player:get_player_name()] = player:hud_add(bedwars.std_hud)
	bedwars.ui_update()
end)

bedwars.ui_update = function()
	
end
