local sensorInfo = {
	name = "GetWindDirection",
	desc = "Return direction of the wind.",
	author = "Woprok",
	date = "2025-04-22",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local SpringGetWind = Spring.GetWind

-- @description return direction vector
return function()
	local dirX, dirY, dirZ, strength, normDirX, normDirY, normDirZ = SpringGetWind()	
	return Vec3(dirX, 0, dirZ)	
end