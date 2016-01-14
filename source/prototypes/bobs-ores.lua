
setSubgroup("packaging_raw")

local ores = {
	"bauxite-ore","cobalt-ore","gem-ore","gold-ore","lead-ore","nickel-ore","quartz",
	"rutile-ore","silver-ore","tin-ore","tungsten-ore","zinc-ore",
	"aluminium-plate", "lead-plate", "tin-plate", "silver-plate", "glass", "resin", "rubber", 
	"gold-plate", "cobalt-plate","tungsten-plate", "zinc-plate", "nickel-plate", "titanium-plate",
	"bronze-plate", "brass-plate", "electrum-plate", "invar-plate"
}

for _,oreName in pairs(ores) do
	if data.raw["item"][oreName] ~= nil then
		item_addBox(oreName)
		recipe_addBox(oreName)
	end
end