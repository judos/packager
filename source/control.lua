require "defines"
require "basic-lua-extensions"

local delayOff = 60 -- when the packager doesn't run the next update is triggered X ticks later
local regularUpdate = 5 -- when the packager is running

local packagerName = "belt-packager"

local north = defines.direction.north
local east = defines.direction.east
local south = defines.direction.south
local west = defines.direction.west
local transport_line = defines.transport_line

-- global data stored and used:
-- global.packagerInputBelts[idEntity] = { idEntity(belt), ... }
-- global.schedule[tick] = { idEntity(beltPackager), ... }


---------------------------------------------------
-- Loading
---------------------------------------------------
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
	debug("onload"..serpent.block(global))
	if not global.packagerVersion then
		global.packagerVersion = "0.1.4"
		global.packagerInputBelts = {}
		global.schedule = {}
		PlayerPrint("Migration: All old belt-packagers have to be replaced due to code changes.")
	end
	if not global.packagerInputBelts then
		debug("initialized global.packagerInputBelts")
		global.packagerInputBelts = {}
	end
	if not global.schedule then
		debug("initialized global.schedule")
		global.schedule = {}
	end
end

---------------------------------------------------
-- Tick
---------------------------------------------------
script.on_event(defines.events.on_tick, function(event)
  -- if no updates are scheduled return
	
	if type(global.schedule[game.tick]) ~= "table" then
		return
	end
	for _,idEntity in pairs(global.schedule[game.tick]) do
		entity = entityOfId(idEntity)
		if entity and entity.valid then
			local nextUpdateInXTicks, errorMessage = runPackagerInstructions(idEntity, entity)
			if errorMessage ~= nil then
				debug("Problem with packager at " .. entity.position.x .. ", " ..entity.position.y .. ": "..errorMessage)
			end
			if nextUpdateInXTicks ~= nil then
				scheduleAdd(entity, game.tick + nextUpdateInXTicks)
			else
				-- if no more update is scheduled, remove it from memory
				removePackager(idEntity)
			end
		else
			debug("packager is not valid!")
			-- if entity was removed, remove it from memory
			removePackager(idEntity)
		end
	end
	global.schedule[game.tick] = nil
end)

---------------------------------------------------
-- Building packagers
---------------------------------------------------
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

function packagerBuilt(entity)
	debug("packager built and added for update tick: "..game.tick)
	updateBeltSetup(entity)
	scheduleAdd(entity, game.tick + 10)
end

function updateBeltSetup(entity)
	local beltEntityIds = findInputBeltIds(entity)
	global.packagerInputBelts[idOfEntity(entity)] = beltEntityIds
end

---------------------------------------------------
-- Removal of packagers
---------------------------------------------------
-- triggered in tick() because no coordinate is passed for the following functions)
--[[
script.on_event(defines.events.on_player_mined_item, function(event)
	if event.item_stack.name == packagerName then
	end
end)
script.on_event(defines.events.on_robot_mined, function(event)
	if event.item_stack.name == packagerName then
	end
end)
script.on_event(defines.events.on_entity_died, function(event)
	if event.item_stack.name == packagerName then
	end
end)
]]--
function removePackager(idOfEntity)
	global.packagerInputBelts[idOfEntity] = nil
end


---------------------------------------------------
-- Utility methods
---------------------------------------------------
-- Adds new entry to the scheduling table
function scheduleAdd(entity, nextTick)
	if global.schedule[nextTick] == nil then
		global.schedule[nextTick] = {}
	end
	table.insert(global.schedule[nextTick],idOfEntity(entity))
end

function idOfEntity(entity)
	return string.format("%g_%g", entity.position.x, entity.position.y)
end
function entityOfId(id)
	local position = split(id,"_")
	local point = {tonumber(position[1]),tonumber(position[2])}
	local entities = game.surfaces.nauvis.find_entities{point,point}
	if entities == nil then return nil end
	if #entities == 0 then return nil end
	return entities[1]
end

function findInputBeltIds(entity) -- Find the input for the packager.
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
		east, east,  -- belt in the west,  facing right
		south,south, -- belt in the north, facing down
		west, west,  -- belt in the east,  facing left
		north,north, -- belt in the south, facing up
	}
	local resultBeltIds = {}
	for index,pointOfEntity in pairs(beltscan_coords) do
		--search for belt on one field
		local belt = entity.surface.find_entities_filtered{area = {pointOfEntity,pointOfEntity}, type = "transport-belt"}
		if belt[1] and belt[1].direction == valid_belt_directions[index] then
			table.insert(resultBeltIds,idOfEntity(belt[1]))
		end
	end
	return resultBeltIds
end

-- parameters: entity (the packager)
-- return values: tickDelayForNextUpdate, errorMessage
function runPackagerInstructions(idOfEntity, entity)
	-- precondition: have a recipe with ingredients
	local recipe = entity.recipe
	if recipe == nil then -- recipe on packager must be selected
		return delayOff,"no recipe selected"
	end
	if #recipe.ingredients ~= 2 then --it must be a recipe where something is packed
		return delayOff,"not a pack recipe"
	end
	local inputItemName = recipe.ingredients[1].name
	local stack = {name = inputItemName, count = 1}
	
	-- packager must have space in inventory
	local packagerInventory = entity.get_inventory(defines.inventory.assembling_machine_input)
	-- if not packagerInventory.can_insert(stack) then -- doesn't work in factorio 0.12.12 - 0.12.14
	-- -> see this report: http://www.factorioforums.com/forum/viewtopic.php?f=7&t=17347&p=114954#p114954
	--	return delayOff,"no storage space"
	-- end
	
	-- no input belts
	if #global.packagerInputBelts[idOfEntity] == 0 then
		updateBeltSetup(entity)
		return delayOff,"no input belts"
	end
	local actions = 0
	
	-- for all belts found around the packager
	for _,beltId in pairs(global.packagerInputBelts[idOfEntity]) do
		local belt = entityOfId(beltId)
		if (not belt) or (not belt.valid) then -- belt was removed
			updateBeltSetup(entity)
			return delayOff,"belt was removed"
		end
		
		-- for both lines of the belt
		local beltLines = {defines.transport_line.left_line,defines.transport_line.right_line}
		for _,beltLine in pairs(beltLines) do
			local transportLine = belt.get_transport_line(beltLine)
			local content = transportLine.get_contents()
			
			-- if the belt contains the required items
			if content[inputItemName]~=nil and content[inputItemName]>0 then
				local itemsPresent = packagerInventory.get_contents()[inputItemName]
				if itemsPresent == nil or itemsPresent < game.item_prototypes[inputItemName].stack_size then
					actions = actions + 1
					local insertedItems = packagerInventory.insert(stack)
					transportLine.remove_item{name=inputItemName,count=insertedItems}
					if insertedItems == 0 then
						return delayOff,"no more storage space"
					end
				else
					return delayOff,"storage space might overflow"
				end
			end
		end
	end
	if actions > 0 then
		return regularUpdate,nil
	else
		return delayOff,"no actions taken"
	end
end