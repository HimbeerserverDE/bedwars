bedwars.upgrades = {red = {}, green = {}, blue = {}, yellow = {}}

bedwars.item_shop_fs = "size[5,5]" ..
"item_image_button[1,1;1,1;default:sword_steel;steelsword;]item_image_button[2,1;1,1;default:sword_diamond;diamondsword;]" ..
"item_image_button[1,2;1,1;bow:bow_empty;bow;]item_image_button[2,2;1,1;bow:arrow;arrow;]" ..
"item_image_button[1,3;1,1;default:apple;apple;]item_image_button[2,3;1,1;tnt:tnt;tnt;]item_image_button[3,3;1,1;default:pick_steel;steelpick;]" ..
"item_image_button[1,4;1,1;wool:white;wool;]item_image_button[2,4;1,1;default:tinblock;tin;]"

minetest.register_node("bedwars:shop_item", {
	description = "Item shop",
	drawtype = "nodebox",
	tiles = {"shop_item.png"},
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
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("default:sword_steel")
		elseif fields.diamondsword then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 3 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 3 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 3)
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("default:sword_diamond")
		elseif fields.bow then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 8 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 8 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 8)
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("bow:bow_empty")
		elseif fields.arrow then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			sender:set_wielded_item(wielded)
			itemstack:set_count(16)
			itemstack:set_name("bow:arrow")
		elseif fields.apple then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 2 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 2 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 2)
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("default:apple")
		elseif fields.tnt then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 5 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 5 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 5)
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("tnt:tnt")
		elseif fields.steelpick then
			if wielded:get_name() ~= "default:gold_ingot" or wielded:get_count() < 10 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 10 gold to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 10)
			sender:set_wielded_item(wielded)
			itemstack:set_count(1)
			itemstack:set_name("default:pick_steel")
		elseif fields.wool then
			if wielded:get_name() ~= "default:steel_ingot" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 steel to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			sender:set_wielded_item(wielded)
			itemstack:set_count(16)
			itemstack:set_name("wool:" .. bedwars.get_player_team(sender:get_player_name()))
		elseif fields.tin then
			if wielded:get_name() ~= "default:mese_crystal" or wielded:get_count() < 4 then
				minetest.chat_send_player(sender:get_player_name(), "Wield 4 mese to buy this item")
				return
			end
			wielded:set_count(wielded:get_count() - 4)
			sender:set_wielded_item(wielded)
			itemstack:set_count(8)
			itemstack:set_name("default:tinblock")
		end
		sender:get_inventory():add_item("main", itemstack)
	end,
})

bedwars.team_shop_fs = "size[5,4]" ..
"item_image_button[1,1;1,1;default:furnace;forge;]item_image_button[2,1;1,1;default:sword_steel;sharpness;]item_image_button[3,1;1,1;default:flint;dragonbuff;]" ..
"item_image_button[1,2;1,1;default:brick;armour;]item_image_button[2,2;1,1;doors:trapdoor_steel;trap;]item_image_button[3,2;1,1;default:meselamp;healpool;]"

minetest.register_node("bedwars:shop_team", {
	description = "Team shop",
	drawtype = "nodebox",
	tiles = {"shop_team.png"},
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
		local team = bedwars.get_player_team(sender:get_player_team())
		if fields.forge then
			if bedwars.upgrades[team].forge >= 4 then
				minetest.chat_send_player(sender:get_player_name(), "The maximum forge upgrade is already active")
				return
			end
			if wielded:get_name() ~= "default:diamond" or wielded:get_count() < (2 ^ (bedwars.upgrades[team].forge + 1)) then
				minetest.chat_send_player(sender:get_player_name(), "Wield " .. tostring(2 ^ (bedwars.upgrades[team].forge + 1)) .. " diamonds to activate this upgrade")
				return
			end
			wielded:set_count(wielded:get_count() - (2 ^ (bedwars.upgrades[team].forge + 1)))
			bedwars.upgrades[team].forge = bedwars.upgrades[team].forge + 1
		end
		sender:set_wielded_item(wielded)
	end,
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if newnode and newnode.name == "tnt:tnt" then
		tnt.burn(pos)
	end
end)
