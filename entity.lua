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
    selection_box = {{-0.8, -1}, {0.8, 1}},
		fast_replaceable_group = "packager",
		crafting_categories = {"packager-pack"},
    result_inventory_size = 1,
    energy_usage = "40kW",
    crafting_speed = 0.5,
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
    animation =
    {
      filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
      priority = "extra-high",
      width = 81,
      height = 64,
      frame_count = 1,
      shift = {0.5, 0.05 }
    },
    working_visualisations =
    {
      {
        north_position = {0.0, 0.0},
        east_position = {0.0, 0.0},
        south_position = {0.0, 0.0},
        west_position = {0.0, 0.0},
        animation =
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
          priority = "extra-high",
          width = 23,
          height = 27,
          frame_count = 12,
          shift = { 0.078125, 0.5234375}
        },
        light = {intensity = 1, size = 1}
      }
    },
  },
})