--[[
**********************************************
  
  Phantasar - Frendor Bushes.lua
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
 
version: 16.05.13
]]

-- @USE Phantasar.lua


function Boss()
	oripos = nil
	for i=1,3 do Maps.Obj.Kill("NPC_GREEN_"..i) end -- Prevent savespot abuse. If you want to do this boss again, you must redo the ENTIRE dungeon!!!
	Maps.Remap() -- Of course the savespot removal leads to a new blockmap setup.
	CleanCombat()
	Var.D("$COMBAT.BACKGROUND","Bos - Spar.png")
	Var.D("$COMBAT.BEGIN","Default")
	Var.D("$COMBAT.FOE1","Boss/GiantSnake")
	Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
	Var.D("%COMBAT.LVFOE1",RPGStat.Stat("Wendicka","Level"))
	Var.D("$COMBAT.MUSIC","AltCombat/Phantasar_Boss.ogg")
	StartCombat()	
end

function GALE_OnLoad()
	Music('Dungeon/Pippin the Hunchback')
	AddEnemy("Hawk",10)
	AddEnemy("Goblin",20)
	EncounterBack = "Bos - Spar"
	NPC_GREEN_1 = savespot.green
	NPC_GREEN_2 = savespot.green
	NPC_GREEN_3 = savespot.green
	NPC_RED_1   = savespot.red
end	
