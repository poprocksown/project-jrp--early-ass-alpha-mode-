function GM:PrecacheLoop(pl,tab,style)
	if style == 0 then
		for _,v in pairs(tab) do
			util.PrecacheModel(v)
			pl:PrintMessage(HUD_PRINTCONSOLE,"[model] Precaching: "..v)
		end
	elseif style == 1 then
		for _,v in pairs(tab) do
			util.PrecacheSound(v)
			pl:PrintMessage(HUD_PRINTCONSOLE,"[sound] Precaching: "..v)
		end
	end
end

function GM:PrecacheFiles(pl)
	local modeltables = {
		self.PlayerModels.Prisoner,
		self.PlayerModels.Guard
	}
	local soundtables = {
		self.Sounds.Guard.Death,
		self.Sounds.Guard.Footstep,
		self.Sounds.Guard.FriendlyDown,
		self.Sounds.Guard.Kill,
		self.Sounds.Guard.TakingDamage,
		self.Sounds.Prisoner.Male.Death,
		self.Sounds.Prisoner.Female.Death,
		self.Sounds.Prisoner.Footstep,
		self.Sounds.Prisoner.Male.FriendlyDown,
		self.Sounds.Prisoner.Female.FriendlyDown,
		self.Sounds.Prisoner.Male.Kill,
		self.Sounds.Prisoner.Female.Kill,
		self.Sounds.Prisoner.Male.TakingDamage,
		self.Sounds.Prisoner.Female.TakingDamage
	}
	
	for _,mt in pairs(modeltables) do
		self:PrecacheLoop(pl,mt,0)
	end
	
	for _,st in pairs(soundtables) do
		self:PrecacheLoop(pl,st,1)
	end
end