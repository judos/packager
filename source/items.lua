
data:extend(
{
	{
		type = "item",
		name = "packager",
		icon = "__packager__/graphics/icons/packager.png",
		place_result = "packager",
		flags = {"goes-to-quickbar"},
    subgroup = "packaging_machines",
		category = "crafting",
		order = "0",
		stack_size = 50,
	},
	{
		type = "item",
		name = "iron-ore-box",
		icon = "__packager__/graphics/icons/iron-ore-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_raw",
		category = "crafting",
		order = "a[iron-ore]",
		stack_size = woodChestStack("iron-ore")
	},
	{
		type = "item",
		name = "copper-ore-box",
		icon = "__packager__/graphics/icons/copper-ore-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_raw",
		category = "crafting",
		order = "b[copper-ore]",
		stack_size = woodChestStack("copper-ore")
	},
	{
		type = "item",
		name = "stone-box",
		icon = "__packager__/graphics/icons/stone-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_raw",
		category = "crafting",
		order = "c[stone]",
		stack_size = woodChestStack("stone")
	},
	{
		type = "item",
		name = "coal-box",
		icon = "__packager__/graphics/icons/coal-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_raw",
		category = "crafting",
		order = "d[coal]",
		stack_size = woodChestStack("coal")
	},
	{
		type = "item",
		name = "plastic-box",
		icon = "__packager__/graphics/icons/plastic-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_raw",
		category = "crafting",
		order = "e[plastic]",
		stack_size = woodChestStack("plastic-bar")
	},
	
	{
		type = "item",
		name = "iron-box",
		icon = "__packager__/graphics/icons/iron-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_plates",
		category = "crafting",
		order = "a[iron-box]",
		stack_size = woodChestStack("iron-plate")
	},
	{
		type = "item",
		name = "copper-box",
		icon = "__packager__/graphics/icons/copper-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_plates",
		category = "crafting",
		order = "b[copper-box]",
		stack_size = woodChestStack("copper-plate")
	},
	{
		type = "item",
		name = "steel-box",
		icon = "__packager__/graphics/icons/steel-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_plates",
		category = "crafting",
		order = "c[steel-box]",
		stack_size = woodChestStack("steel-plate")
	},
	--[[
	{
		type = "item",
		name = "cable-box",
		icon = "__packager__/graphics/icons/cable-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_others",
		category = "crafting",
		order = "a[cable-box]",
		stack_size = woodChestStack("copper-cable")
	},
	]]--
	{
		type = "item",
		name = "mixed-plates-box",
		icon = "__packager__/graphics/icons/mixed-plates-box.png",
		flags = {"goes-to-main-inventory"},
    subgroup = "packaging_others",
		category = "crafting",
		order = "b[mixed-box]",
		stack_size = woodChestStack("iron-plate")
	},
})