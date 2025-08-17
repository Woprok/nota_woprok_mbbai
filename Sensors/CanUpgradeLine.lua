local sensorInfo = {
	name = "CanUpgradeLine",
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
return function(shop_data)
    local currentMetal = GetTeamResources(GetMyTeamID(), "metal")

    if currentMetal >= shop_data.line_min_metal_required and 
       currentMetal >= shop_data.line_upgrade_cost and
       ( shop_data.mid_line < shop_data.max_line_level or
         shop_data.top_line < shop_data.max_line_level or
         shop_data.bot_line < shop_data.max_line_level ) then
        return true
    end
    
    -- otherwise the parameters are not valid
    return false
end