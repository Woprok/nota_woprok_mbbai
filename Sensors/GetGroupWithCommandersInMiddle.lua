local sensorInfo = {
	name = "GetGroupWithCommandersInMiddle",
	desc = "Places commanders in the center of the unit group, guards on sides.",
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

-- @argument commanders [array of unitIDs]
-- @argument guards [array of unitIDs]
-- @return groupDef [table mapping unitID -> index]
return function(commanders, guards)
	local groupDef = {}
	local halfPoint = math.floor(#guards / 2)
	local index = 1

	-- Guards to the left
	for i = 1, halfPoint do
		groupDef[guards[i]] = index
		index = index + 1
	end

	-- Commanders in the middle
	for i = 1, #commanders do
		groupDef[commanders[i]] = index
		index = index + 1
	end

	-- Guards to the right
	for i = halfPoint + 1, #guards do
		groupDef[guards[i]] = index
		index = index + 1
	end

	return groupDef
end