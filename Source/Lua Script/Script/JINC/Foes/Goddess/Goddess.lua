--[[
**********************************************
  
  Goddess.lua
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
	Name = "The Goddess",
	Desc = "Self-Proclaimed Goddess.\nThis electrica lived inside Wendicka's body\nfor 25 years and is now back with a \nvengeance.",
	ImageFile = "Goddess/Goddess.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 6,
	EleRes_Light = 5,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {1,2},
		["Defense"] = {3,4},
		["Will"] = {5,6},
		["Resistance"] = {7,8},
		["Agility"] = {9,10},
		["Accuracy"] = {11,12},
		["Evasion"] = {13,14},
		["HP"] = {15,16},
		["AP"] = {0,0},
		["LevelRange"] = {17,18},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,10 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 120		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_WENDICKA_ELECTRICCHARGE"] = 200		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_ELECTRICCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 100		for ak=1,45 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 150		for ak=1,30 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 80		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
Data.ActMinLevel["Abl.ZZZZ_GODDESS_ELECTRICHEALING"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZZ_GODDESS_ELECTRICHEALING") end
Data.ActMinLevel["Abl.ZZZZ_GODDESS_VOID"] = 10		for ak=1,25 do table.insert(Data.Acts,"Abl.ZZZZ_GODDESS_VOID") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_ASTRILOPUP"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_ASTRILOPUP") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_CAPT"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_CAPT") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_GUNNER"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_GUNNER") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_JI"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_JI") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_MEDIC"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_MEDIC") end


return Data
