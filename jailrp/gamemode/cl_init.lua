include("cl_hud.lua")
include("cl_infomenu.lua")
include("precache.lua")
include("shared.lua")
include("database/cl_database.lua")
include("database/items.lua")

function GM:ForceDermaSkin()
	return "default"
end

hook.Add("PlayerFootstep","DisableDefaultFootstep",function() return true end)