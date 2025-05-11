local sensorInfo = {
	name = "ConvertToGroupDef",
	desc = "Groups units.",
	author = "Woprok",
	date = "2025-04-22",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @argument units_to_group [table of arrays of unitIDs]
-- @return groupDef [table mapping unitID -> index]
return function(units_to_group)
	local groupDef = {}
	local index = 1

	for _, unitList in ipairs(units_to_group) do
		for _, unitID in ipairs(unitList) do
			groupDef[unitID] = index
			index = index + 1
		end
	end

	return groupDef
end