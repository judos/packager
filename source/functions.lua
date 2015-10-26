
local orderIndex
local currentSubGroup
-- parameters: subgroup name which is used for further items
-- also sets back the orderIndexs
function setSubgroup(subGroupName)
	currentSubGroup = subGroupName
	orderIndex = 1
end

-- adds both recipes (pack and unpack for one wooden box)
function recipe_addBox(recipeName,ingredientName,containerTier)
	if ingredientName == nil then
		ingredientName = recipeName
	end
	local chestName, category, itemAppendix, stackSize
	if not containerTier then
		chestName = "wooden-chest"
		stackSize = woodChestSize
		category = "packager-pack"
		itemAppendix = "box"
	else
		chestName = "container"
		stackSize = containerSize
		category = "packager-advanced"
		itemAppendix = "container"
	end
	
	data:extend({
		{
			type = "recipe",
			name = recipeName.."-"..itemAppendix.."-pack",
			icon = "__packager__/graphics/icons/"..recipeName.."-pack.png",
			category = category,
			subgroup = currentSubGroup,
			energy_required = 0.5,
			ingredients = {{ingredientName,stackSize},{chestName,1}},
			result = recipeName.."-"..itemAppendix,
			result_count = 1,
			order = "a"..string.format("%02d", orderIndex),
			enabled = "true"
		},
		{
			type = "recipe",
			name = recipeName.."-"..itemAppendix.."-unpack",
			icon = "__packager__/graphics/icons/"..recipeName.."-unpack.png",
			category = category,
			subgroup = currentSubGroup,
			energy_required = 0.5,
			ingredients = {{recipeName.."-"..itemAppendix,1}},
			results= {
				{type="item", name=ingredientName, amount=stackSize},
				{type="item", name=chestName, amount=1}
			},
			order = "a"..string.format("%02d", orderIndex+1),
			enabled = "true"
		},
	})
	orderIndex = orderIndex + 2
end


-- parameters: name of the item (-box), name of item how to calculate stackSize
function item_addBox(itemName,stackItemName)
	if stackItemName == nil then
		stackItemName = itemName
	end
	data:extend({
		{
			type = "item",
			name = itemName.."-box",
			icon = "__packager__/graphics/icons/"..itemName.."-box.png",
			flags = {"goes-to-main-inventory"},
			subgroup = currentSubGroup,
			--category = "crafting", --Unknown property, what does it do?
			order = "a"..string.format("%02d", orderIndex),
			stack_size = woodChestStack(stackItemName)
		},
	})
	orderIndex = orderIndex+1
end