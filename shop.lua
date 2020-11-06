bedwars.upgrades = {red = {}, green = {}, blue = {}, yellow = {}}

bedwars.item_shop_fs = "size[6,6]" ..
"item_image_button[1,1;1,1;default:sword_steel;steelsword;]item_image_button[2,1;1,1;default:sword_diamond;diamondsword;]" ..
"item_image_button[1,2;1,1;bow:bow_empty;bow;]item_image_button[2,2;1,1;bow:arrow;arrow;]" ..
"item_image_button[1,3;1,1;default:apple;apple;]item_image_button[2,3;1,1;tnt:tnt;tnt;]item_image_button[3,3;1,1;default:pick_steel;steelpick;]item_image_button[4,3;1,1;default:pick_diamond;diamondpick;]" ..
"item_image_button[1,4;1,1;wool:white;wool;]item_image_button[2,4;1,1;default:tinblock;tin;]item_image_button[3,4;1,1;default:wood;wood;]item_image_button[4,4;1,1;default:axe_steel;steelaxe;]"

minetest.register_node("bedwars:shop_item", {
	description = "Item shop",
	drawtype = "nodebox",
	tiles = {"shop_item_side.png", "shop_item_side.png",  "shop_item_side.png",  "shop_item_side.png",  "shop_item_side.png", "shop_item_front.png"},
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
	groups = {snappy = 3},
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("formspec", bedwars.item_shop_fs)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local itemstack = ItemStack("")
		local wielded = sender:get_wielded_item()
		if fields.steelsword then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 3 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 3 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 3)
			itemstack:set_count(1)
			itemstack:set_name("default:sword_steel")
		elseif fields.diamondsword then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 3 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 3 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 3)
			itemstack:set_count(1)
			itemstack:set_name("default:sword_diamond")
		elseif fields.bow then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 8 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 8 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 8)
			itemstack:set_count(1)
			itemstack:set_name("bow:bow_empty")
		elseif fields.arrow then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			itemstack:set_count(16)
			itemstack:set_name("bow:arrow")
		elseif fields.apple then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 2 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 2 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 2)
			itemstack:set_count(1)
			itemstack:set_name("default:apple")
		elseif fields.tnt then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 5 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 5 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 5)
			itemstack:set_count(1)
			itemstack:set_name("tnt:tnt")
		elseif fields.steelpick then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 10 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 10 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 10)
			itemstack:set_count(1)
			itemstack:set_name("default:pick_steel")
		elseif fields.diamondpick then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 24 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 24 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 24)
			itemstack:set_count(1)
			itemstack:set_name("default:pick_diamond")
		elseif fields.wool then
			if wielded:get_name() ~= "default:steel_ingot" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 steel to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			itemstack:set_count(16)
			itemstack:set_name("wool:" .. bedwars.get_player_team(sender:get_player_name()))
		elseif fields.tin then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			itemstack:set_count(8)
			itemstack:set_name("default:tinblock")
		elseif fields.wood then
			if wielded:get_name() ~= "default:steel_ingot" or wielded:get_count() < 32 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 32 steel to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 32)
			itemstack:set_count(16)
			itemstack:set_name("default:wood")
		elseif fields.steelaxe then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 12 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 12 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 12)
			itemstack:set_count(1)
			itemstack:set_name("default:axe_steel")
		end
		sender:set_wielded_item(wielded)
		sender:get_inventory():add_item("main", itemstack)
	end,
})

bedwars.team_shop_fs = "size[5,4]" ..
"item_image_button[1,1;1,1;default:furnace;forge;]item_image_button[2,1;1,1;default:sword_steel;sharpness;]item_image_button[3,1;1,1;default:flint;dragonbuff;]" ..
"item_image_button[1,2;1,1;default:brick;armour;]item_image_button[2,2;1,1;doors:trapdoor_steel;trap;]item_image_button[3,2;1,1;default:meselamp;healpool;]"

