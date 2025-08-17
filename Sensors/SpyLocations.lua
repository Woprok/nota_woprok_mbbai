local sensorInfo = {
	name = "SpyLocations",
	desc = "Return coordinates of bases on the map.",
	author = "Woprok",
	date = "2025-08-03",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

--local missionInfo = Sensors.core.missionInfo()
--local areaHeight = missionInfo.areaHeight

-- @description return hills
return function()
    -- empirical definition by human
    local all_bases = {
        [1] = Vec3(7900, 173, 2100),
        [2] = Vec3(7300, 173, 1000),
        [3] = Vec3(9200, 173, 2500),
        [4] = Vec3(9500, 173, 600), -- behind
        [5] = Vec3(8900, 173, 1400), -- throne
    }
    
    return all_bases
end