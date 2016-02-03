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
configurablePackager.collision_box = {{-0.9, -0.9}, {0.9, 0.9}}
configurablePackager.selection_box = {{-0.9, -0.4}, {0.9, 0.4}}
configurablePackager.animation = {
	filename = "__packager__/graphics/entity/belt-packager/belt-packager.png",
	priority = "high",
	width = 75,
	height = 66,
	frame_count = 32,
	line_length = 8,
	shift = {0.25, -0.08}
}
data:extend({	configurablePackager })

-- Item feeder
local itemFeeder = deepcopy(data.raw["container"]["iron-chest"])
itemFeeder.name = "configurable-packager-item-feeder"
itemFeeder.flags = {"placeable-off-grid","not-repairable"}
itemFeeder.collision_box = nil
itemFeeder.inventory_size = 1
itemFeeder.order = "z"
itemFeeder.selection_box = {{-0.45, -0.25}, {0.45, 0.25}}
itemFeeder.picture = {
		filename = "__packager__/graphics/entity/test.png",
		priority = "low", --"extra-high",
		width = 0, --29,
		height = 0, --16,
		shift = {0, 0}
}
data:extend({	itemFeeder })