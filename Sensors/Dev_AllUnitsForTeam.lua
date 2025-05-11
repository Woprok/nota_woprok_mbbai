local sensorInfo = {
	name = "AllUnitsForTeam",
	desc = "Return all units for team",
	author = "woprok",
	date = "2025-03-26",
	license = "woprok",
}


local EVAL_PERIOD_DEFAULT = 100 -- defines caching, 0 is no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
--local SpringGeUnits = Spring.GetWind
-- local AllRelevantUnitsForTreeAndSensor = units -- magical thing that exists
local my_units = Spring.GetTeamUnits
local my_team_id = Spring.GetMyTeamID 

-- @description return all units for the team
return function(team)
	--local painkillers = SpringGetWind()
	return my_units(my_team_id())
end