local items = {}

function getItems( name )
	if items[name] then
		return items[name]
	end
	return false
end

items ["soda"] = 	{
					name = "Soda",
					desc = "A nice can of cola",
					ent = "item_basic",
					prices = {
						buy = 5,
						sell = 2.5,
					},
					model = "models/props_junk/PopCan01a.mdl",
					use = (function (ply, ent)
						if ply:IsValid() then
							ply:AddHealth ( 10 )
							if ent then
								ent:Remove()
							end
						end
					end),
					spawn = (function(ply, ent)
						ent:SetItemName("Soda")
					end),
					skin = 1,
					buttonDist = 10,
					}