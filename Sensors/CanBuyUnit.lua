local sensorInfo = {
	name = "CanBuyUnit",
	desc = "Returns true if we have enough metal to purchase the given item, false otherwise",
	author = "Woprok",
	date = "2025-08-16",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

-- speed-ups
local GetMyTeamID = Spring.GetMyTeamID
local GetTeamResources = Spring.GetTeamResources -- id, "metal"

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description return true if we have enough metal to purchase the given item
return function(shop_data, unitName)
    local currentMetal = GetTeamResources(GetMyTeamID(), "metal")
    
    if unitName == nil then
        return false
    end

    local cost = shop_data.unit_shop[unitName]
    if cost ~= nil and cost <= currentMetal then
        return true
    end
    
    -- otherwise the parameters are not valid
    return false
end