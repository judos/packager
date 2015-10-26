-- extend usual assembling machines to support packager recipes
table.insert(data.raw["assembling-machine"]["assembling-machine-1"]["crafting_categories"],"packager-pack")
table.insert(data.raw["assembling-machine"]["assembling-machine-2"]["crafting_categories"],"packager-pack")
table.insert(data.raw["assembling-machine"]["assembling-machine-3"]["crafting_categories"],"packager-pack")

-- enable crafting category packager-pack also for player:
table.insert(data.raw["player"]["player"].crafting_categories,"packager-pack")

data:extend({
	{
    type = "assembling-machine",
    name = "packager",
		order="p",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "packager"},
    max_health = 200,
    resistances = {
      {type = "fire", percent = 75},
    },
		module_specification = {
      module_slots = 0
    },
		collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
		fast_replaceable_group = "packager",
		crafting_categories = {"packager-pack","packager-advanced"},
    result_inventory_size = 1,
    energy_usage = "40kW",
    crafting_speed = 1,
    ingredient_count = 2,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.002
    },
		
		-- Sound
    vehicle_impact_sound =  {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
      sound = {
        {filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.8},
        {filename = "__base__/sound/assembling-machine-t2-2.ogg", volume = 0.8},
      },
      idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
      apparent_volume = 1.0,
    },
		
		-- Visuals
		icon = "__packager__/graphics/icons/packager.png",
    corpse = "medium-remnants",
		animation = {
      filename = "__packager__/graphics/entity/packager/packager.png",
      priority = "high",
      width = 75,
      height = 66,
      frame_count = 32,
      line_length = 8,
      shift = {0.25, -0.04}
    },
  },
})