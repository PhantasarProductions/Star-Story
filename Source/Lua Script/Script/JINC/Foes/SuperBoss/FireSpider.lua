--[[
**********************************************
  
  FireSpider.lua
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
 
version: 16.07.24
]]


-- Version 16.07.24



Data = {
	Name = "Fire Spider",
	Desc = "An enormous spider. One of the strongest mortal beings in existence.\nIt takes pure luck to get one of these.",
	ImageFile = "SuperBoss/FireSpider.png",
	AI = "FireSpider",
	Boss = true,
	EleRes_Fire = 6,
	EleRes_Wind = 6,
	EleRes_Water = 6,
	EleRes_Earth = 6,
	EleRes_Lightning = 1,
	EleRes_Light = 6,
	EleRes_Dark = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {50,50},
		["Defense"] = {1000000000,1000000000},
		["Will"] = {50,50},
		["Resistance"] = {1000000000,1000000000},
		["Agility"] = {5,5},
		["Accuracy"] = {5,5},
		["Evasion"] = {5,5},
		["HP"] = {5,5},
		["AP"] = {5,5},
		["LevelRange"] = {5,50},
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
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_FOE_LICKYOURWOUNDS"] = 0		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOE_LICKYOURWOUNDS") end
Data.ActMinLevel["Abl.ABL_FOE_PARALYZEFLUID"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_PARALYZEFLUID") end
Data.ActMinLevel["Abl.ABL_FOE_POISONCLOUD"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_POISONCLOUD") end
Data.ActMinLevel["Abl.ABL_FOE_SCRATCH"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_SCRATCH") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_FOE_VENOMBITE"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_VENOMBITE") end
Data.ActMinLevel["Abl.ABL_FOE_VIRUSBITE"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_VIRUSBITE") end
Data.ActMinLevel["Abl.ABL_FOE_WATERBEAM"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_WATERBEAM") end
Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_YIRL_INTIMIDATE"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_YIRL_INTIMIDATE") end
Data.ActMinLevel["Abl.ITM_ICEBOMB"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ICEBOMB") end


return Data
