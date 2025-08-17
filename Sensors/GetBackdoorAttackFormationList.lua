local sensorInfo = {
	name = "GetBackdoorAttackFormationList",
	desc = "List of units to be moved.",
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

local GetUnitPosition = Spring.GetUnitPosition
local GetTeamUnits = Spring.GetTeamUnits -- (teamID)
local GetMyTeamID = Spring.GetMyTeamID -- ()

function GetDistance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dz = pos1.z - pos2.z  -- Ignore y if you only need 2D distance
    return math.sqrt(dx*dx + dz*dz)
end

function appendToDefList(what, to, pos, tol)
	local index = 1
	for _, item in ipairs(what) do
        local x, y, z = GetUnitPosition(item)
        if x and y and z and pos then
            local dist = GetDistance(Vec3(x, y, z), pos)
            if dist <= tol then
                to[item] = index
				index = index + 1
            end
        end
	end
	return to
end

-- @description returns list of units ordered by priorities (number of points)
return function(our_base_pos, tolerance)

	local my_units = GetTeamUnits(GetMyTeamID())
	local unit_soldiers_big = Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_soldiers_big)
	
	local output = {}

	appendToDefList(unit_soldiers_big, output, our_base_pos, tolerance)

	return output
end