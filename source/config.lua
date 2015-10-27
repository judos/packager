woodStorageGain = 1.2
woodChestSize = 10

containerGain = 1.5
containerSize = 100 -- usually if itemStackSizes are big enough for it to be filled in a packager

-- make sure the container is not too big, otherwise it's not possible to fill it in a packager
local checkItems = {"iron-ore","copper-ore","iron-plate","copper-plate","steel-plate"}
function itemStack(itemName)
	return data.raw["item"][itemName].stack_size
end
for i,itemName in ipairs(checkItems) do
	containerSize = math.min(containerSize, itemStack(itemName))
end

function woodChestStack(itemName)
	return chestStack(itemName,woodStorageGain,woodChestSize)
end
function containerStack(itemName)
	return chestStack(itemName,containerGain,containerSize)
end



function chestStack(itemName,storageGain,chestSize)
	local stack = data.raw["item"][itemName].stack_size
	local newStack = stack * storageGain
	local chestStack = math.ceil(newStack / chestSize)
	return chestStack
end