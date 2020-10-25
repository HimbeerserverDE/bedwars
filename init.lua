bedwars = {}

bedwars.storage = minetest.get_mod_storage()

local mp = minetest.get_modpath(minetest.get_current_modname())

dofile(mp .. "/shop.lua")
dofile(mp .. "/map.lua")
dofile(mp .. "/team.lua")
dofile(mp .. "/ui.lua")
dofile(mp .. "/bed.lua")

bedwars.log = function(msg)
	if not msg then return end
	minetest.log("action", "[bedwars] " .. msg)
end

local maps = {}
for _, map in ipairs(bedwars.maps) do
	table.insert(maps, map.name)
end

math.randomseed(os.clock())
bedwars.current_map = maps[math.random(1, #maps)]

bedwars.log("[bedwars] Loaded mod")
