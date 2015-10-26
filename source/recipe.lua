setSubgroup("packaging_raw")
recipe_addBox("iron-ore")
recipe_addBox("copper-ore")
recipe_addBox("stone")
recipe_addBox("coal")
recipe_addBox("plastic","plastic-bar")

recipe_addBox("iron-ore",nil,true) --container
recipe_addBox("copper-ore",nil,true) --container

setSubgroup("packaging_plates")
recipe_addBox("iron","iron-plate")
recipe_addBox("copper","copper-plate")
recipe_addBox("steel","steel-plate")