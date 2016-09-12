--[[
**********************************************
  
  DardBoorth.lua
  (c) Jeroen Broks, 2015, 2016, All Rights Reserved.
  
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
 
version: 16.09.12
]]


-- Version 16.09.11



Data = {
	Name = "Dard Boorth",
	Desc = "Cid Lord of the Black Castle.\nWants to dominate the entire universe.",
	ImageFile = "Boss/DardBoorth.png",
	AI = "Default",
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 6,
	EleRes_Light = 1,
	EleRes_Dark = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {36,415},
		["Defense"] = {0,112},
		["Will"] = {25,210},
		["Resistance"] = {50,300},
		["Agility"] = {0,116},
		["Accuracy"] = {100,1000},
		["Evasion"] = {20,25},
		["HP"] = {50,25000},
		["AP"] = {1000,2000},
		["LevelRange"] = {1,85},
},
	StatusResistance = {
		["Poison"] = 99   --[[ #1 ]],
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


Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 75		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 10		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_WATERBEAM"] = 5		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_WATERBEAM") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 26		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 1		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 25		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
Data.ActMinLevel["Abl.ABL_XENOBI_HEAL"] = 25		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HEAL") end
Data.ActMinLevel["Abl.ABL_XENOBI_HURRICANE"] = 25		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HURRICANE") end
Data.ActMinLevel["Abl.ABL_XENOBI_MINDTRICK"] = 25		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_MINDTRICK") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUAKE"] = 25		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUAKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUICKSTRIKE"] = 10		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUICKSTRIKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_RECOVER"] = 25		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_XENOBI_RECOVER") end
Data.ActMinLevel["Abl.ABL_XENOBI_VITALIZE"] = 65		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_XENOBI_VITALIZE") end
temp = { ITM='ITM_EQP_EMERALD', LVL=70, VLT=true }
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=1, VLT=true }
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=60, VLT=true }
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=65, VLT=true }
for ak=1,65 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=1, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=1000, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1000 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ZZZ_CID_DARKCHARGE"] = 45		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKCHARGE") end
Data.ActMinLevel["Abl.ZZZ_CID_DARKNESS"] = 30		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKNESS") end
Data.ActMinLevel["Abl.ZZZ_CID_LORD_SUMMON"] = 35		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CID_LORD_SUMMON") end


return Data
