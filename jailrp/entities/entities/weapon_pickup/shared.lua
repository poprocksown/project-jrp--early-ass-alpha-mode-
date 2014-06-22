ENT.Type = "anim"

ENT.PrintName		= "Weapon Pickup"
ENT.Author			= "SittingBear"
ENT.Contact			= "N/A"
ENT.Purpose			= "New way to pick up weapons!"
ENT.Instructions	= "Just spawn it."

local params = {
	["$basetexture"] = "sprites/glow04",
	["$additive"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$nocull"] = 1
}

if CLIENT then
	ENT.SpriteMat = CreateMaterial("WeaponPickupGlowSprite","UnlitGeneric",params)
	
	function ENT.SetClientModel(um,self)
		local mdl = um:ReadString()
		
		if !mdl then
			self.WeaponModel = "models/weapons/w_pistol.mdl"
		else
			self.WeaponModel = mdl
		end
	end
	usermessage.Hook("SetClientModel",ENT.SetClientModel,ENT)
	
	function ENT:Draw()
		self:SetModel(self.WeaponModel)
		
		self:SetAngles(Angle(0,math.floor(CurTime()*100),0))
		
		render.SetMaterial(self.SpriteMat)
		render.DrawSprite(self:GetPos(),24+(math.sin(CurTime())*4),24+(math.sin(CurTime())*4),Color(0,200,255,255))
		
		self:DrawModel()
	end
end

if SERVER then
	AddCSLuaFile("shared.lua")
	
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube05x05x05.mdl")
		self:PhysicsInit(SOLID_BBOX)
		self:SetTrigger(true)
		self:SetNotSolid(true)
		
		local PhysObj = self:GetPhysicsObject()
		
		if (PhysObj:IsValid()) then
			PhysObj:Wake()
			PhysObj:EnableMotion(false)
		end
	end
	
	function ENT:SetServersideVars(wpn,ammo)
		if !wpn then
			self.GiveWeapon = "weapon_pistol"
		else
			self.GiveWeapon = wpn
		end
		if !ammo then self.GiveWeaponAmmo = "pistol" else self.GiveWeaponAmmo = ammo end
	end
	
	function ENT:StartTouch(hitEnt)
		if (IsValid(hitEnt) and hitEnt:IsPlayer()) then
			hitEnt:Give(self.GiveWeapon)
			
			self:Remove()
		end
	end
	
	function ENT:Think()
		
	end
end