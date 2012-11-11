-- Minetest 0.4 mod: lamps
-- See README.txt for licensing and other information.

minetest.register_craft({
	output = 'lamps:lamp_off',
	recipe = {
		{'default:coal_lump'},
		{'default:steel_ingot'},
	}
})

--
-- Node definitions
--
minetest.register_node("lamps:lamp_off", {
	description = "Lamp",
	drawtype = "torchlike",
	tiles = {"lamps_lamp_on_floor.png", "lamps_lamp_on_ceiling.png", "lamps_lamp.png"},
	inventory_image = "lamps_lamp_on_floor.png",
	wield_image = "lamps_lamp_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	sounds = default.node_sound_defaults(),

	on_construct = function(pos)
		local timer = minetest.env:get_node_timer(pos)
		timer:start(1)
	end,

	on_timer = function(pos, elapsed)
		if minetest.env:get_timeofday() >= 0.75 or minetest.env:get_timeofday() < 0.25 then
			oldnode = minetest.env:get_node(pos)
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="lamps:lamp_on", param2=oldnode.param2})
		else
			local timer = minetest.env:get_node_timer(pos)
			timer:start(30)
			return true
		end
	end,
})

minetest.register_node("lamps:lamp_on", {
	description = "Burning Lamp",
	drawtype = "torchlike",
	tiles = {"lamps_lamp_on_floor.png", "lamps_lamp_on_ceiling.png", "lamps_lamp.png"},
	inventory_image = "lamps_lamp_on_floor.png",
	wield_image = "lamps_lamp_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	sounds = default.node_sound_defaults(),

	on_construct = function(pos)
		local timer = minetest.env:get_node_timer(pos)
		timer:start(1)
	end,

	on_timer = function(pos, elapsed)
		if minetest.env:get_timeofday() >= 0.25 and minetest.env:get_timeofday() < 0.75 then
			oldnode = minetest.env:get_node(pos)
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="lamps:lamp_off", param1=LIGHT_MAX-1, param2=oldnode.param2})
		else
			local timer = minetest.env:get_node_timer(pos)
			timer:start(30)
		end
		return true
	end,
})

