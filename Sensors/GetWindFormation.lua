local sensorInfo = {
	name = "GetWindFormation",
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

-- @argument formation 
-- @argument windDir 
-- @return rotatedFormation [array of Vec3 positions]
return function(formation, windVec)
	local wx, wz = windVec.x, windVec.z
	local windLen = math.sqrt(wx * wx + wz * wz)
	if windLen == 0 then
		return formation -- no rotation if wind is zero
	end

	-- Normalized perpendicular vector to wind (swap x/z and negate one)
	local perpX = -wz / windLen
	local perpZ =  wx / windLen

	local rotatedFormation = {}

	for i, pos in ipairs(formation) do
		local x = pos.x
		local z = pos.z
		local rotatedX = x * perpX + z * (-perpZ)
		local rotatedZ = x * perpZ + z * perpX
		rotatedFormation[i] = Vec3(rotatedX, 0, rotatedZ)
	end

	return rotatedFormation
end