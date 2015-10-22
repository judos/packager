data:extend({
	{
		type = "recipe",
		name = "iron-ore-pack",
		icon = "__packager__/graphics/icons/iron-ore-pack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"iron-ore",woodChestSize},{"wooden-chest",1}},
		result = "iron-ore-box",
		result_count = 1,
		order = "a1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "iron-ore-unpack",
		icon = "__packager__/graphics/icons/iron-ore-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"iron-ore-box",1}},
		results= {
      {type="item", name="iron-ore", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "a2",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "copper-ore-pack",
		icon = "__packager__/graphics/icons/copper-ore-pack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"copper-ore",woodChestSize},{"wooden-chest",1}},
		result = "copper-ore-box",
		result_count = 1,
		order = "b1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "copper-ore-unpack",
		icon = "__packager__/graphics/icons/copper-ore-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"copper-ore-box",1}},
		results= {
      {type="item", name="copper-ore", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "b2",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "stone-pack",
		icon = "__packager__/graphics/icons/stone-pack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"stone",woodChestSize},{"wooden-chest",1}},
		result = "stone-box",
		result_count = 1,
		order = "c1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "stone-unpack",
		icon = "__packager__/graphics/icons/stone-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"stone-box",1}},
		results= {
      {type="item", name="stone", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "c2",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "coal-pack",
		icon = "__packager__/graphics/icons/coal-pack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"coal",woodChestSize},{"wooden-chest",1}},
		result = "coal-box",
		result_count = 1,
		order = "d1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "coal-unpack",
		icon = "__packager__/graphics/icons/coal-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"coal-box",1}},
		results= {
      {type="item", name="coal", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "d2",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "plastic-pack",
		icon = "__packager__/graphics/icons/plastic-pack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"plastic-bar",woodChestSize},{"wooden-chest",1}},
		result = "plastic-box",
		result_count = 1,
		order = "e1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "plastic-unpack",
		icon = "__packager__/graphics/icons/plastic-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_raw",
		energy_required = 0.5,
		ingredients = {{"plastic-box",1}},
		results= {
      {type="item", name="plastic-bar", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "e2",
		enabled = "true"
	},
})