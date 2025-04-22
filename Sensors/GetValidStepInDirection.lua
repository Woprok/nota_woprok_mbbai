local sensorInfo = {
	name = "GetValidStepInDirection",
	desc = "Return valid target position in specified direction",
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

-- @description return position to move according to input and 
-- @param inDirection - move direction
-- @param locationDistance - targeted distance
-- @param mapBounds - bounded box around the map
return function(inDirection, locationDistance, mapBounds)
    
	if #units <= 0 then
        return -1	
	end
    if locationDistance == nil then
        locationDistance = 20
    end
    if mapBounds == nil then
        mapBounds = 50
    end

    local unitID = units[1]
    local x,y,z = Spring.GetUnitPosition(unitID)
    local finalDirection = inDirection * locationDistance
    
    local targetX = x + finalDirection.x
    local upperXlimit = Game.mapSizeX - mapBounds
    if targetX > upperXlimit then
        targetX = upperXlimit
    end
    if targetX < mapBounds then
        targetX = mapBounds
    end
    
    local targetZ = z + finalDirection.z
    local upperZlimit = Game.mapSizeZ - mapBounds
    if targetZ > upperZlimit then
        targetZ = upperZlimit
    end
    if targetZ < mapBounds then
        targetZ = mapBounds
    end
    
    targetY = Spring.GetGroundHeight(targetX, targetZ)
    
    return Vec3(targetX, targetY, targetZ)
end