--[[
**********************************************
  
  GiantSnake.lua
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
 
version: 16.06.15
]]


-- Version 16.06.14



Data = {
	Name = "Giant Snake",
	Desc = "Native to Phantasar.\nAnd very very poisonous!",
	ImageFile = "Boss/GiantSnake.png",
	AI = "Default",
	Boss = true,
	Shilders = 1000,
	EleRes_Fire = 2,
	EleRes_Wind = 4,
	EleRes_Water = 5,
	EleRes_Earth = 6,
	EleRes_Frost = 4,
	EleRes_Lightning = 1,
	EleRes_Light = 2,
	EleRes_Dark = 4,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {1000,2000},
		["Defense"] = {0,10},
		["Will"] = {10,20},
		["Resistance"] = {0,5},
		["Agility"] = {80,90},
		["Accuracy"] = {1000,1100},
		["Evasion"] = {60,65},
		["HP"] = {10000,20000},
		["AP"] = {0,0},
		["LevelRange"] = {60,70},
},
	StatusResistance = {
		["Poison"] = 65   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 100   --[[ #3 ]],
		["Will"] = 88   --[[ #4 ]],
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,10 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_PARALYZEFLUID"] = 5		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_FOE_PARALYZEFLUID") end
Data.ActMinLevel["Abl.ABL_FOE_VENOMBITE"] = 20		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_FOE_VENOMBITE") end
Data.ActMinLevel["Abl.ABL_FOE_VIRUSBITE"] = 2		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_FOE_VIRUSBITE") end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=1, VLT=true }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_APPLE', LVL=1, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end


return Data
