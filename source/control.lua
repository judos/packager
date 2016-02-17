require "defines"
require "basic-lua-extensions"
require "control.configurable-packager"
require "control.belt-packager"
require "control.migration-0-3-0"
require "control.remote-calls"
require "control.packager-library"

-- global data stored and used:
-- global.schedule[tick][idEntity] = $ENTITY$
-- global.entityData[idEntity] = { name="NAME" }
--																 belts={ idEntity(belt), ...} -- beltPackager
-- global.recipes[ nr{1,1000000} ] = {item=count, item2=count2, ...}
--								 the asosciated health float value is: nr/1000000
--								 as reference I used: http://stackoverflow.com/questions/3310276/decimal-precision-of-floats
intToFloatDivider = 100 --TODO: for testing
-- intToFloatDivider = 1000000


script.on_event(defines.events.on_gui_click, function(event)
	print(event)
end)

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
	if not global.packagerVersion then global.packagerVersion = "0.3.0" end
	if global.packagerVersion < "0.3.0" then	migration_0_3_0() end
	
	if not global.schedule then
		info "initialized global.schedule"
		global.schedule = {}
	end
	if not global.entityData then
		info "initialized entity table"
		global.entityData = {}
	end
	if not global.recipes then
		info "initialized recipe table"
		global.recipes = {}
	end
	
	info("onload"..serpent.block(global))
end

---------------------------------------------------
-- Tick
---------------------------------------------------
script.on_event(defines.events.on_tick, function(event)
  -- if no updates are scheduled return
	if type(global.schedule[game.tick]) ~= "table" then
		return
	end
	
	local nextUpdateInXTicks, errorMessage
	for idEntity,entity in pairs(global.schedule[game.tick]) do
		local name = global.entityData[idEntity].name
		if not name then name = "UNKNOWN" end
		--info("updating "..name.." with id: "..idEntity)
		if entity and entity.valid then
			if name == "belt-packager" then
				nextUpdateInXTicks, errorMessage = runPackagerInstructions(idEntity, entity)
			elseif name == "configurable-packager" then
				nextUpdateInXTicks, errorMessage = tickConfigurablePackager(entity)
			elseif name == "packager-library" then
				nextUpdateInXTicks, errorMessage = tickPackagerLibrary(entity)
			end
			
			if errorMessage ~= nil then
				warn("Problem with "..name.." at " .. entity.position.x .. ", " ..entity.position.y .. ": "..errorMessage)
			end
		else
			warn(name.." is not valid anymore")
			if name == "configurable-packager" then
				removeConfigurablePackager(idEntity)
			end
			nextUpdateInXTicks = nil
		end
		
		--info("scheduled update in ticks: "..tostring(nextUpdateInXTicks))
		if nextUpdateInXTicks ~= nil then
			scheduleAdd(entity, game.tick + nextUpdateInXTicks)
		else
			-- if no more update is scheduled, remove it from memory
			global.entityData[idEntity]=nil
		end
	end
	global.schedule[game.tick] = nil
end)

---------------------------------------------------
-- Building Entities
---------------------------------------------------
script.on_event(defines.events.on_built_entity, function(event)
	entityBuilt(event)
end)
script.on_event(defines.events.on_robot_built_entity, function(event)
	entityBuilt(event)
end)

function entityBuilt(event)
	local entity = event.created_entity
	local knownEntities = table.set({"belt-packager", "configurable-packager","packager-library"})
	info(knownEntities)
	if not knownEntities[entity.name] then
		return
	end
	
	global.entityData[idOfEntity(entity)] = { ["name"] = entity.name }
	local addedData = {}
	if entity.name == "belt-packager" then
		builtBeltPackager(entity)
	elseif entity.name == "configurable-packager" then
		addedData,entity = builtConfigurablePackager(entity)
	elseif entity.name == "packager-library" then
		builtPackagerLibrary(entity)
	end
	table.addTable(global.entityData[idOfEntity(entity)],addedData)
end

---------------------------------------------------
-- Removal of Entities
---------------------------------------------------
-- triggered in tick() because no coordinate is passed for the following events:
-- on_player_mined_item, on_robot_mined, on_entity_died

script.on_event(defines.events.on_robot_pre_mined, function(event)
	preMined(event)
end)

script.on_event(defines.events.on_preplayer_mined_item, function(event)
	preMined(event)
end)

function preMined(event) --event table doesn't contain player_index when a robot mines the entity
	local entity = event.entity
	if entity.name == "configurable-packager" then
		preMineConfigurablePackager(event)
	end
end

---------------------------------------------------
-- Utility methods
---------------------------------------------------
-- Adds new entry to the scheduling table
function scheduleAdd(entity, nextTick)
	if global.schedule[nextTick] == nil then
		global.schedule[nextTick] = {}
	end
	global.schedule[nextTick][idOfEntity(entity)] = entity
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
	if #entities > 1 then warn("Found multiple entities when searching for entity with id: "..id) end
	return entities[1]
end
