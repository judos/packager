data:extend(
{
	{
		type = "recipe",
		name = "iron-pack",
		icon = "__packager__/graphics/icons/iron-pack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"iron-plate",woodChestSize},{"wooden-chest",1}},
		result = "iron-box",
		result_count = 1,
		order = "a1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "iron-unpack",
		icon = "__packager__/graphics/icons/iron-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"iron-box",1}},
		results= {
      {type="item", name="iron-plate", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "a2",
		enabled = "true"
	},
	
	{
		type = "recipe",
		name = "copper-pack",
		icon = "__packager__/graphics/icons/copper-pack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"copper-plate",woodChestSize},{"wooden-chest",1}},
		result = "copper-box",
		result_count = 1,
		order = "b1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "copper-unpack",
		icon = "__packager__/graphics/icons/copper-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"copper-box",1}},
		results= {
      {type="item", name="copper-plate", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "b2",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "steel-pack",
		icon = "__packager__/graphics/icons/steel-pack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"steel-plate",woodChestSize},{"wooden-chest",1}},
		result = "steel-box",
		result_count = 1,
		order = "c1",
		enabled = "true"
	},
	{
		type = "recipe",
		name = "steel-unpack",
		icon = "__packager__/graphics/icons/steel-unpack.png",
		category = "packager-pack",
		subgroup = "packaging_plates",
		energy_required = 0.5,
		ingredients = {{"steel-box",1}},
		results= {
      {type="item", name="steel-plate", amount=woodChestSize},
      {type="item", name="wooden-chest", amount=1}
    },
		order = "c2",
		enabled = "true"
	},
})