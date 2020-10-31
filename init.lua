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
		if not bedwars.init then
			bedwars.init = true
			bedwars.event_timer_start()
			minetest.clear_objects({mode = "full"})
		end
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			inv:set_list(k, {})
		end
	end)
	
	minetest.register_on_dieplayer(function(player)
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			for _, itemstack in ipairs(v) do
				minetest.add_item(player:get_pos(), itemstack)
			end
		end
		for k, v in pairs(inv:get_lists()) do
			inv:set_list(k, {})
		end
	end)
end

bedwars.log("[bedwars] Loaded mod")
