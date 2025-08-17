local sensorInfo = {
	name = "RefreshUnits",
	desc = "List of units in SD in reasonable format",
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

-- Game.mapSizeZ
-- Spring.GetUnitPosition
local IsValidUnitID = Spring.ValidUnitID --(unitsID)
local IsUnitDead = Spring.GetUnitIsDead -- (unitID)
local GetTeamUnits = Spring.GetTeamUnits -- (teamID)
local GetMyTeamID = Spring.GetMyTeamID -- ()

function index_units(what)
	local index_unitId = {}
	for _, item in ipairs(what) do
		if IsValidUnitID(item) and IsUnitDead(item) == false then
			index_unitId[#index_unitId + 1] = item
		end
	end
	return index_unitId
end

-- @description returns list of units
return function()
	local my_units = GetTeamUnits(GetMyTeamID())
	local unit_scouts 			=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_scouts)
	local unit_scouts_flying 	=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_scouts_flying)
	local unit_repair 			=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_repair)
	local unit_siege 			=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_siege)
	local unit_soldiers 		=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_soldiers)
	local unit_soldiers_big 	=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_soldiers_big)
	local unit_transports 		=     Sensors.core.FilterUnitsByCategory(my_units, Categories.nota_woprok_mbbai.sd_transport)
	
	local new_all_units = {
		counts = { 
			scouts =		#unit_scouts,
			scouts_flying = #unit_scouts_flying,
			repair = 		#unit_repair,
			siege = 		#unit_siege,
			soldiers = 		#unit_soldiers,
			soldiers_big = 	#unit_soldiers_big,
			transports = 	#unit_transports
		},
		indexed = {
			scouts =		index_units(unit_scouts),
			scouts_flying = index_units(unit_scouts_flying),
			repair = 		index_units(unit_repair),
			siege = 		index_units(unit_siege),
			soldiers = 		index_units(unit_soldiers),
			soldiers_big = 	index_units(unit_soldiers_big),
			transports = 	index_units(unit_transports)
		}
	} 

	return new_all_units
end