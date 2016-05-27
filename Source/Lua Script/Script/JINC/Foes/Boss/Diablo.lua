--[[
**********************************************
  
  Diablo.lua
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
 
version: 16.05.27
]]


-- Version 16.05.27



Data = {
	Name = "Diablo",
	Desc = "It's a bull and his name is Diablo.\nA killer to whoever hurt his cows.\n",
	ImageFile = "Boss/Diablo.png",
	AI = "Default",
	EleRes_Fire = 2,
	EleRes_Wind = 2,
	EleRes_Water = 2,
	EleRes_Earth = 2,
	EleRes_Frost = 2,
	EleRes_Lightning = 2,
	EleRes_Light = 2,
	EleRes_Dark = 2,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 2,
	Stat = {
		["Strength"] = {273,300},
		["Defense"] = {112,120},
		["Will"] = {196,220},
		["Resistance"] = {88,90},
		["Agility"] = {50,60},
		["Accuracy"] = {102,150},
		["Evasion"] = {30,35},
		["HP"] = {10000,10200},
		["AP"] = {0,0},
		["LevelRange"] = {75,80},
},
	StatusResistance = {
		["Poison"] = 100   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 100   --[[ #3 ]],
		["Will"] = 100   --[[ #4 ]],
		["Block"] = 100   --[[ #5 ]],
		["Death"] = 100   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,1000 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 80		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 90		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_LIGHTNINGENCHANT"] = 100		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_LIGHTNINGENCHANT") end
Data.ActMinLevel["Abl.MOO_ALLDOWN"] = 50		for ak=1,90 do table.insert(Data.Acts,"Abl.MOO_ALLDOWN") end
Data.ActMinLevel["Abl.MOO_Z2_STERF"] = 2		for ak=1,100 do table.insert(Data.Acts,"Abl.MOO_Z2_STERF") end


return Data
