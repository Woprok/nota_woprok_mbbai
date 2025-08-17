local sensorInfo = {
	name = "DistributeGatherers",
	desc = "distribute unassigned farks to a groups",
	author = "Woprok",
	date = "2025-08-03",
	license = "nope",
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching
function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


return function(old, desired_count)

	local allUnits  = Spring.GetTeamUnits(Spring.GetLocalTeamID())
	
	for i=1, #allUnits 
	do
		if Spring.GetUnitDefID(allUnits[i]) == UnitDefNames['armfark'].id  and old.dict[allUnits[i]] == nil
		then 
			if #old[1] < desired_count then 
				old[1][#old[1] + 1] = allUnits[i]
				old.dict[allUnits[i]] = true
			elseif #old[2] < desired_count then
				old[2][#old[2] + 1] = allUnits[i]
				old.dict[allUnits[i]] = true
			elseif #old[3] < desired_count then
				old[3][#old[3] + 1] = allUnits[i]
				old.dict[allUnits[i]] = true
			end
		end
	end
		
	return old	
end