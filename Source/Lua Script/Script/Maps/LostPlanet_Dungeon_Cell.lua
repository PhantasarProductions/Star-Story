--[[
**********************************************
  
  LostPlanet_Dungeon_Cell.lua
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
 
version: 15.11.30
]]



function CLICK_ARRIVAL_Tralies()
	if GetActive()=="Foxy" then
		Maps.Obj.Obj("Tralies").Y=1200
		Maps.PermaWrite('Maps.Obj.Obj("Tralies").Y=1200')
		Maps.Remap()
		RPGChar.Points("Foxy","EXP").Inc(600/skill)
	else
		CharMapText("TRALIES")
		MapText("TRALIES.TUTORIAL")
	end
end

function NextFloor()
  if not(ActivatedPads[upper(Maps.CodeName..".CellBlockLoveWithYou")]) then
     MINI("Perhaps you can better activate the transporter pad here first!!!",255,0,0)
     CSay(serialize("ActivatedPads",ActivatedPads))
     return 
     end
	LoadMap("LostPlanet_Dungeon","#001")
	CSay("We are on layer: "..Maps.CheckLayer())
	CSay("We got the next tags!")
	for k in each(mysplit(Maps.TagMap(),";")) do CSay(" = "..k) end 
	SpawnPlayer("Start")
	end


function GALE_OnLoad()
	SetScrollBoundaries(-32,0,-32,0)
	Music("Dungeon/Prisoner Of War.ogg")
	AddClickable("Tralies")
	ZA_Enter("Next",NextFloor)
end
