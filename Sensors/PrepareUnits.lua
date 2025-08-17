local sensorInfo = {
	name = "PrepareUnits",
	desc = "Prepare unit group format",
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


-- @description returns prepared list of unit groups
return function()
    local prepared_groups = {
        backdoor_ready = { },
        base_transportable = { },
        attackers = { },
        front_diversion = { }, -- list of all other units
        gatherers = { {}, {}, {} }, -- list of farks top, mid, bot

    }

	return prepared_groups
end