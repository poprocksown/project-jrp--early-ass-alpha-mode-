SWEP.Base = "weapon_base"

if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.Weight			= 100
	SWEP.AutoSwitchTo	= false
	SWEP.AutoSwitchFrom	= false
end

if CLIENT then
	SWEP.PrintName		= "Hands"
	SWEP.Slot			= 5
	SWEP.SlotPos		= 1
	SWEP.DrawAmmo		= false
	SWEP.DrawCrosshair	= false
end

SWEP.Author			= "SittingBear"
SWEP.Instructions	= "None"
SWEP.Contact		= "N/A"
SWEP.Purpose		= "Appear as though you have no weapons."
SWEP.HoldType		= "normal"
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none" 


function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Precache()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDeploySpeed(self.Weapon:SequenceDuration())

	return true
end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:SetDeploySpeed( speed )
	self.m_WeaponDeploySpeed = tonumber(speed/GetConVarNumber("phys_timescale"))
	
	self.Weapon:SetNextPrimaryFire(CurTime()+speed)
	self.Weapon:SetNextSecondaryFire(CurTime()+speed)
end