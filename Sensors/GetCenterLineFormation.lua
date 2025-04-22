local sensorInfo = {
	name = "GetCenterLineFormation",
	desc = "Places units in a straight line on X-axis, centered around origin.",
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

-- @argument units [array of unitIDs in order]
-- @argument spacing [number] (default 20)
-- @return formation [array of Vec3 positions]
return function(units, spacing)
	if spacing == nil then
        spacing = 20 
    end

	local formation = {}
	local count = #units
	local half = math.floor(count / 2)

	for i = 1, count do
		local offset = (i - 1) - half
		formation[i] = Vec3(offset * spacing, 0, 0)
	end

	return formation
end