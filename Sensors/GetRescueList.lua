local sensorInfo = {
	name = "GetRescueList",
	desc = "List of units to be saved.",
	author = "Woprok",
	date = "2025-07-27",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

function appendToList(what, to)
	for _, item in ipairs(what) do
		local x, y, z = Spring.GetUnitPosition(item)
		if x > 300 and z < 2*Game.mapSizeZ/3 then
			to[#to+1] = item
		end
	end
	return to
end

-- @description returns list of units ordered by priorities (number of points)
return function(myUnits)
	local runners =     Sensors.core.FilterUnitsByCategory(myUnits, Categories.nota_kahlan_ttdr.runner)
	local rockos =      Sensors.core.FilterUnitsByCategory(myUnits, Categories.nota_kahlan_ttdr.rocko)
	local bulldogs =    Sensors.core.FilterUnitsByCategory(myUnits, Categories.nota_kahlan_ttdr.bulldog)
	local hatracks =    Sensors.core.FilterUnitsByCategory(myUnits, Categories.nota_kahlan_ttdr.hatracks)
	local bods =        Sensors.core.FilterUnitsByCategory(myUnits, Categories.nota_kahlan_ttdr.bod)
	
	local output = {}

	appendToList(runners, output)
	appendToList(rockos, output)
	appendToList(bulldogs, output)
	appendToList(hatracks, output)
	appendToList(bods, output)

	return output
end