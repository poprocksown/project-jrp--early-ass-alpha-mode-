AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_infomenu.lua")
AddCSLuaFile("precache.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("database/cl_database.lua")
AddCSLuaFile("database/items.lua")
include("sv_rounds.lua")
include("sv_show.lua")
include("sv_tables.lua")
include("precache.lua")
include("resource.lua")
include("player.lua")
include("shared.lua")
include("database/cl_database.lua")
include("database/items.lua")

function GM:Initialize()
	if SERVER then
		self:ResourceAddFiles()
		
		self.RoundTime = 0
	end
end

function GM:SetTeamBalanced(pl)
	if pl:IsPlayer() and IsValid(pl) then
		if self.RoundTime >= CurTime() then
			if ((team.NumPlayers(TEAM_PRISONER)/3) < team.NumPlayers(TEAM_GUARD)) then
				pl:SetTeam(TEAM_PRISONER)
			else
				pl:SetTeam(TEAM_GUARD)
			end
		else
			pl:SetTeam(TEAM_DEAD)
		end
		
		pl:Spawn()
	end
end

function GM:PlayerInitialSpawn(pl)
	if self.RoundEnd == false and (team.NumPlayers(TEAM_GUARD)+team.NumPlayers(TEAM_PRISONER)) <= 1 then self:NewRound() end
	
	self:PrecacheFiles(pl)
	self:SetTeamBalanced(pl)
end

function GM:PlayerSpawnAsSpectator(pl)
	pl:Spectate(OBS_MODE_ROAMING)
	if pl.SpawnSpecPos then
		pl:SetPos(pl.SpawnSpecPos)
		pl:SetEyeAngles(pl.SpawnSpecAng)
		pl.SpawnSpecPos = nil
		pl.SpawnSpecAng = nil
	end
end

function GM:PlayerSpawn(pl)
	pl:SetFrags(0)
	pl:SetDeaths(0)
	
	if pl:Team() == TEAM_DEAD then self:PlayerSpawnAsSpectator(pl) return end
	
	if IsValid(pl:GetRagdollEntity()) then
		pl:GetRagdollEntity():Remove()
	end
	
	pl:UnSpectate()
	pl:StripWeapons()
	pl:StripAmmo()
	
	self:PlayerSetModel(pl)
	self:PlayerLoadout(pl)
end

function GM:PlayerSetModel(pl)
	local mdl = ""
	if pl:Team() == TEAM_GUARD then
		mdl = table.Random(self.PlayerModels.Guard)
	elseif pl:Team() == TEAM_PRISONER then
		mdl = table.Random(self.PlayerModels.Prisoner)
	end
	
	if mdl then pl:SetModel(mdl) end
end

function GM:PlayerSetParams(pl)
	local params = {ar=0,hp=0,ws=200,rs=210}
	if pl:Team() == TEAM_GUARD then
		for k,v in pairs({pistol=108,smg1=270}) do
			pl:GiveAmmo(v,k,true)
		end
		
		params = {ar=100,hp=100,ws=160,rs=265}
	elseif pl:Team() == TEAM_PRISONER then
		params = {ar=0,hp=100,ws=160,rs=250}
	end
	
	pl:SetArmor(params["ar"])
	pl:SetHealth(params["hp"])
	pl:SetRunSpeed(params["rs"])
	pl:SetWalkSpeed(params["ws"])
end

function GM:PlayerLoadout(pl)
	if pl:Team() == TEAM_GUARD or pl:Team() == TEAM_PRISONER then
		self:PlayerSetParams(pl)
		
		pl:Give("weapon_hands")
		pl:Give("weapon_crowbar")
		pl:SelectWeapon("weapon_hands")
	else
		pl:SprintDisable()
	end
	
	if pl:Team() == TEAM_GUARD then
		for _,v in pairs({"weapon_pistol","weapon_smg1"}) do
			pl:Give(v)
		end
	elseif pl:Team() == TEAM_PRISONER then
		//-- Prisoner Loadout --//
	end
end

function GM:PlayerFootstep(pl,pos,foot,sound,vol,rf)
	if pl:Team() == TEAM_GUARD then
		pl:EmitSound(table.Random(self.Sounds.Guard.Footstep),480,100)
	elseif pl:Team() == TEAM_PRISONER then
		pl:EmitSound(table.Random(self.Sounds.Prisoner.Footstep),480,100)
	end
end

function GM:PlayerDropWeapon(pl)
	if IsValid(pl) then
		if pl:IsPlayer() and (#pl:GetWeapons() > 1) and table.HasValue(self.AllowDrop,pl:GetActiveWeapon():GetClass()) and pl:IsInWorld() then
			local tracedata = {}
			tracedata.start = pl:GetPos()
			tracedata.endpos = Vector(pl:GetPos().x,pl:GetPos().y,-1024)
			tracedata.filter = player.GetAll()
			
			local trace = util.TraceLine(tracedata)
			
			local rf = RecipientFilter()
			rf:AddAllPlayers()
			
			local ent = ents.Create("weapon_pickup")
			ent:SetPos(trace.HitPos+(pl:GetForward()*128)+Vector(0,0,12))
			while !ent:IsInWorld() do ent:SetPos(trace.HitPos+Vector(math.random(-64,64),math.random(-64,64),12)) end
			umsg.Start("SetClientModel",rf)
				umsg.String(string.gsub(pl:GetActiveWeapon():GetModel(),"v_","w_"))
			umsg.End()
			ent:SetServersideVars(pl:GetActiveWeapon():GetClass(),string.gsub(pl:GetActiveWeapon():GetClass(),"weapon_",""))
			timer.Simple(0.2, function()
				ent:Spawn()
				ent:Activate()
			end)
			
			pl:StripWeapon(pl:GetActiveWeapon():GetClass())
		end
	end
end

function GM:EntityTakeDamage(ent,inflctr,atckr,amount,dmginfo)
	if ent:IsPlayer() then
		self:PlayerTakeDamage(ent,inflctr,atckr,amount,dmginfo)
	end
end

function GM:EntityTakeDamage(pl,inflctr,atckr,amount,dmginfo)
	if self:PlayerShouldTakeDamage(pl,atckr) then
		if math.random(1,4) < 3 then
			if IsValid(pl:Team()) then
				if pl:Team() == TEAM_GUARD then
					pl:EmitSound(table.Random(self.Sounds.Guard.TakingDamage),400)
				elseif pl:Team() == TEAM_PRISONER then
					if string.find(pl:GetModel(),"female") then
						pl:EmitSound(table.Random(self.Sounds.Prisoner.Female.TakingDamage),400)
					else
						pl:EmitSound(table.Random(self.Sounds.Prisoner.Male.TakingDamage),400)
					end
				end
			end
		end
	end
end

function GM:PlayerShouldTakeDamage(pl,atckr)
	if IsValid(atckr) and atckr:IsPlayer() and GetConVarNumber("mp_friendlyfire") == 0 then
		return pl:Team() ~= atckr:Team()
	else
		return true
	end
end

function GM:DoPlayerDeath(pl,atkr,dmginfo)
	local near_pl = nil
	
	pl:CreateRagdoll()
	
	pl:AddDeaths(1)
	
	if IsValid(atkr) and atkr:IsPlayer() then
		if atkr == pl then
			atkr:AddFrags(-1)
		else
			atkr:AddFrags(1)
			if math.random(1,4) < 3 then
				if atkr:Team() == TEAM_GUARD and pl:Team() == TEAM_PRISONER then
					atkr:EmitSound(table.Random(self.Sounds.Guard.Kill),500,100)
				elseif atkr:Team() == TEAM_PRISONER then
					if string.find(atkr:GetModel(),"female") then
						atkr:EmitSound(table.Random(self.Sounds.Prisoner.Female.Kill),500,100)
					else
						atkr:EmitSound(table.Random(self.Sounds.Prisoner.Male.Kill),500,100)
					end
				end
			end
		end
	end
	
	
	if pl:Team() == TEAM_GUARD then
		pl:EmitSound(table.Random(self.Sounds.Guard.Death),400,100)
		
		near_pl = pl:TeammateIsNear(512,pl:Team())
		if near_pl then near_pl:EmitSound(table.Random(self.Sounds.Guard.FriendlyDown),500,100) end
		
		// MARK PRISONER AS KILLABLE
	elseif pl:Team() == TEAM_PRISONER then
		if string.find(pl:GetModel(),"female") then
			pl:EmitSound(table.Random(self.Sounds.Prisoner.Female.Death),350,100)
		else
			pl:EmitSound(table.Random(self.Sounds.Prisoner.Male.Death),350,100)
		end
		
		near_pl = pl:TeammateIsNear(512,pl:Team())
		if near_pl then
			if string.find(near_pl:GetModel(),"female") then
				near_pl:EmitSound(table.Random(self.Sounds.Prisoner.Female.FriendlyDown),500,100)
			else
				near_pl:EmitSound(table.Random(self.Sounds.Prisoner.Male.FriendlyDown),500,100)
			end
		end
	end
	
	self:PlayerDropWeapon(pl)
end

function GM:PlayerDeath(pl,inflctr,kilr)
	local adminmsg = "[ERROR] adminmsg is undefined (Probably due to invalid killer entity)."
	
	if pl:IsPlayer() then
		if kilr:IsPlayer() and IsValid(inflctr) then
			if pl == kilr then
				adminmsg = pl:Nick().." committed suicide."
			else
				if inflctr:IsPlayer() then
					adminmsg = "["..team.GetName(pl:Team()).."] "..pl:Nick().." was killed by ["..team.GetName(kilr:Team()).."] "..kilr:Nick().." using "..inflctr:GetActiveWeapon():GetClass()
				elseif inflctr:IsWeapon() then
					adminmsg = "["..team.GetName(pl:Team()).."] "..pl:Nick().." was killed by ["..team.GetName(kilr:Team()).."] "..kilr:Nick().." using "..inflctr:GetName()
				else
					adminmsg = "["..team.GetName(pl:Team()).."] "..pl:Nick().." was killed by ["..team.GetName(kilr:Team()).."] "..kilr:Nick().." using "..inflctr:GetClass()
				end
			end
		elseif not kilr:IsPlayer() and IsValid(kilr) and IsValid(inflctr) then
			adminmsg = "["..team.GetName(pl:Team()).."] "..pl:Nick().." was killed by "..kilr:GetClass()
		end
	end
	
	Msg("> "..adminmsg.."\n")
	
	for _,v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK,pl:Nick().." "..table.Random(self.DeathMessages))
		
		if v:IsAdmin() then
			v:PrintMessage(HUD_PRINTCONSOLE,"> "..adminmsg)
		end
	end
	
	pl:SetTeam(TEAM_DEAD)
	
	if self.RoundEnd == true then return end
	self:CheckRound()
end

function GM:CheckRound()
	if team.NumPlayers(TEAM_GUARD) > 0 and team.NumPlayers(TEAM_PRISONER) == 0 then
		self:EndRound(TEAM_GUARD)
	elseif team.NumPlayers(TEAM_GUARD) == 0 and team.NumPlayers(TEAM_PRISONER) > 0 then
		self:EndRound(TEAM_PRISONER)
	elseif team.NumPlayers(TEAM_GUARD) == 0 and team.NumPlayers(TEAM_PRISONER) == 0 then
		self:EndRound()
	end
end

function GM:PlayerDeathThink(pl)
	return false
end

function GM:PlayerDeathSound()
	return true
end

function GM:PlayerDisconnected(pl)
	pl:SetTeam(TEAM_DEAD)
	self:CheckRound()
	pl:databaseDisconnect()
end

function GM:PlayerUse(pl,entity)
	if IsValid(entity) then
		if pl:Team() == TEAM_DEAD then
			return false
		else
			return true
		end
	end
end

function GM:PlayerCanHearPlayersVoice(listener,talker)
	return true, false
end

function GM:PlayerAuthed(pl, steamID, uniqueID)
	print("Player: " .. pl:Nick() .. ", has gotten authed")
	pl:databaseCheck()
end