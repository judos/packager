
local orderIndex
local category
-- parameters: subgroup name which is used for further items
-- also sets back the orderIndexs
function item_setSubgroup(catName)
	category = catName
	orderIndex = 1
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
			subgroup = category,
			--category = "crafting", --Unknown property, what does it do?
			order = "a"..orderIndex,
			stack_size = woodChestStack(stackItemName)
		},
	})
	orderIndex = orderIndex+1
end