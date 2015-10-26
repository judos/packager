for i, force in pairs(game.forces) do
	force.reset_technologies()
	force.reset_recipes()
	
	-- Example technology unlocking migration:
	--[[
	if force.technologies["technology_name"].researched then
		force.recipes["item_name"].enabled = true
	end
	]]--
end