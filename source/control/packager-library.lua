

function builtPackagerLibrary(entity)
	scheduleAdd(entity, game.tick + 60)
	return {}
end


function tickPackagerLibrary(entity)
	
	local inventory = entity.get_inventory(defines.inventory.chest)
	local invalid = false -- invalid if items with health or durability are used
	local recipeAvailable = false -- check that a recipe is available in the chest
	local amountItems = 0 -- check that not too many items are added into a box
	local content = {}
	
	-- check that no items with durability or health are used
	-- find recipe stack index
	-- check amount of items and find actual ingredients
	for i=1,#inventory do
		local stack = inventory[i]
		if stack and stack.valid_for_read then
			if stack.health ~= 1 then invalid=true; break end
			if stack.durability ~= nil then invalid=true; break end
			if stack.name == "packager-recipe-empty" then
				recipeAvailable = true
			else
				amountItems = amountItems + stack.count
				content[stack.name] = stack.count
			end
		end
	end
	if invalid then return 60,nil end
	if not recipeAvailable then return 60,nil end
	if amountItems > 10 then return 60,nil end
	warn(serpent.block(content))
	-- check if recipe already exists
	local recipeIndex = 0
	for i=1,#global.recipes do
		--warn("Deepcompare( "..serpent.block(global.recipes[i])..", "..serpent.block(content).." ) = "..tostring(deepcompare(global.recipes[i],content)))
		if deepcompare(global.recipes[i],content) then
			recipeIndex = i
			break
		end
	end
	if recipeIndex == 0 then
		recipeIndex = #global.recipes + 1
		global.recipes[recipeIndex] = content
	end
	
	-- create plan
	inventory.remove({name="packager-recipe-empty", count=1})
	inventory.insert({name="packager-recipe",count=1,health= recipeIndex/intToFloatDivider})
	
	return 60,nil
end
