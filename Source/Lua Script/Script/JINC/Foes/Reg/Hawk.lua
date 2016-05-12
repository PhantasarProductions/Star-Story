--[[
**********************************************
  
  Hawk.lua
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


-- Version 16.05.12



Data = {
	Name = "Hawk",
	Desc = "A bird native to Phantasar, and very extremely dangerous",
	ImageFile = "Reg/Hawk.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 2,
	EleRes_Water = 3,
	EleRes_Earth = 1,
	EleRes_Frost = 3,
	EleRes_Lightning = 5,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {750,1000},
		["Defense"] = {0,50},
		["Will"] = {0,100},
		["Resistance"] = {0,100},
		["Agility"] = {80,90},
		["Accuracy"] = {10000,10000},
		["Evasion"] = {1,5},
		["HP"] = {200,500},
		["AP"] = {0,0},
		["LevelRange"] = {65,70},
},
	StatusResistance = {
		["Poison"] = 30   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 50   --[[ #3 ]],
		["Will"] = 100   --[[ #4 ]],
		["Block"] = 100   --[[ #5 ]],
		["Death"] = 40   --[[ #6 ]],
		["Damned"] = 10   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_PARA_DIVE"] = 65		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_PARA_DIVE") end


return Data
