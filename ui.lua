bedwars.huds = {}

bedwars.std_hud = {
	hud_elem_type = "text",
	position = {x = 0.85, y = 0.3},
	offset = {x = 20, y = 20},
	text = "Current map: -",
	alignment = {x = 1, y = 1},
	scale = {x = 100, y = 100},
	number = 0xFFFFFF,
}

minetest.register_on_joinplayer(function(player)
	bedwars.huds[player:get_player_name()] = player:hud_add(bedwars.std_hud)
	minetest.after(1, bedwars.ui_update, nil)
end)

bedwars.ui_update = function()
	local redbed, greenbed, bluebed, yellowbed
	if bedwars.beds.red then redbed = "+" end
	if bedwars.beds.green then greenbed = "+" end
	if bedwars.beds.blue then bluebed = "+" end
	if bedwars.beds.yellow then yellowbed = "+" end
	
	local text = "Current map: " .. bedwars.current_map .. "\n" ..
	bedwars.next_event_msg[bedwars.event + 1] .. ": " .. tostring(math.floor(bedwars.events[bedwars.event + 1] - (bedwars.timer or 0))) .. "\n\n" ..
	"R: " .. (redbed or #bedwars.teams.red) .. "\n" ..
	"G: " .. (greenbed or #bedwars.teams.green) .. "\n" ..
	"B: " .. (bluebed or #bedwars.teams.blue) .. "\n" ..
	"Y: " .. (yellowbed or #bedwars.teams.yellow)
	
	local players = minetest.get_connected_players()
	for _, player in ipairs(players) do
		player:hud_change(bedwars.huds[player:get_player_name()], "text", text)
	end
end
