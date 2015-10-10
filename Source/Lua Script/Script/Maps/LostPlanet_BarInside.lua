

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

function NPC_Yirl()
	if not CVV("&DONE.STORK") then
		MapText("YIRL_NOGO")
		return
	end
end

function ByeBye()
	LoadMap("LostPlanet_Pub_Outside")
	SpawnPlayer("SPOT_EnterPub")
	TurnPlayer("South")
end

function NPC_Stork()
	if Done("&DONE.STORK") then
		MapText("STORK_AGAIN")
	else
		PartyPop("Stork")
		MapText("STORK")
		PartyUnPop()
	end
end

function NPC_Bladeh()
	if GetActive("Wendicka") then
		MapText("ALIEN_WENDICKA")
	else
		MapText("ALIEN")
	end
end



function GALE_OnLoad()
	Music("Location_Pub_Jungle/1 - TDCi - Don't Talk Too Much.ogg")
	SetScrollBoundaries(0,0,0,0)
	ZA_Enter("Exit",ByeBye)	
end
