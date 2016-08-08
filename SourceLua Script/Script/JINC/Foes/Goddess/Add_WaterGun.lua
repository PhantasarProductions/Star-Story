--[[
**********************************************
  
  Add_WaterGun.lua
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
 
version: 16.08.01
]]


-- Version 16.08.01



Data = {
	Name = "Water Gun",
	Desc = "...",
	ImageFile = "Goddess/Add_WaterGun.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 6,
	EleRes_Earth = 3,
	EleRes_Frost = 5,
	EleRes_Lightning = 5,
	EleRes_Light = 5,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {0,0},
		["Defense"] = {0,0},
		["Will"] = {0,0},
		["Resistance"] = {0,0},
		["Agility"] = {0,0},
		["Accuracy"] = {0,0},
		["Evasion"] = {0,0},
		["HP"] = {0,0},
		["AP"] = {0,0},
		["LevelRange"] = {0,0},
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


Data.ActMinLevel["Abl.ZZZZ_ADD_WATERGUN"] = 0		for ak=1,1000 do table.insert(Data.Acts,"Abl.ZZZZ_ADD_WATERGUN") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_ASTRILOPUP"] = 8000		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_ASTRILOPUP") end


return Data
