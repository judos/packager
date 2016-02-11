function table.addTable(t,toAdd)
	for k,v in pairs(toAdd) do t[k] = v end
end

function table.set(t) -- set of list
  local u = { }
  for _, v in ipairs(t) do u[v] = true end
  return u
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- DyTech source codes:
--[[Debug Functions]]--
debug_master = true -- Master switch for debugging, shows most things!
debug_level = 1 -- 1=info 2=warning 3=error

function info(message)
	if debug_level<=1 then debug(message,"INFO") end
end
function warn(message)
	if debug_level<=2 then debug(message,"WARN") end
end
function error(message)
	if debug_level<=3 then debug(message,"ERROR") end
end

function debug(message,level)
	if not level then level="ANY" end
	if debug_master then
		if type(message) ~= "string" then
			message = serpent.block(message)
		end
		print(level..": "..message)
	end
end

local printIndex = 1
function PlayerPrint(message)
	if not game then
		debug(message)
		return
	end
	for _,player in pairs(game.players) do
		player.print(printIndex.." "..message)
		printIndex = printIndex + 1
	end
end