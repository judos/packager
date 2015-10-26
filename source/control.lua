require "defines"
require "config"
require "basic-lua-extensions"

local packagerName = "belt-packager"
local next = next
local north = defines.direction.north
local east = defines.direction.east
local south = defines.direction.south
local west = defines.direction.west
local transport_line = defines.transport_line


script.on_init(function()
	onLoad()
end)
script.on_load(function()
	onLoad()
end)

function onLoad()
	if not global then
		global = {}
		game.forces.player.reset_technologies()
		game.forces.player.reset_recipes()
	end
	if not global.packagers then global.packagers = {} end
	if not global.schedule then global.schedule = {} end
end

script.on_event(defines.events.on_tick, function(event)
  -- if no updates are scheduled return
	if type(global.schedule[game.tick]) ~= "table" then
		return
	end
	for index,entity in ipairs(global.schedule[game.tick]) do
		if entity.valid then 
			local nextUpdateInXTicks, errorMessage = runPackagerInstructions(entity)
			if errorMessage ~= nil then
				debug("Problem with packager at " .. entity.position.x .. ", " ..entity.position.y .. ": "..errorMessage)
			end
			if nextUpdateInXTicks ~= nil then
				scheduleAdd(entity, game.tick + nextUpdateInXTicks)
			end
		end
	end
	global.schedule[game.tick] = nil
end)

-- Building packagers
script.on_event(defines.events.on_built_entity, function(event)
	if event.created_entity.name == packagerName then
		packagerBuilt(event.created_entity)
	end
end)
script.on_event(defines.events.on_robot_built_entity, function(event)
	if event.created_entity.name == packagerName then
		packagerBuilt(event.created_entity)
	end
end)

-- Removal of packagers
script.on_event(defines.events.on_player_mined_item, function(event)
	if event.item_stack.name == packagerName then
		packagerRemoved()
	end
end)
script.on_event(defines.events.on_robot_mined, function(event)
	if event.item_stack.name == packagerName then
		packagerRemoved()
	end
end)
script.on_event(defines.events.on_entity_died, function(event)
	if event.item_stack.name == packagerName then
		packagerRemoved()
	end
end)

-- Utility methods
-- Adds new entry to the scheduling table
function scheduleAdd(entity, nextTick)
	if global.schedule[nextTick] == nil then
		global.schedule[nextTick] = {}
	end
	global.schedule[nextTick][idOfEntity(entity)] = entity
end

function packagerBuilt(entity)
	local pos = {x = entity.position.x, y = entity.position.y}
	local beltEntities = findInputsOutputs(entity)
	global.packagers[idOfEntity(entity)] = beltEntities
	scheduleAdd(entity, game.tick + 10)
end

function idOfEntity(entity)
	return string.format("%d_%d", entity.position.x, entity.position.y)
end

function packagerRemoved()
	for id,entity in ipairs(global.packagers) do
		if not entity.valid then
			global.packagers[id]=nil
		end
	end
end

function findInputsOutputs(entity) -- Find the input for the packager.
	local pos = {x = entity.position.x, y = entity.position.y}
	
	local beltscan_coords = { -- Points to search for transport belts.
		{pos.x - 1.5, pos.y - 0.5}, -- west upper
		{pos.x - 1.5, pos.y + 0.5}, -- west lower
		{pos.x - 0.5, pos.y - 1.5}, -- north left
		{pos.x + 0.5, pos.y - 1.5}, -- north right
		{pos.x + 1.5, pos.y - 0.5}, -- east upper
		{pos.x + 1.5, pos.y + 0.5}, -- east lower
		{pos.x + 0.5, pos.y + 1.5}, -- south right
		{pos.x - 0.5, pos.y + 1.5}, -- south left
	}
	local valid_belt_directions = {
		2,2, -- belt in the west, facing right
		4,4, -- belt in the north, facing down
		6,6, -- belt in the east, facing left
		0,0, -- belt in the south, facing up
	}
	local resultBeltEntities = {}
	for index,pointOfEntity in ipairs(beltscan_coords) do
		--search for belt on one field
		local belt = entity.surface.find_entities_filtered{area = {pointOfEntity,pointOfEntity}, type = "transport-belt"}
		if belt[1] and belt[1].direction == valid_belt_directions[index] then
			table.insert(resultBeltEntities,belt[1])
		end
	end
	return resultBeltEntities
end

-- parameters: entity (the packager)
-- return values: tickDelayForNextUpdate, errorMessage
function runPackagerInstructions(entity)
	-- precondition: have a recipe with ingredients
	if entity.recipe == nil then
		return
	end
	
	--[[
	
	local instructions = chest.instructions
	local action_count = 0
	
	for i,v in pairs(instructions) do
		if v[2].valid == false then
			return true, false
		end
		
		if v[1] == "output" and not chest.inventory.is_empty() then
			local chest_contents = next(chest.inventory.get_contents())
			local stack = {name = chest_contents, count = 1}
			
			if v[2].can_insert_at_back() then
				v[2].insert_at_back(stack)
				chest.inventory.remove(stack)
				chest.battery.energy = chest.battery.energy - energy_per_action
				action_count = action_count + 1
			end
		elseif v[1] == "input" then
			local line_contents = next(v[2].get_contents())
			
			if line_contents ~= nil then
				local stack = {name = line_contents, count = 1}
				
				if chest.inventory.can_insert(stack) then
					chest.inventory.insert(stack)
					v[2].remove_item(stack)
					chest.battery.energy = chest.battery.energy - energy_per_action
					action_count = action_count + 1
				end
			end
		end
	end
	
	if action_count == 0 then
		return true, true
	else
		return false, true
	end
	
	]]--
	return nil,"updateTick not implemented"
end