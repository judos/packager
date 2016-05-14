function builtConfigurablePackager(entity)
	-- place 4 item input/output feeders
	local feederChests = {}
	local positionsToPlace = {{-0.45,-0.65},{-0.45,0.65},{0.45,0.65},{0.45,-0.65}}
	for _,coords in pairs(positionsToPlace) do
		local chest = entity.surface.create_entity({
			name="configurable-packager-item-feeder",
			force=entity.force,
			position={entity.position.x+coords[1],entity.position.y+coords[2]}
		})
		chest.minable = false
		chest.destructible = false
		table.insert(feederChests,chest)
	end
	
	local entity2 = entity.surface.create_entity({
		name="configurable-packager",
		force= entity.force,
		position=entity.position
	})
	entity.destroy()
	
	scheduleAdd(entity2, game.tick + 60)
	return {["feeders"] = feederChests},entity2
end


function tickConfigurablePackager(entity)

	return 60,nil
end


function preMineConfigurablePackager(event)
	-- entity Lua/Entity, name = 9, player_index = 1, tick = 96029 } 
	local entity = event.entity
	-- index 3 is defines.inventory.resultInventory (the current lua api does not contain the up-to-date indexes)
	local entityInv = entity.get_inventory(3)
	local data = global.entityData[idOfEntity(entity)]
	
	-- Move items from feeder into Output slots (player or bots pick them up)
	for _,feeder in pairs(data["feeders"]) do
		local feederInv = feeder.get_inventory(defines.inventory.chest)
		if not feederInv.is_empty() then
			if entityInv.can_insert(feederInv[1]) then
				local insertedAmount = entityInv.insert(feederInv[1])
				feederInv.remove({name=feederInv[1].name,count=insertedAmount})
			else
				break
			end
		end
	end
	
	-- since the player mines it all items have to be moved
	if event.player_index then
		-- if playerIndex is set in events table, every item must be moved in this method from the feeder chests to the packager, otherwise items get lost
		local p = game.players[event.player_index]
		for _,feeder in pairs(data["feeders"]) do
			local feederInv = feeder.get_inventory(defines.inventory.chest)
			if not feederInv.is_empty() then
				local insertedAmount= p.insert(feederInv[1])
				if insertedAmount>0 then
					feederInv.remove({name=feederInv[1].name,count=insertedAmount})
				end
				if not feederInv.is_empty() then
					entity.surface.spill_item_stack(entity.position,feederInv[1])
					feederInv.clear()
				end
			end
		end
	end
end

function removeConfigurablePackager(idEntity)
	local data = global.entityData[idEntity]
	for _,feeder in pairs(data["feeders"]) do
		feeder.destroy()
	end
end