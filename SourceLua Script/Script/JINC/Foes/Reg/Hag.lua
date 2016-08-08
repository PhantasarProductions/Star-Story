--[[
**********************************************
  
  Hag.lua
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
 
version: 16.08.08
]]


-- Version 16.08.08



Data = {
	Name = "Hag",
	Desc = "Not as human as she looks.\nThis monster is a master with magic.",
	ImageFile = "Reg/Hag.png",
	AI = "Default",
	Shilders = 100,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 5,
	EleRes_Light = 2,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {40,410},
		["Defense"] = {40,112},
		["Will"] = {0,300},
		["Resistance"] = {0,200},
		["Agility"] = {1,110},
		["Accuracy"] = {1,500},
		["Evasion"] = {0,65},
		["HP"] = {90,2500},
		["AP"] = {0,0},
		["LevelRange"] = {10,150},
},
	StatusResistance = {
		["Poison"] = 100   --[[ #1 ]],
		["Paralysis"] = 95   --[[ #2 ]],
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,1 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOU"] = 500		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOU") end
Data.ActMinLevel["Abl.ABL_FOE_DAMNYOUALL"] = 25		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_DAMNYOUALL") end
Data.ActMinLevel["Abl.ABL_FOE_DARKHEAL_HERO"] = 50		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_DARKHEAL_HERO") end
Data.ActMinLevel["Abl.ABL_FOE_DARK_VITALIZE"] = 0		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_FOE_DARK_VITALIZE") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 450		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_DEMON_SOUL_BREAKER"] = 400		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_DEMON_SOUL_BREAKER") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 375		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_FEAR"] = 350		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_FEAR") end
Data.ActMinLevel["Abl.ABL_FOE_GROUPRANDOMIZER"] = 200		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_GROUPRANDOMIZER") end
Data.ActMinLevel["Abl.ABL_FOE_HORROR"] = 225		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_HORROR") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 325		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_INFERNO"] = 300		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_INFERNO") end
Data.ActMinLevel["Abl.ABL_FOE_LIGHTNINGENCHANT"] = 75		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_LIGHTNINGENCHANT") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 175		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 275		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 250		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
temp = { ITM='ITM_PHANTASAR_BANANA', LVL=250, VLT=false }
for ak=1,25 do table.insert(Data.ItemSteal,temp) end


return Data
