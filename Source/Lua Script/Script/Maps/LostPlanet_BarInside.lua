--[[
**********************************************
  
  LostPlanet_BarInside.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 15.10.11
]]


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
	PartyPop("Yirl")
	MapText("YIRL")
	Sys.Crash("The rest is not yet scripted. Be back later!")
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
	if GetActive()=="Wendicka" then
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
