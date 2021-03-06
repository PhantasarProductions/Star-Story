--[[
**********************************************
  
  PhanUndeadKid_Fairy.lua
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
 
version: 16.09.12
]]


-- Version 16.09.11



Data = {
	Name = "Undead Fairy Kid",
	Desc = "A poor kid in damnation.\nHer magic is still dangerous though",
	ImageFile = "Reg/PhanUndeadKid_Fairy.png",
	AI = "Default",
	Shilders = 250,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 1,
	EleRes_Light = 0,
	EleRes_Dark = 6,
	EleRes_Healing = 0,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {318,321},
		["Defense"] = {86,90},
		["Will"] = {232,300},
		["Resistance"] = {158,185},
		["Agility"] = {85,94},
		["Accuracy"] = {401,407},
		["Evasion"] = {55,63},
		["HP"] = {1909,1934},
		["AP"] = {0,0},
		["LevelRange"] = {76,100},
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
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOU"] = 10		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOU") end
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOUALL"] = 20		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOUALL") end
Data.ActMinLevel["Abl.ABL_FOE_DARKHEAL_FOE"] = 50		for ak=1,30 do table.insert(Data.Acts,"Abl.ABL_FOE_DARKHEAL_FOE") end
Data.ActMinLevel["Abl.ABL_FOE_DARKHEAL_HERO"] = 5		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_FOE_DARKHEAL_HERO") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 10		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_DEMON_SOUL_BREAKER"] = 2		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_FOE_DEMON_SOUL_BREAKER") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 1		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 5		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_LIGHTNINGENCHANT"] = 10		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_FOE_LIGHTNINGENCHANT") end
Data.ActMinLevel["Abl.ABL_FOE_THRILLINGCHARGE"] = 5		for ak=1,78 do table.insert(Data.Acts,"Abl.ABL_FOE_THRILLINGCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_ELECTRICCHARGE"] = 1		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_ELECTRICCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 8		for ak=1,75 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 2		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 10		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 6		for ak=1,75 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
Data.ActMinLevel["Abl.ABL_XENOBI_BREEZE"] = 10		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BREEZE") end
Data.ActMinLevel["Abl.ABL_XENOBI_FROST"] = 10		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_XENOBI_FROST") end
Data.ActMinLevel["Abl.ABL_XENOBI_HURRICANE"] = 10		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HURRICANE") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUAKE"] = 10		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUAKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_ROCK"] = 10		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_XENOBI_ROCK") end
Data.ActMinLevel["Abl.ABL_YIRL_CONFUSION"] = 10		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_YIRL_CONFUSION") end
temp = { ITM='ITM_PHANTASAR_APPLE', LVL=10, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=5000, VLT=false }
for ak=1,2000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10000 do table.insert(Data.ItemSteal,temp) end


return Data
