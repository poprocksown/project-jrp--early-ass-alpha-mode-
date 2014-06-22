GM.Name			= "JailRP"
GM.Author		= "SittingBear"
GM.Email		= "n/a"
GM.Website		= "n/a"
GM.TeamBased	= true

DeriveGamemode("base")

function GM:CreateTeams()	
	TEAM_GUARD = 1
	team.SetUp(TEAM_GUARD,"Guards",Color(0,0,255,255))
	team.SetSpawnPoint(TEAM_GUARD,"info_player_counterterrorist")

	TEAM_PRISONER = 2
	team.SetUp(TEAM_PRISONER,"Prisoners",Color(255,0,0,255))
	team.SetSpawnPoint(TEAM_PRISONER,"info_player_terrorist")

	TEAM_DEAD = 3
	team.SetUp(TEAM_DEAD,"Dead",Color(120,120,120,255))
end