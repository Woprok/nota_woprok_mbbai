local sensorInfo = {
	name = "PreparePositions",
	desc = "Returns prepared position for backdoor plan.",
	author = "Woprok",
	date = "2025-08-16",
	license = "no",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local DISTANCE_FROM_EDGE = 150
local DISTANCE_FROM_EDGE_BASE = 200
local DISTANCE_FROM_BASE = 1500

-- speed-ups
local GetGroundHeight = Spring.GetGroundHeight

function transform_lane(lane_points)
	local output = {}
	for i = 1, #lane_points 
	do
		output[i] = lane_points[i].position
	end
	return output
end

function get_backdoor_meeting_point(enemy, ally, maxX, maxZ)
    -- get direction from myBasePosition to EnemyBasePosition
    local direction = (enemy - ally):GetNormalized()
    -- go in that direction from the enemy base for a sufficient distance
    local result = enemy + direction * DISTANCE_FROM_BASE
    -- don't overshoot
    if result.x < DISTANCE_FROM_EDGE_BASE then 
        result.x = DISTANCE_FROM_EDGE_BASE 
    end
    if result.x > maxX - DISTANCE_FROM_EDGE_BASE then 
        result.x = maxX - DISTANCE_FROM_EDGE_BASE 
    end
    if result.z < DISTANCE_FROM_EDGE_BASE then 
        result.z = DISTANCE_FROM_EDGE_BASE 
    end
    if result.z > maxZ - DISTANCE_FROM_EDGE_BASE then 
        result.z = maxZ - DISTANCE_FROM_EDGE_BASE 
    end
    return result
end

function get_vertical_edge(point, maxX, maxZ)
    local dist = {
        [1] = point.x, 
        [2] = maxX - point.x, 
        [3] = point.z, 
        [4] = maxZ - point.z
    }  -- distances to the four edges
    local min = math.min(dist[1], dist[2], dist[3], dist[4])
    local result = Vec3(point.x, point.y, point.z)
    if result.x < maxX - result.x then
        result.x = DISTANCE_FROM_EDGE
    else
        result.x = maxX - DISTANCE_FROM_EDGE
    end
    return result
end

function get_backdoor_path(ally_meeting_point, maxX, maxZ)
    local path = {}
    -- get nearest vertical edge
    local firstPoint = get_vertical_edge(ally_meeting_point, maxX, maxZ)
    path[#path+1] = firstPoint
    -- get opposite horizontal edge
    local x = firstPoint.x
    local z = firstPoint.z > maxZ / 2 and DISTANCE_FROM_EDGE or maxZ - DISTANCE_FROM_EDGE
    path[#path+1] = Vec3(x, GetGroundHeight(x, z), z)
    -- get opposite vertical edge
    x = maxX - x
    path[#path+1] = Vec3(x, GetGroundHeight(x, z), z)

    return path
end

-- @description return a point which is far behind an enemy base
return function(missionInfo)
    local prepared_positions = {
        top = { },
        mid = { },
        bot = { },
        base_ally = { },
        base_enemy = { },
        backdoor_path = { },
        backdoor_point = { },
        mid_point = { }
    }
    local maxX = Game.mapSizeX
    local maxZ = Game.mapSizeZ
    -- all relevant positions for us
	prepared_positions.top = transform_lane(missionInfo.corridors.Top.points)
	prepared_positions.mid = transform_lane(missionInfo.corridors.Middle.points)
	prepared_positions.bot = transform_lane(missionInfo.corridors.Bottom.points)
    prepared_positions.lanes = {
        [1] = prepared_positions.top,
        [2] = prepared_positions.mid,
        [3] = prepared_positions.bot,
    }
    prepared_positions.base_ally        = prepared_positions.mid[1]
    prepared_positions.base_enemy       = prepared_positions.mid[#prepared_positions.mid]
    prepared_positions.backdoor_path    = get_backdoor_path(prepared_positions.base_ally, maxX, maxZ)
    prepared_positions.backdoor_point   = get_backdoor_meeting_point(prepared_positions.base_enemy, prepared_positions.base_ally, maxX, maxZ)
    prepared_positions.mid_point        = prepared_positions.mid[7] -- most likely position near our mid tower
    -- return all prepared positions and paths
    return prepared_positions
end