bedwars.teams = {red = {}, green = {}, blue = {}, yellow = {}}

bedwars.get_biggest_team = function()
	local teamnames = {"red", "green", "blue", "yellow"}
	local lengths = {#bedwars.teams.red, #bedwars.teams.green, #bedwars.teams.blue, #bedwars.teams.yellow}
	local greatest = 0
	for k, v in ipairs(lengths) do
		if v > greatest then greatest = v end
	end
	for k, v in ipairs(lengths) do
		if v == greatest then return teamnames[k] end
	end
end

bedwars.get_smallest_team = function()
	local teamnames = {"red", "green", "blue", "yellow"}
	local lengths = {#bedwars.teams.red, #bedwars.teams.green, #bedwars.teams.blue, #bedwars.teams.yellow}
	local smallest = 5
	for k, v in ipairs(lengths) do
		if v < smallest then smallest = v end
	end
	for k, v in ipairs(lengths) do
		if v == smallest then return teamnames[k] end
	end
end

bedwars.assign_team = function(name)
	local team = bedwars.get_smallest_team()
	table.insert(bedwars.teams[team], name)
end

bedwars.get_player_team = function(name)
	for k, team in ipairs(bedwars.teams) do
		for _, pname in ipairs(team) do
			if name == pname then return k end
		end
	end
end

minetest.register_on_joinplayer(function(player)
	bedwars.assign_team(player:get_player_name())
	bedwars.ui_update()
end)

minetest.register_on_leaveplayer(function(player)
	local team = bedwars.teams[bedwars.get_player_team(player:get_player_name())]
	for k, pname in ipairs(team) do
		if player:get_player_name() == pname then team[k] = nil end
	end
	bedwars.ui_update()
end)

bedwars.get_team_by_pos = function(pos)
	local pos_str = minetest.pos_to_string(pos)
	local map = bedwars.get_map_by_name(bedwars.current_map)
	local team_pos_table = {red = map.red, green = map.green, blue = map.blue, yellow = map.yellow}
	local diffs = {}
	for team, teampos in pairs(team_pos_table) do
		local diff = {x = abs(pos.x - teampos.x), y = abs(pos.y - teampos.y), z = abs(pos.z - teampos.z)}
		diffs[team] = diff
	end
	local smallest = {x = 100, y = 100}
	for team, diff in pairs(diffs) do
		if diff.x < smallest.x then
			smallest.x = diff.x
		end
		if diff.z < smallest.z then
			smallest.z = diff.z
		end
	end
	for team, diff in pairs(diffs) do
		if smallest.x == diff.x and smallest.z == diff.z then
			return team
		end
	end
end
