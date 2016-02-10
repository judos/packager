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
	
	scheduleAdd(entity, game.tick + 1)
end


function tickConfigurablePackager(entity)
	entity.energy = entity.energy-903

	return 1,nil
end


function preMineConfigurablePackager(event)
	-- index 3 is defines.inventory.resultInventory (the current lua api does not contain the up-to-date indexes)
	-- TODO
	-- if playerIndex is set in events table, every item must be moved in this method from the feeder chests to the packager, otherwise items get lost
	
	
	
end