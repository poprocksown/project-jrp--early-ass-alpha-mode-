local ply = FindMetaTable("Player")
util.AddNetworkString( "database" )
util.AddNetworkString( "inventory_drop" )
util.AddNetworkString( "inventory_use" )

function ply:ShortSteamID()
	local id = self.SteamID()
	local id = tostring(id)
	local id = string.Replace(id, "STEAM_0:0:", "")
	local id = string.Replace(id, "STEAM_0:1:", "")
	return id
end

local oldPrint = print 
local function print(s)
	oldPrint("databse.lua: " .. s)
end

function ply:databeDefault()
	self:databaseSetValue( "money", 0 )
	self:databaseSetValue("xp", 0)
	self:databaseSetValue("hunger", 0)
	self:databaseSetValue("thirst", 0)
	local i = {}
	i["water1"] = {amount = 5}
	i["snack1"] = {amount = 5}
	self:databaseSetValue("inventory", i)
end

function ply:databaseNetworkData()
	local money = self:databaseGetValue("money")
	local xp = self:databaseGetValue("xp")
	local hunger = self:databaseGetValue("hunger")
	local thirst = self:databaseGetValue("thirst")
	self:setNWInt("money", money)
	self:setNWInt("xp", xp)
	self:setNWInt("hunger", hunger)
	self:setNWInt("thirst", thirst)

	self:KillSilent()
	self:Spawn()
end

function ply:databaseFolders()
	return "server/garrysmod/gamemode/jailrp/gamemode/database" .. self:ShortSteamID() .. "/"
end

function ply:databasePath()
	return self:databaseFolders() .. "database.txt"
end

function ply:databseSet( tab )
	self.database = tab
end

function ply:databaseGet()
	return self.database
end

function ply:databaseCheck()
	self.database = { }
	local f = self:databaseExists()
	if f then
		self:databaseRead()
	else
		self:databaseCreate()
	end
	self:databaseSent()
	self:databaseNetworkData()
end


function ply:databaseSend()
	net.Start( "database" )
		net.WriteTable( self:databaseGet() )
	net.Send( self )
end

function ply:databaseExists()
	local f = file.Exists(self:databasePath(), "DATA")
	return f
end

function ply:databaseRead()
	local str = file.Read(self:databasePath(), "DATA")
	self:databaseSet( util.KeyVaulesToTable(str) )
end

function ply:databaseSave()
	local str = util.TableToKeyValues(self.database)
	local f = file.Write(self:databasePath(), str)
	self:databaseSend()
end

function ply:databaseCreate()
	self:databaseDefault()
	local b = file.CreateDir( self:databaseFolders() )
	self:databaseSave()
end

function ply:databaseDisconnect()
	self:databaseSave()
end

function ply:databaseSetValue( name, v )
	if not v then return end

	if type(v) == "table" then
		if name == "inventory" then
			for k,b in pairs(v) do 
				if b.amount <= 0 then
					v[k] = nil
				end
			end
		end
	end
	local d = self:databaseGet()
	d[name] = v

	self:databaseSave()
end

function ply:databaseGetValue( name )
	local d = self:databaseGet()
	return d[name]
end

function ply:inventorySave(i)
	if not i then return end
	self:databaseSetValue("inventory", i)
end


function ply:inventoryGet()
	local i = self:databaseGetValue("inventory")
	return i
end

function ply:inventoryHasItem(name, amount)
	if not amount then amount = 1 end

	local i = self:inventoryGet()

	if i then
		if i[name] then
			if[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else return false
	end
end


function ply:inventoryTakeItem(name, amount)
	if not amount then amount = 1 end

	local i = self:inventoryGet()

	if self:InventoryHasItem (name, amount) then
		i[name].amount = i[name].amount - amount

		self:InventorySave(i)
		return true
	else
		return false
	end
end

function ply:inventoryGiveItem(name, amount)
	if not amount then amount = 1 end

	local i = self:inventoryGet()

	local item = getItems(name)

	if not item then return end

	if amount == 1 then
		self:PrintMessage( HUD_PRINTTALK, "You recived a" .. item.name)
		elseif amount > 1 then
			self:PrintMessage( HUD_PRINTTAL, "You recived a" .. amount .. " " .. item name .. "s!" )
		end

	if self:inventoryHasItem(name, amount) then
		i[name].amount = i[name].amount + amount
	else
		i[name] = ( amount = amount )
	end

	self:inventorySave()
end

net.Recieve("inventory_drop", function (len, ply)
	local name = net.Readstring()
	if ply:inventoryHasItem(name , 1 ) then
		ply:inventoryTakeItem(name, 1 )
		CreateItem(ply, name, itemSpawnPos( ply ) ) 
	end
end)

net.Recive("inventory_use", function(len, ply )
	local name = net.ReadString()

	local item = getItems( name )

	if item then
		if ply:inventoryHasItem( name, 1 ) then
			ply:inventoryTakeItem( name, 1 )
			item.use (ply)
		end
	end
end)