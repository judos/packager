woodStorageGain = 1.2
woodChestSize = 10

containerGain = 1.5
containerSize = 100

function woodChestStack(itemName)
	return chestStack(itemName,woodStorageGain,woodChestSize)
end
function containerStack(itemName)
	return chestStack(itemName,containerGain,containerSize)
end

function chestStack(itemName,storageGain,chestSize)
	local stack = data.raw["item"][itemName].stack_size
	local newStack = stack * storageGain
	local chestStack = round(newStack / chestSize)
	return chestStack
end