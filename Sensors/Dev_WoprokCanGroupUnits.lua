local sensorInfo = {
	name = "WoprokCanGroupUnits",
	desc = "Flip keys and values of units table",
	author = "Woprok",
	date = "2017-05-16",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
--local SpringGetWind = Spring.GetWind

-- @description return structured description of the formation
-- @argument listofunits [array]
return function(listofunits)
	local groupDef = {}
	for i=1, #listofunits do
		local unitID = listofunits[i]
		--get unitID
		groupDef[unitID] = i
	end
	return groupDef
	-- formation.StaticTransform to space units
end