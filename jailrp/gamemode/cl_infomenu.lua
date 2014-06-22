function DrawInfoPanel()
	local BODY = vgui.Create("DFrame")
	local PANEL = vgui.Create("DPanel",BODY)
	local TABS = vgui.Create("DPropertySheet",PANEL)
	local TABSPANELGENERAL = vgui.Create("DPanelList",TABS)
	local TABSPANELGENERALCONTENT = vgui.Create("DPanel",TABSPANELGENERAL)
	local TABSPANELRULES = vgui.Create("DPanelList",TABS)
	local TABSPANELRULESCONTENT = vgui.Create("DPanel",TABSPANELRULES)
	local TABSPANELDONATE = vgui.Create("DPanelList",TABS)
	local TABSPANELDONATECONTENT = vgui.Create("DPanel",TABSPANELDONATE)
	
	
	BODY:SetSize(768,512)
	BODY:SetTitle("JailRP Information")
	BODY:SetVisible(true)
	BODY:SetDraggable(false)
	BODY:ShowCloseButton(true)
	BODY:SetBackgroundBlur(true)
	BODY:Center()
	BODY:MakePopup()
	
	PANEL:SetSize(BODY:GetWide()-10,BODY:GetTall()-33)
	PANEL:SetPos(5,28)
	PANEL.Paint = function()
		draw.RoundedBox(4,0,0,PANEL:GetWide(),PANEL:GetTall(),Color(75,75,75,255))
	end
	
	TABS:SetSize(PANEL:GetWide()-10,PANEL:GetTall()-10)
	TABS:SetPos(5,5)
	
	TABSPANELGENERAL:SetPos(5,5)
	TABSPANELGENERAL:SetSize(TABS:GetWide()-15,TABS:GetTall()-36)
	TABSPANELGENERAL.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELGENERAL:GetWide(),TABSPANELGENERAL:GetTall(),Color(50,50,50,255))
	end
	
	local GENERALTAB = TABS:AddSheet("General",TABSPANELGENERAL,"gui/info",false,false,"Information about the JailRP gamemode!")
	
	TABSPANELGENERALCONTENT:SetPos(5,5)
	TABSPANELGENERALCONTENT:SetSize(TABSPANELGENERAL:GetWide()-10,TABSPANELGENERAL:GetTall()-10)
	TABSPANELGENERALCONTENT.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELGENERALCONTENT:GetWide(),TABSPANELGENERALCONTENT:GetTall(),Color(90,90,90,255))
		
		draw.RoundedBox(4,5,5,TABSPANELGENERALCONTENT:GetWide()-10,80,Color(50,50,50,255))
		
		surface.SetDrawColor(50,50,50,255)
		surface.DrawLine(5,250,TABSPANELGENERALCONTENT:GetWide()-5,250)
		
		surface.SetFont("DermaDefault")
		
		surface.SetTextColor(255,255,255,255)
		surface.SetTextPos(15,100)
		surface.DrawText("Server Rules:")
		
		surface.SetTextColor(0,200,130,255)
		surface.SetTextPos(15,265)
		surface.DrawText("Gamemode Information:")
		
		surface.SetTextColor(200,200,200,255)
		
		surface.SetTextPos(25,120)
		surface.DrawText("1. Don't be ugly, mean or generally unpleasant toward or around your significant other(s).")
		
		surface.SetTextPos(25,140)
		surface.DrawText("2. Don't ask for Administrative or VIP priveleges; this may result in a kick or ban if not a cease and desist warning.")
		
		surface.SetTextPos(25,160)
		surface.DrawText("3. Don't spam any of the available chatting mediums with any content that may be considered one of the following:")
		
			surface.SetTextPos(45,175)
			surface.DrawText("- Obnoxious, irritating, annoying or disruptive.")
			
			surface.SetTextPos(45,190)
			surface.DrawText("- Advertisement or harmful content directed towards the server and/or the players.")
			
			surface.SetTextPos(45,205)
			surface.DrawText("- Queries concerning the obtaining of objects or priveleges (i.e. Admin or VIP, Teleportation, Weapons, etc.)")
			
		surface.SetTextPos(25,225)
		surface.DrawText("4. Don't exploit in any way, shape or form; ScriptEnforcer is enabled and you will be permanently banned.")
		
		surface.SetTextPos(45,285)
		surface.DrawText("JailRP is a new gamemode, currently still in development (alpha), made by SittingBear. This gamemode aims to reproduce the exciting")
		surface.SetTextPos(25,300)
		surface.DrawText("GJail / JailLife gamemode(s) with more improvements and player abilities. JailRP attempts to be more serious in the roleplay aspect compared")
		surface.SetTextPos(25,315)
		surface.DrawText("to the above gamemodes by adding more gameplay elements that appeal to players looking for a immersive roleplay experience and to players")
		surface.SetTextPos(25,330)
		surface.DrawText("who do not necessarily roleplay. Overall, JailRP strives to be a gamemode in which everybody can find enjoyment and become immersed into")
		surface.SetTextPos(25,345)
		surface.DrawText("the gameplay. Every now and then players, who get a kick out of stomping on everybody else, will enter the gamemode and attempt to ruin")
		surface.SetTextPos(25,360)
		surface.DrawText("everybody else's experience, but there are strict conditions put into place to prevent such things from happening to the best of its abilities.")
		
		surface.SetTextPos(25,395)
		surface.DrawText("We also have a Steam Community Group at:")
		
		surface.SetTextColor(0,170,255,255)
		surface.SetTextPos(250,395)
		surface.DrawText("http://steamcommunity.com/groups/jailrp/")
	end
	
	TABSPANELRULES:SetPos(5,5)
	TABSPANELRULES:SetSize(TABS:GetWide()-15,TABS:GetTall()-36)
	TABSPANELRULES.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELRULES:GetWide(),TABSPANELRULES:GetTall(),Color(50,50,50,255))
	end
	
	local RULESTAB = TABS:AddSheet("Rules",TABSPANELRULES,"gui/info",false,false,"Rules for the JailRP gamemode!")
	
	TABSPANELRULESCONTENT:SetPos(5,5)
	TABSPANELRULESCONTENT:SetSize(TABSPANELRULES:GetWide()-10,TABSPANELRULES:GetTall()-10)
	TABSPANELRULESCONTENT.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELRULESCONTENT:GetWide(),TABSPANELRULESCONTENT:GetTall(),Color(90,90,90,255))
		
		draw.RoundedBox(4,5,5,205,205,Color(50,50,50,255))
		surface.SetDrawColor(50,50,50,255)
		surface.DrawLine(5,215,TABSPANELRULESCONTENT:GetWide()-5,215)
		draw.RoundedBox(4,5,221,205,205,Color(50,50,50,255))
		
		surface.SetFont("DermaDefault")
		
		surface.SetTextColor(0,130,220,255)
		surface.SetTextPos(220,10)
		surface.DrawText("Guards:")
		
		surface.SetTextColor(220,130,0,255)
		surface.SetTextPos(220,230)
		surface.DrawText("Prisoners:")
		
		surface.SetTextColor(200,200,200,255)
		
		surface.SetTextPos(230,30)
		surface.DrawText("1. Do not kill or harm Prisoners unless they exhibit one of the following:")
			
			surface.SetTextPos(250,45)
			surface.DrawText("- Attempting to kill a Guard.")
			
			surface.SetTextPos(250,60)
			surface.DrawText("- Attempting to escape or disobeying a direct order.")
			
			surface.SetTextPos(250,75)
			surface.DrawText("- Behaving irrationally after at-least 2 warnings to cease and desist.")
			
		surface.SetTextPos(230,95)
		surface.DrawText("2. Do not order a Prisoner to do any of the following:")
			
			surface.SetTextPos(250,110)
			surface.DrawText("- Inflict harm upon themself or others in any possible way.")
			
			surface.SetTextPos(250,125)
			surface.DrawText("- Perform irrational or non-sensical actions for any given period of time.")
			
		surface.SetTextPos(230,145)
		surface.DrawText("3. The last living Prisoner is granted a 'Last Request', unless Rule #1 applies.")
			
			surface.SetTextPos(250,160)
			surface.DrawText("- 'Last Request' allows the Prisoner one request for anything which must be Roleplay based.")
			
		surface.SetTextPos(230,180)
		surface.DrawText("4. Orders should be given through in-game voice chat unless no Guard has this ability.")
		
		surface.SetTextPos(230,250)
		surface.DrawText("1. Obey orders from Guards unless it exhibits one of the following:")
			
			surface.SetTextPos(250,265)
			surface.DrawText("- Order involves inflicting harm upon yourself or others.")
			
			surface.SetTextPos(250,280)
			surface.DrawText("- Order involves performing an irrational or non-sensical action for a set period of time.")
			
		surface.SetTextPos(230,300)
		surface.DrawText("2. Do not intentionally disrupt the game by performing irrational or irritating actions.")
		
		surface.SetTextPos(230,320)
		surface.DrawText("3. If you are the last living Prisoner you are granted a 'Last Request' which may involve:")
			
			surface.SetTextPos(250,335)
			surface.DrawText("- Requesting a Guard or Guards to perform an action or sequence of actions.")
			
			surface.SetTextPos(250,350)
			surface.DrawText("- Requesting to be killed or harmed in a specific manner.")
			
		surface.SetTextPos(230,370)
		surface.DrawText("4. The last living Guard is entitled as 'Last Guard' and is free of any previous rules or restrictions.")
	end
	
	TABSPANELDONATE:SetPos(5,5)
	TABSPANELDONATE:SetSize(TABS:GetWide()-15,TABS:GetTall()-36)
	TABSPANELDONATE.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELDONATE:GetWide(),TABSPANELDONATE:GetTall(),Color(50,50,50,255))
	end
	
	local DONATETAB = TABS:AddSheet("Donation",TABSPANELDONATE,"gui/info",false,false,"Donating to the JailRP developers and VIP status!")
	
	TABSPANELDONATECONTENT:SetPos(5,5)
	TABSPANELDONATECONTENT:SetSize(TABSPANELDONATE:GetWide()-10,TABSPANELDONATE:GetTall()-10)
	TABSPANELDONATECONTENT.Paint = function()
		draw.RoundedBox(4,0,0,TABSPANELDONATECONTENT:GetWide(),TABSPANELDONATECONTENT:GetTall(),Color(90,90,90,255))
		
		draw.RoundedBox(4,5,5,TABSPANELDONATECONTENT:GetWide()-10,80,Color(50,50,50,255))
		
		surface.SetTextColor(200,200,200,255)
		surface.SetTextPos(10,95)
		surface.DrawText("Currently under construction, check back later.")
	end
	
	TABS:SetActiveTab(RULESTAB.Tab)
end
usermessage.Hook("information_menu",DrawInfoPanel)