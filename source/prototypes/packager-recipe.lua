
-- Item
data:extend({
	{
		type = "item",
		name = "packager-recipe-empty",
		order = "packager-recipe-empty",
		icon = "__packager__/graphics/icons/recipe-empty.png",
		flags = {"goes-to-main-inventory"},
		stack_size = 10,
		subgroup = "packaging_machines"
	},
	{
		type = "item",
		name = "packager-recipe",
		order = "packager-recipe",
		icon = "__packager__/graphics/icons/recipe.png",
		flags = {"goes-to-main-inventory"},
		stack_size = 10,
		subgroup = "packaging_machines"
	}
})

-- Recipe
data:extend({
	{
		type = "recipe",
		name = "packager-recipe-empty",
		enabled = true, --TODO: require tech
		ingredients = {
			{"electronic-circuit", 5}
		},
		result = "packager-recipe-empty"
	}
})