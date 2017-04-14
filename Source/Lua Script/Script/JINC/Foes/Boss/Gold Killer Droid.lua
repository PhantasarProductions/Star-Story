--[[
**********************************************
  
  Gold Killer Droid.lua
  (c) Jeroen Broks, 2016, 2017, All Rights Reserved.
  
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
 
version: 17.03.03
]]


-- Version 16.12.24



Data = {
	Name = "Gold Killer Droid",
	Desc = "It has no mother brain functions,\nbut it has some dangerous random\neffects that can turn out as well good\nas bad!",
	ImageFile = "Boss/Gold Killer Droid.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 1,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 1,
	EleRes_Light = 3,
	EleRes_Dark = 5,
	EleRes_Healing = 5,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {0,1000},
		["Defense"] = {0,20},
		["Will"] = {0,1000},
		["Resistance"] = {0,20},
		["Agility"] = {0,50},
		["Accuracy"] = {0,100},
		["Evasion"] = {0,5},
		["HP"] = {1000,20000},
		["AP"] = {0,0},
		["LevelRange"] = {1,250},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_GROUPRANDOMIZER"] = 0		for ak=1,75 do table.insert(Data.Acts,"Abl.ABL_FOE_GROUPRANDOMIZER") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 5		for ak=1,500 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_RANDOMIZER"] = 0		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_FOE_RANDOMIZER") end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=950, VLT=false }
for ak=1,950 do table.insert(Data.ItemDrop ,temp) end
for ak=1,950 do table.insert(Data.ItemSteal,temp) end


return Data
