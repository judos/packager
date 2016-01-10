
setSubgroup("packaging_raw")

local ores = {
	"bauxite-ore","cobalt-ore","gem-ore","gold-ore","lead-ore","nickel-ore","quartz",
	"rutile-ore","silver-ore","tin-ore","tungsten-ore","zinc-ore"
}

{"item-name.bauxite-ore-box", "ASDF"}

for _,oreName in pairs(ores) do
	if data.raw["item"][oreName] ~= nil then
		item_addBox(oreName)
		recipe_addBox(oreName)
	end
end