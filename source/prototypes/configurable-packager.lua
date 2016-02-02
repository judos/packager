data:extend(
{
	{
		type = "item",
		name = "configurable-packager",
		icon = "__packager__/graphics/icons/packager.png",
		place_result = "configurable-packager",
		flags = {"goes-to-quickbar"},
    subgroup = "packaging_machines",
		category = "crafting",
		order = "0",
		stack_size = 50,
	},
	{
    type = "recipe",
    name = "configurable-packager",
		category = "crafting",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"iron-plate",10},{"copper-cable",10},{"fast-inserter",4}},
    results = {
			{ type="item", name="configurable-packager", amount=1 }
		},
		order = "0",
		enabled = "true",
  },
	{
		type = "recipe-category",
		name = "packager-configurable"
	},
	{
    type = "recipe",
    name = "gold-packaging",
		category = "packager-configurable",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"wooden-chest",2000}},
    results = {
			{ type="item", name="configurable-box", amount=1 }
		},
		order = "0",
		enabled = "true",
  },
})

-- Entity
local configurablePackager = deepcopy(data.raw["furnace"]["electric-furnace"])
configurablePackager.name = "configurable-packager"
configurablePackager.minable.result = "configurable-packager"
configurablePackager.crafting_categories = {"packager-configurable"}
data:extend({	configurablePackager })