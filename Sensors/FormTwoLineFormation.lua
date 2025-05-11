local sensorInfo = {
	name = "FormTwoLineFormation",
	desc = "Places units on a two lines",
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

-- @argument front_line_count [number of frontline units]
-- @argument back_line_count [number of backline units]
-- @argument spacing [number] (default 20)
-- @return formation [array of Vec3 positions]
return function(front_line_count, back_line_count, spacing, spacing_lines)
	if spacing == nil then
		spacing = 20
	end
	if spacing_lines == nil then
		spacing_lines = 20
	end

	local formation = {}
	local flc = #front_line_count
	local blc = #back_line_count

	-- Frontline: placed at z = 0
	local half_front = math.floor(flc / 2)
	for i = 1, flc do
		local offset = (i - 1) - half_front
		formation[i] = Vec3(offset * spacing, 0, 0)
	end

	-- Backline: placed at z = -spacing_lines, centered on frontline
	local half_back = math.floor(blc / 2)
	for i = 1, blc do
		local offset = (i - 1) - half_back
		local index = flc + i
		formation[index] = Vec3(offset * spacing, 0, -spacing_lines)
	end

	return formation
end