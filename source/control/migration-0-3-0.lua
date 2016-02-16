function migration_0_3_0()
	-- remove old data
	-- global.packagerInputBelts[idEntity] = { idEntity(belt), ... }
	global.packagerInputBelts=nil

	-- migrate data to new variables
	if not global.entityData then global.entityData = {} end
	local newSchedule = {}
	for tick,array in pairs(global.schedule) do
		if not newSchedule[tick] then newSchedule[tick] = {} end
		for _,idEntity in pairs(array) do
			newSchedule[tick][idEntity] = entityOfId(idEntity)
			global.entityData[idEntity] = {name = entityOfId(idEntity).name}
		end
	end
	global.schedule = newSchedule
	global.packagerVersion = "0.3.0"
	info("migrated to packager 0.3.0")
end