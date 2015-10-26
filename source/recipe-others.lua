data:extend({
	
	-- Disabled due to the wrong raw ressources calculation in factorio 0.12.8
	--[[
	{
		type = "recipe",
		name = "cable-pack",
		icon = "__packager__/graphics/icons/cable-pack.png",
		category = "packager-pack",
		subgroup = "packaging_others",
		energy_required = 0.5,
		ingredients = {{"copper-cable",woodChestSize},{"wooden-chest",1}},
		result = "cable-box",
		result_count = 1,
		order = "a1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "cable-unpack",
		icon = "__packager__/graphics/icons/cable-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_others",
		energy_required = 0.5,
		ingredients = {{"cable-box",1}},
		results= {
      {type="item", name="copper-cable", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "a2",
		enabled = "true"
	},
	]]--
	--[[
	{
		type = "recipe",
		name = "mixed-plates-pack",
		icon = "__packager__/graphics/icons/mixed-plates-pack.png",
		category = "packager-pack",
		subgroup = "packaging_others",
		energy_required = 0.5,
		ingredients = {{"iron-plate",woodChestSize/2},{"copper-plate",woodChestSize/2},{"wooden-chest",1}},
		result = "mixed-plates-box",
		result_count = 1,
		order = "b1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "mixed-plates-unpack",
		icon = "__packager__/graphics/icons/mixed-plates-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_others",
		energy_required = 0.5,
		ingredients = {{"mixed-plates-box",1}},
		results= {
      {type="item", name="iron-plate", amount=woodChestSize/2},
			{type="item", name="copper-plate", amount=woodChestSize/2},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "b2",
		enabled = "true"
	},
	]]--
})