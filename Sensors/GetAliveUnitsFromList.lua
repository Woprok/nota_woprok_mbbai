local sensorInfo = {
	name = "GetAliveUnitsFromList",
	desc = "Returns list containing only alive units from the list",
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

-- @description returns new list without dead units
return function(input)
	local alive = {}
	for i = 1, #input, 1
	do 
		if  Spring.ValidUnitID(input[i]) and Spring.GetUnitIsDead(input[i]) == false
		then 
			alive[#alive + 1] = input[i]
		end
	end
	return alive
end