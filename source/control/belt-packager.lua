local packagerDelayOff = 60 -- when the packager doesn't run the next update is triggered X ticks later
local packagerRegularUpdate = 5 -- when the packager is running


function packagerInit()
	if not global.packagerInputBelts then
		info("initialized global.packagerInputBelts")
		global.packagerInputBelts = {}
	end
end


function builtBeltPackager(entity)
	info("packager built and added for update tick: "..game.tick)
	updateBeltSetup(entity)
	scheduleAdd(entity, game.tick + 10)
end

function updateBeltSetup(entity)
	local beltEntityIds = findInputBeltIds(entity)
	global.packagerInputBelts[idOfEntity(entity)] = beltEntityIds
end


function removePackager(idOfEntity)
	global.packagerInputBelts[idOfEntity] = nil
end


-- parameters: entity (the packager)
-- return values: tickDelayForNextUpdate, errorMessage
function runPackagerInstructions(idOfEntity, entity)
	-- precondition: have a recipe with ingredients
	local recipe = entity.recipe
	if recipe == nil then -- recipe on packager must be selected
		return packagerDelayOff,nil --"no recipe selected"
	end
	if #recipe.ingredients ~= 2 then --it must be a recipe where something is packed
		return packagerDelayOff,nil --"not a pack recipe"
	end
	local inputItemName = recipe.ingredients[1].name
	local stack = {name = inputItemName, count = 1}
	
	-- packager must have space in inventory
	local packagerInventory = entity.get_inventory(defines.inventory.assembling_machine_input)
	-- if not packagerInventory.can_insert(stack) then -- doesn't work in factorio 0.12.12 - 0.12.14
	-- -> see this report: http://www.factorioforums.com/forum/viewtopic.php?f=7&t=17347&p=114954#p114954
	--	return packagerDelayOff,"no storage space"
	-- end
	
	-- no input belts
	if #global.packagerInputBelts[idOfEntity] == 0 then
		updateBeltSetup(entity)
		return packagerDelayOff,nil --"no input belts"
	end
	local actions = 0
	
	-- for all belts found around the packager
	for _,beltId in pairs(global.packagerInputBelts[idOfEntity]) do
		local belt = entityOfId(beltId)
		if belt==nil or belt.valid==false or belt.type~="transport-belt" then -- belt was removed
			updateBeltSetup(entity)
			return packagerDelayOff,nil --"belt was removed"
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
						return packagerDelayOff,nil --"no more storage space"
					end
				else
					return packagerDelayOff,nil --"storage space might overflow"
				end
			end
		end
	end
	if actions > 0 then
		return packagerRegularUpdate,nil
	else
		return packagerDelayOff,nil --"no actions taken"
	end
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

