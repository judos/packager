function builtConfigurablePackager(entity)
	
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

end