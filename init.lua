bedwars = {}

bedwars.init = false

bedwars.storage = minetest.get_mod_storage()

math.randomseed(os.clock())

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
	dofile(mp .. "/chest.lua")
	dofile(mp .. "/antibuild.lua")
	
	bedwars.current_map = maps[math.random(1, #maps)]
	
	minetest.register_on_joinplayer(function(player)
		player:set_hp(20)
		minetest.after(0, function(player)
			local itemstack = ItemStack("default:sword_stone")
			player:set_wielded_item(itemstack)
		end, player)
		if not bedwars.init then
			bedwars.init = true
			bedwars.event_timer_start()
			minetest.clear_objects({mode = "quick"})
			minetest.after(5, function(player)
				for _, attr in pairs(bedwars.get_map_by_name(bedwars.current_map)) do
					local centre = minetest.string_to_pos(attr) or player:get_pos()
					for x = centre.x - 30, centre.x + 30 do
						for y = centre.y - 30, centre.y + 30 do
							for z = centre.z - 30, centre.z + 30 do
								local pos = {x = x, y = y, z = z}
								local node = minetest.get_node(pos)
								if bedwars.is_buyable_node(node) then
									minetest.set_node(pos, {name = "air"})
								end
								if node.name == "bedwars:chest" then
									minetest.get_inventory({type = "node", pos = pos}):set_list("tc", {})
								end
							end
						end
					end
				end
			end, player)
		end
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			inv:set_list(k, {})
		end
	end)
	
	minetest.register_on_dieplayer(function(player)
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			if k ~= "ec" then
				for _, itemstack in ipairs(v) do
					minetest.add_item(player:get_pos(), itemstack)
				end
			end
		end
		for k, v in pairs(inv:get_lists()) do
			if k ~= "ec" then
				inv:set_list(k, {})
			end
		end
	end)
end

bedwars.log("Loaded mod")
