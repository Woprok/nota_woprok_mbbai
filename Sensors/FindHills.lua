local sensorInfo = {
	name = "FindHills",
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

local missionInfo = Sensors.core.missionInfo()
local areaHeight = missionInfo.areaHeight

-- @description return hills
return function()
    local allHills = {}
    for xCoord = 64, Game.mapSizeX, 128 do
        for zCoord = 64, Game.mapSizeZ, 128 do
            if Spring.GetGroundHeight(xCoord, zCoord) == areaHeight then
                allHills[#allHills+1] = Vec3(xCoord, areaHeight, zCoord)
            end
        end
    end
    
    return allHills
end