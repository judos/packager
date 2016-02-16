
-- Item
local packagerLibrary = deepcopy(data.raw["item"]["wooden-chest"])
packagerLibrary.name = "packager-library"
packagerLibrary.order = packagerLibrary["order"].."z"
packagerLibrary.subgroup = "packaging_machines"
packagerLibrary["place_result"] = "packager-library"
--packagerLibrary.icon = "__neatLogistics__/graphics/icons/belt-sorter.png"
data:extend({	packagerLibrary })

-- Recipe
data:extend({
	{
		type = "recipe",
		name = "packager-library",
		enabled = true, --TODO: require tech
		ingredients = {
			{"smart-chest", 1},
			{"steel-plate", 10},
			{"electronic-circuit", 5}
		},
		result = "packager-library"
	}
})

-- Entity
local packagerLibrary = deepcopy(data.raw["container"]["wooden-chest"])
packagerLibrary.name = "packager-library"
packagerLibrary.minable.result = "packager-library"
packagerLibrary.inventory_size = 20
--packagerLibrary.icon = "__neatLogistics__/graphics/icons/belt-sorter.png"
--packagerLibrary.picture.filename="__neatLogistics__/graphics/entity/belt-sorter.png"
data:extend({	packagerLibrary })

-- Technology
--addTechnologyUnlocksRecipe("circuit-network","belt-sorter")
