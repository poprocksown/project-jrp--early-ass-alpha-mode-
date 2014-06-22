function GM:ShowHelp(pl)
	// F1
	if IsValid(pl) then
		SendUserMessage("information_menu",pl)
	end
end

function GM:ShowTeam(pl)
	self:PlayerDropWeapon(pl)
end

function GM:ShowSpare1(pl)
	// F3
	if IsValid(pl) then
		
	end
end

function GM:ShowSpare2(pl)
	// F4
	if IsValid(pl) then
		
	end
end