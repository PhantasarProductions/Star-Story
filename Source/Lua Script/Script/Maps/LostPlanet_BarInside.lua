

function Astrilopups()
	if GetActive()=="Wendicka" then
		MapText("ASTRILO_WENDICKA")
	else
		MapText("ASTRILO_OWN")
		CharMapText("ASTRILO_NOTUNDERSTAND")
	end	
end

NPC_Astrilopup1 = Astrilopups
NPC_Astrilopup2 = Astrilopups



function GALE_OnLoad()
	Music("Location_Pub_Jungle/1 - TDCi - Don't Talk Too Much.ogg")
	SetScrollBoundaries(0,0,0,0)
end
