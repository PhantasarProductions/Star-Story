--[[
**********************************************
  
  Mid-Boss.lua
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
 
version: 16.02.14
]]


-- Version 16.02.14



Data = {
	Name = "Mid-Boss",
	Desc = "An idiot who owns a mansion on Poloqor.\nHe thinks he's wonderful, but he's been branded only a \"Mid-Boss\" by Wendicka.\nSince we don't know what his real name is, let's just stick with that name then. Right?",
	ImageFile = "Boss/Mid-Boss.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 3,
	EleRes_Light = 2,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {14,455},
		["Defense"] = {10,175},
		["Will"] = {10,300},
		["Resistance"] = {10,140},
		["Agility"] = {6,75},
		["Accuracy"] = {10,50},
		["Evasion"] = {0,15},
		["HP"] = {100,6000},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
},
	StatusResistance = {
		["Poison"] = 26   --[[ #1 ]],
		["Paralysis"] = 23   --[[ #2 ]],
		["Disease"] = 4   --[[ #3 ]],
		["Will"] = 99   --[[ #4 ]],
		["Block"] = 27   --[[ #5 ]],
		["Death"] = 100   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 1		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 60		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 50		for ak=1,7 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 65		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_TASER"] = 2		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_FOE_TASER") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 100		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 80		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=2, VLT=false }
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ICEBOMB', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
Data.ActMinLevel["Abl.ITM_MEDIKIT"] = 10		for ak=1,7 do table.insert(Data.Acts,"Abl.ITM_MEDIKIT") end


return Data
