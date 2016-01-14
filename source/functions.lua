
local currentSubGroup
-- parameters: subgroup name which is used for further items
function setSubgroup(subGroupName)
	currentSubGroup = subGroupName
end

-- adds both recipes (pack and unpack for one wooden box)
function recipe_addBox(recipeName,ingredientName,containerTier)
	if ingredientName == nil then
		ingredientName = recipeName
	end
	local chestName, category, itemAppendix, stackSize, timeNeeded
	local subgroupName = currentSubGroup
	if not containerTier then
		chestName = "wooden-chest"
		stackSize = woodChestSize
		category = "packager-pack"
		itemAppendix = "box"
		timeNeeded = 0.5
	else
		chestName = "container"
		stackSize = containerSize
		category = "packager-advanced"
		itemAppendix = "container"
		timeNeeded = 5
		subgroupName = "packaging_container"
	end
	
	data:extend({
		{
			type = "recipe",
			name = recipeName.."-"..itemAppendix.."-pack",
			icon = "__packager__/graphics/icons/"..recipeName.."-"..itemAppendix.."-pack.png",
			category = category,
			subgroup = subgroupName,
			energy_required =timeNeeded,
			ingredients = {{ingredientName,stackSize},{chestName,1}},
			result = recipeName.."-"..itemAppendix,
			result_count = 1,
			order = recipeName.."1",
			enabled = "true"
		},
		{
			type = "recipe",
			name = recipeName.."-"..itemAppendix.."-unpack",
			icon = "__packager__/graphics/icons/"..recipeName.."-"..itemAppendix.."-unpack.png",
			category = category,
			subgroup = subgroupName,
			energy_required = timeNeeded,
			ingredients = {{recipeName.."-"..itemAppendix,1}},
			results= {
				{type="item", name=ingredientName, amount=stackSize},
				{type="item", name=chestName, amount=1}
			},
			order = recipeName.."2",
			enabled = "true"
		},
	})
end


-- parameters: name of the item (-box), name of item how to calculate stackSize
function item_addBox(itemName,stackItemName,containerTier)
	if stackItemName == nil then
		stackItemName = itemName
	end
	local itemAppendix, stackSize 
	if not containerTier then
		itemAppendix = "box"
		stackSize = woodChestStack(stackItemName)
	else
		itemAppendix = "container"
		stackSize = containerStack(stackItemName)
	end
	data:extend({
		{
			type = "item",
			name = itemName.."-"..itemAppendix,
			icon = "__packager__/graphics/icons/"..itemName.."-"..itemAppendix..".png",
			flags = {"goes-to-main-inventory"},
			subgroup = currentSubGroup,
			order = itemName,
			stack_size = stackSize
		},
	})
end