data:extend(
{
	--[[
	{
    type = "recipe",
    name = "belt-packager",
		category = "crafting",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"iron-plate",10},{"copper-cable",10},{"iron-gear-wheel",5}},
    results = {
			{type="item", name="belt-packager", amount=1}
		},
		order = "0",
		enabled = "true",
  },
	]]--
	{
    type = "recipe",
    name = "packager",
		category = "crafting",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"iron-plate",10},{"copper-cable",10},{"iron-gear-wheel",5}},
    results = {
			{type="item", name="packager", amount=1}
		},
		order = "1",
		enabled = "true",
  },
	{
    type = "recipe",
    name = "container1",
		category = "crafting",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"wooden-chest",10},{"steel-plate",10}},
    results = {
			{type="item", name="container", amount=1}
		},
		order = "2",
		enabled = "true",
  },
	{
    type = "recipe",
    name = "container2",
		category = "crafting",
		subgroup = "packaging_machines",
    energy_required = 1,
    ingredients = {{"iron-chest",8},{"steel-plate",10}},
    results = {
			{type="item", name="container", amount=1}
		},
		order = "3",
		enabled = "true",
  },
})