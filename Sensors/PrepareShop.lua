local sensorInfo = {
	name = "PrepareUnits",
	desc = "Prepare shop format",
	author = "Woprok",
	date = "2025-08-04",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description returns prepared shop stuff
return function(missionInfo)
    local prepared_shop = {
        unit_shop = missionInfo.buy,
        line_upgrade_cost = missionInfo.upgrade.line,
        max_line_level = 15,
        line_min_metal_required = 1500,
        top_line = 0,
        mid_line = 0,
        bot_line = 0
    }

	return prepared_shop
end