--[[
**********************************************
  
  Ysperon - Eugorvnia Caves.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
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
 
version: 16.06.16
]]

-- @USE /Script/Use/Maps/Gen/Next.lua

function Welcome()
	if not Done("&DONE.EUGORVNIA.CAVES.WELCOME") then MapText("WELCOME") end
end


function StartTrans()
	ActivatePad("EUGCAVESTART","General")
end	

function ToCity()
  LoadMap("Ysperon - Eugorvnia","#002")
  Maps.GotoLayer("#002")
  SpawnPlayer("FromSecret")
end

function Boss()
	CleanCombat()
	local lv=math.ceil( MapLevel() * ({.75,1,1.25})[skill] )
	Var.D("$COMBAT.BACKGROUND","Ember Caves.png")
	Var.D("$COMBAT.BEGIN","Default")
	Var.D("$COMBAT.FOE2","Boss/DeathMyrQueen")
	Var.D("%COMBAT.LVFOE2",lv)
	Var.D("$COMBAT.ALTCOORDSFOE2","300,400")
	if skill==3 then
		Var.D("$COMBAT.FOE1","Reg/Spider")
   	Var.D("$COMBAT.FOE3","Reg/Spider")
   	Var.D("%COMBAT.LVFOE1",lv/2)
   	Var.D("%COMBAT.LVFOE3",lv/2)
	end
	RandomBossTune()
	StartCombat()
end


function Complete()
  if not Done("&DONE.SECRETDUNGEON.EUGORVNIA.CAVES") then
    Award('SECRETDUNGEON_EUGCAVES')
    MapEXP()
    Inc("%AURINARATE",50)
  end
end
   

function GALE_OnLoad()
  Music("Dungeon/Motherlode.ogg")
  ZA_Enter("Welcome",Welcome)
  ZA_Enter("ActivateTransporter",StartTrans)
  ZA_Enter("ToCity",ToCity)
  ZA_Enter("Complete",Complete)
end  
