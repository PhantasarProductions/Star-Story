--[[
**********************************************
  
  LichKing.lua
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
 
version: 16.07.16
]]


-- Version 16.07.16



Data = {
	Name = "Lich King",
	Desc = "Controller of evil.\nThere must always be \na Lich King.",
	ImageFile = "Boss/LichKing.png",
	AI = "Default",
	Boss = true,
	Shilders = 2500,
	EleRes_Fire = 2,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 1,
	EleRes_Light = 1,
	EleRes_Dark = 6,
	EleRes_Healing = 1,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {600,700},
		["Defense"] = {0,100},
		["Will"] = {600,700},
		["Resistance"] = {0,150},
		["Agility"] = {90,180},
		["Accuracy"] = {1000,2000},
		["Evasion"] = {0,0},
		["HP"] = {25000,50000},
		["AP"] = {0,0},
		["LevelRange"] = {100,200},
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
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOU"] = 0		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOU") end
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOUALL"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOUALL") end
Data.ActMinLevel["Abl.ABL_FOE_DARKHEAL_FOE"] = 0		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_DARKHEAL_FOE") end
Data.ActMinLevel["Abl.ABL_FOE_DARKHEAL_HERO"] = 0		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_DARKHEAL_HERO") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 0		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_DEMON_SOUL_BREAKER"] = 0		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_DEMON_SOUL_BREAKER") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_FOE_WATERBEAM"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_WATERBEAM") end
Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_CHEER"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_CHEER") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
Data.ActMinLevel["Abl.ABL_XENOBI_BREEZE"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BREEZE") end
Data.ActMinLevel["Abl.ABL_XENOBI_FROST"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_FROST") end
Data.ActMinLevel["Abl.ABL_XENOBI_HURRICANE"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HURRICANE") end
Data.ActMinLevel["Abl.ABL_XENOBI_MINDTRICK"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_MINDTRICK") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUAKE"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUAKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUICKSTRIKE"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUICKSTRIKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_ROCK"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_XENOBI_ROCK") end
Data.ActMinLevel["Abl.ABL_YIRL_CONFUSION"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_YIRL_CONFUSION") end
Data.ActMinLevel["Abl.ABL_YIRL_INTIMIDATE"] = 10		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_YIRL_INTIMIDATE") end
Data.ActMinLevel["Abl.ITM_BIOHAZARD"] = 0		for ak=1,2 do table.insert(Data.Acts,"Abl.ITM_BIOHAZARD") end
Data.ActMinLevel["Abl.ZZZ_LK_SUM_BEFINDO"] = 0		for ak=1,20 do table.insert(Data.Acts,"Abl.ZZZ_LK_SUM_BEFINDO") end
Data.ActMinLevel["Abl.ZZZ_LK_SUM_ELF"] = 0		for ak=1,20 do table.insert(Data.Acts,"Abl.ZZZ_LK_SUM_ELF") end
Data.ActMinLevel["Abl.ZZZ_LK_SUM_FAIRY"] = 0		for ak=1,20 do table.insert(Data.Acts,"Abl.ZZZ_LK_SUM_FAIRY") end
Data.ActMinLevel["Abl.ZZZ_LK_SUM_HUMAN"] = 0		for ak=1,20 do table.insert(Data.Acts,"Abl.ZZZ_LK_SUM_HUMAN") end
Data.ActMinLevel["Abl.ZZZ_LK_SUM_PHELYNX"] = 0		for ak=1,5 do table.insert(Data.Acts,"Abl.ZZZ_LK_SUM_PHELYNX") end


return Data
