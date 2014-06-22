GM.RoundTime = 0
GM.RoundEnd = false

function GM:RoundCleanup(tab)
	for _,ent in pairs(tab) do
		if IsValid(ent) then ent:Remove() end
	end
end

function GM:NewRound()
	local rand = 1
	local pls = player.GetAll()
	local sortedpls = {}
	local cleanupents = {
		ents.FindByClass("weapon_*"),
		ents.FindByClass("prop_*")
	}
	
	self.RoundEnd = false
	self.RoundTime = CurTime() + 15
	
	for _,tab in pairs(cleanupents) do
		self:RoundCleanup(tab)
	end
	
	for _,door in pairs(ents.FindByClass("func_door")) do
		door:Fire("Close",0)
	end
	
	for i=1,#pls do
		rand = math.random(1,#pls)
		table.insert(sortedpls,1,pls[rand])
		table.remove(pls,rand)
	end
	
	for _,pl in pairs(sortedpls) do
		pl:SetTeam(TEAM_DEAD)
		self:SetTeamBalanced(pl)
		
		pl:ConCommand("r_cleardecals")
	end
	
	Msg("> New round has begun!\n")
end

function GM:EndRound(winteam)
	
	if not winteam then
		roundtext = "[JailRP] No winners this round, next round in 5 seconds."
		Msg("> Ending round, neither team won.\n")
	elseif winteam == TEAM_GUARD then
		roundtext = "[JailRP] All the Prisoners have died, next round in 5 seconds."
		Msg("> Ending round, winner is Team "..team.GetName(winteam)..".\n")
	elseif winteam == TEAM_PRISONER then
		roundtext = "[JailRP] All the Guards have died, next round in 5 seconds."
		Msg("> Ending round, winner is Team "..team.GetName(winteam)..".\n")
	end
	
	for _,pl in pairs(player.GetAll()) do
		pl:PrintMessage(HUD_PRINTTALK,roundtext)
		pl:ConCommand("play vo/k_lab/kl_initializing.wav")
	end
	
	timer.Simple(5,function() gamemode.Call("NewRound") end)
	
	self.RoundEnd = true
end
