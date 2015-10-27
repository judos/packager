data:extend(
{
	
	{
		type = "item",
		name = "belt-packager",
		icon = "__packager__/graphics/icons/packager.png",
		place_result = "belt-packager",
		flags = {"goes-to-quickbar"},
    subgroup = "packaging_machines",
		category = "crafting",
		order = "0",
		stack_size = 50,
	},
	
	{
		type = "item",
		name = "packager",
		icon = "__packager__/graphics/icons/packager.png",
		place_result = "packager",
		flags = {"goes-to-quickbar"},
    subgroup = "packaging_machines",
		category = "crafting",
		order = "1",
		stack_size = 50,
	},
	{
		type = "item",
		name = "container",
		icon = "__packager__/graphics/icons/container.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_machines",
		category = "crafting",
		order = "2",
		stack_size = containerStack("iron-ore"),
	},
})

setSubgroup("packaging_raw")
item_addBox("iron-ore")
item_addBox("copper-ore")
item_addBox("stone")
item_addBox("coal")
item_addBox("plastic","plastic-bar")

item_addBox("iron-ore",nil,true) --container version
item_addBox("copper-ore",nil,true) --container version

setSubgroup("packaging_plates")
item_addBox("iron","iron-plate")
item_addBox("copper","copper-plate")
item_addBox("steel","steel-plate")

setSubgroup("packaging_others")
--item_addBox("cable","copper-cable") -- Deactivated due to problems with calculation of raw ressources
item_addBox("mixed-plates","iron-plate")
