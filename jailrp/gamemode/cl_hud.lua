function GM:HUDPaint()
	draw.DrawText("ALPHA", "HudHintTextLarge", 5, 5, Color(155, 255, 15), TEXT_ALIGN_LEFT)
end

function JrpHUD()
	local ply = LocalPlayer()
	local HP = ply:Health()
	local Armor = ply:Armor()

	draw.RoundedBox( 4, 70, ScrH() - 150, 100, 40, Color(40, 40, 40, 30) )
	draw.RoundedBox( 4, 70, ScrH() - 150, math.Clamp( HP, 0, 50) , 200, Color(255, 40, 40, 30) )
	draw.RoundedBox( 4, 70, ScrH() - 150, math.Clamp(HP, 0, 50) , 200, Color(255, 0, 0, 250) )




end
hook.Add("HUDPaint", "JrpHUD", JrpHUD)
function ammo()
	local client = LocalPlayer()
	
	if !client:GetActiveWeapon():IsValid() then return end
	if client:GetActiveWeapon():Clip1() ~= -1 then 
		local mag_current = client:GetActiveWeapon():Clip1() // How much ammunition you have inside the current magazine
		local mag_extra = client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) // How much ammunition you have outside the current magazine
	
	
	draw.SimpleText("Ammo: ", "default", ScrW() - 165, ScrH() - 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(client:GetActiveWeapon():Clip1() .. "", "default", ScrW() - 105, ScrH() - 48, Color(255, 255, 255, 255), 0, 0 )
	draw.SimpleText("/ ", "default", ScrW() - 60, ScrH() - 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(client:GetActiveWeapon():GetPrimaryAmmoType() .. "", "default", ScrW() - 55, ScrH() - 50, Color(255, 255, 255, 255), 0, 0 )
	end
end
hook.Add("HUDPaint", "ammo", ammo)

local tohide = { 
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name) 
	if (tohide[name]) then     
		return false;      
	end
end
hook.Add("HUDShouldDraw", "Hide HUD", HUDShouldDraw)