require "defines"

function start()
	local p = game.local_player
	
	p.insert{name="basic-mining-drill",count=10}
	p.insert{name="iron-plate",count=200}
	p.insert{name="copper-plate",count=200}
	p.insert{name="basic-transport-belt",count=50}
	p.insert{name="basic-inserter",count=50}
	p.insert{name="belt-packager",count=10}
	p.insert{name="configurable-packager",count=10}
	p.insert{name="infiniteEnergy",count=1}
	p.insert{name="medium-electric-pole",count=50}
end


remote.add_interface("packager", {
  start
})

-- /c game.local_player.insert{name="basic-inserter",count=50}