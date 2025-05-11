local sensorInfo = {
	name = "RotateFormationToDirection",
	desc = "Rotates formation toward the target position",
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

-- @argument formation [array of Vec3]
-- @argument target_position Vec3 
-- @return rotatedFormation [array of Vec3 positions]
return function(formation, target_position)
	if #formation == 0 then
		return {}
	end

	-- Compute center of the formation
	local center = Vec3(0, 0, 0)
	for _, pos in ipairs(formation) do
		center = center + pos
	end
	center = center / #formation

	-- Get direction vector from center to target
	local dir = target_position - center
	local len = math.sqrt(dir.x * dir.x + dir.z * dir.z)
	if len == 0 then
		return formation -- no rotation if already at target
	end

	dir = dir / len -- normalize

	-- Compute angle between default forward (0, 0, 1) and direction vector
	local angle = math.atan2(dir.x, dir.z) -- Y-axis rotation

	local cosA = math.cos(angle)
	local sinA = math.sin(angle)

	local rotatedFormation = {}
	for i, pos in ipairs(formation) do
		-- Translate to origin
		local relX = pos.x - center.x
		local relZ = pos.z - center.z

		-- Rotate around Y axis
		local rotX = relX * cosA - relZ * sinA
		local rotZ = relX * sinA + relZ * cosA

		-- Translate back
		rotatedFormation[i] = Vec3(rotX + center.x, pos.y, rotZ + center.z)
	end

	return rotatedFormation
end