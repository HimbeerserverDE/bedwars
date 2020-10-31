bedwars = {}

bedwars.init = false

bedwars.storage = minetest.get_mod_storage()

local mp = minetest.get_modpath(minetest.get_current_modname())

bedwars.log = function(msg)
	if not msg then return end
	minetest.log("action", "[bedwars] " .. msg)
end

dofile(mp .. "/map.lua")

local maps = {}
for _, map in ipairs(bedwars.maps) do
	table.insert(maps, map.name)
end

if #maps > 0 then
	dofile(mp .. "/shop.lua")
	dofile(mp .. "/team.lua")
	dofile(mp .. "/ui.lua")
	dofile(mp .. "/bed.lua")
	dofile(mp .. "/event.lua")
	dofile(mp .. "/forge.lua")
	dofile(mp .. "/dragon.lua")
	
	math.randomseed(os.clock())
	bedwars.current_map = maps[math.random(1, #maps)]
	
	minetest.register_on_joinplayer(function(player)
		if not bedwars.init then bedwars.init = true end
		bedwars.event_timer_start()
	end)
end

bedwars.log("[bedwars] Loaded mod")
