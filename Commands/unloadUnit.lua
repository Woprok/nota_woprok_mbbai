function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Unload given unit",
		parameterDefs = {
			{ 
				name = "transporter",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "radius",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

function Run(self, units, parameter, position, radius)
	local transporter = parameter.transporter -- UnitID
	local unit = parameter.unit -- UnitID
    local position = parameter.position       -- should be {x, y, z}
    local radius = parameter.radius
	
	if not Spring.ValidUnitID(unit) or not Spring.ValidUnitID(transporter) then
		return FAILURE
	end

	if Spring.GetUnitTransporter(unit) == nil then
		return SUCCESS
	end

	if not self.init then
		Spring.GiveOrderToUnit(transporter, CMD.UNLOAD_UNITS,
				{position.x, position.y, position.z,
				 radius}, {"shift"})
		self.init = true
	end

	return RUNNING
end

function Reset(self)
	self.init = false
end

