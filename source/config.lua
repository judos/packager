woodStorageGain = 1.2;
woodChestSize = 10;

function woodChestStack(itemName)
	local stack = data.raw["item"][itemName].stack_size;
	local newStack = stack * woodStorageGain;
	local chestStack = round(newStack / woodChestSize);
	return chestStack;
end