minetest.register_node("bedwars:shop_team", {
	description = "Team shop",
	drawtype = "nodebox",
	tiles = {"shop_team_side.png",  "shop_team_side.png",  "shop_team_side.png",  "shop_team_side.png",  "shop_team_side.png", "shop_team_front.png"},
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
	groups = {snappy = 3},
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("formspec", bedwars.team_shop_fs)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local wielded = sender:get_wielded_item()
		local team = bedwars.get_player_team(sender:get_player_name())
		if fields.forge then
			if (bedwars.upgrades[team].forge or 0) >= 4 then
				minetest.chat_send_player(sender:get_player_name(), "The maximum forge upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < (2 ^ ((bedwars.upgrades[team].forge or 0) + 1)) then
				minetest.chat_send_player(sender:get_player_name(), "Wield " .. tostring(2 ^ ((bedwars.upgrades[team].forge or 0) + 1)) .. " diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - (2 ^ ((bedwars.upgrades[team].forge or 0) + 1)))
			bedwars.upgrades[team].forge = (bedwars.upgrades[team].forge or 0) + 1
		elseif fields.sharpness then
			if bedwars.upgrades[team].sharpness then
				minetest.chat_send_player(sender:get_player_name(), "The sharpness upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < 2 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 2 diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - 2)
			bedwars.upgrades[team].sharpness = true
		elseif fields.dragonbuff then
			if bedwars.upgrades[team].dragonbuff then
				minetest.chat_send_player(sender:get_player_name(), "The dragon buff upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < 5 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 5 diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - 5)
			bedwars.upgrades[team].dragonbuff = true
		elseif fields.armour then
			if (bedwars.upgrades[team].armour or 0) >= 4 then
				minetest.chat_send_player(sender:get_player_name(), "The maximum armour upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < (2 ^ ((bedwars.upgrades[team].armour or 0) + 2)) then
				minetest.chat_send_player(sender:get_player_name(), "Wield " .. tostring(2 ^ ((bedwars.upgrades[team].armour or 0) + 2)) .. " diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - (2 ^ ((bedwars.upgrades[team].armour or 0) + 2)))
			bedwars.upgrades[team].armour = (bedwars.upgrades[team].armour or 0) + 1
		elseif fields.trap then
			if bedwars.upgrades[team].trap then
				minetest.chat_send_player(sender:get_player_name(), "The trap upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < 1 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 1 diamond to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - 1)
			bedwars.upgrades[team].trap = true
		elseif fields.healpool then
			if bedwars.upgrades[team].healpool then
				minetest.chat_send_player(sender:get_player_name(), "The healpool upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < 3 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 3 diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - 3)
			bedwars.upgrades[team].healpool = true
		end
		sender:set_wielded_item(wielded)
	end,
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if newnode and newnode.name == "tnt:tnt" then
		tnt.burn(pos)
	end
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	if hitter:is_player() and bedwars.upgrades[bedwars.get_player_team(hitter:get_player_name())].sharpness then
		player:set_hp(player:get_hp() - damage - 4 + (bedwars.upgrades[bedwars.get_player_team(player:get_player_name())].armour or 0))
		return true
	elseif not hitter:is_player() then
		if player:get_hp() - damage + (bedwars.upgrades[bedwars.get_player_team(player:get_player_name())].armour or 0) < player:get_hp() then
			player:set_hp(player:get_hp() - damage + (bedwars.upgrades[bedwars.get_player_team(player:get_player_name())].armour or 0))
			return true
		end
	end
end)

minetest.register_abm({
	label = "trap",
	nodenames = {"beds:bed_bottom"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local team = bedwars.get_team_by_pos(pos)
		if not bedwars.upgrades[team].trap then return end
		local objs = minetest.get_objects_inside_radius(pos, 7)
		for _, obj in ipairs(objs) do
			if obj:is_player() and bedwars.get_player_team(obj:get_player_name()) ~= team then
				for _, name in ipairs(bedwars.teams[team]) do
					minetest.chat_send_player(name, "Your trap has been set off")
					bedwars.upgrades[team].trap = false
				end
			end
		end
	end,
})

minetest.register_abm({
	label = "healpool",
	nodenames = {"beds:bed_bottom"},
	interval = 3,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local team = bedwars.get_team_by_pos(pos)
		if not bedwars.upgrades[team].healpool then return end
		local objs = minetest.get_objects_inside_radius(pos, 7)
		for _, obj in ipairs(objs) do
			if obj:is_player() and bedwars.get_player_team(obj:get_player_name()) == team then
				obj:set_hp(obj:get_hp() + 1)
			end
		end
	end,
})
