local sensorInfo = {
	name = "FilterHillsByDistance",
	desc = "Return coordinates of hills on the map.",
	author = "Woprok",
	date = "2025-05-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local function ApproximateDistance(a, b)
    local dx = b.x - a.x
    local dy = b.y - a.y
    local dz = b.z - a.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-- @description return hills in range, hills expects array of Vector3
return function(hill_array, min, max, unit_pos)
    local filtered_hills = {} 
    if unit_pos == nil then
        unit_pos = Vec3(0,0,0)
    end
    if max == nil then
        max = 2147483647
    end
    
    for _, hill_pos in ipairs(hill_array) do
        local distance = ApproximateDistance(hill_pos, unit_pos)
        if min < distance and distance < max then
            filtered_hills[#filtered_hills + 1] = hill_pos
        end
    end

    return filtered_hills
end