require "defines"
 
function start()
	for _,player in pairs(game.players) do
		player.insert{name="basic-mining-drill",count=10}
		player.insert{name="iron-plate",count=200}
		player.insert{name="copper-plate",count=200}
		player.insert{name="basic-transport-belt",count=50}
		player.insert{name="basic-inserter",count=50}
		player.insert{name="belt-packager",count=10}
		player.insert{name="configurable-packager",count=10}
		player.insert{name="infiniteEnergy",count=1}
		player.insert{name="medium-electric-pole",count=50}
	end
end
 
--Use:  /c remote.call("packager","start")
remote.add_interface("packager", {
  start = function() start() end
})