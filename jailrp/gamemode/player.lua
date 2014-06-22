local plyr = FindMetaTable("Player")

function plyr:TeammateIsNear(r,tm)
	local near_ents = ents.FindInSphere(self:GetPos(),r)
	
	for _,v in pairs(near_ents) do
		if v:IsPlayer() and not (v == self) and v:Alive() then
			if v:Team() == tm then
				return v
			end
		end
	end
end