--[[
**********************************************
  
  PhanUndeadKid_Human.lua
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
	Name = "Undead human kid",
	Desc = "Poor boy! Bound to be restless forever",
	ImageFile = "Reg/PhanUndeadKid_Human.png",
	AI = "Default",
	Shilders = 300,
	EleRes_Fire = 2,
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
		["Strength"] = {363,364},
		["Defense"] = {137,140},
		["Will"] = {223,228},
		["Resistance"] = {122,124},
		["Agility"] = {54,58},
		["Accuracy"] = {33,38},
		["Evasion"] = {15,21},
		["HP"] = {2712,2724},
		["AP"] = {0,0},
		["LevelRange"] = {75,76},
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
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 60		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 75		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_THRILLINGCHARGE"] = 80		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOE_THRILLINGCHARGE") end
temp = { ITM='ITM_PHANTASAR_CARROT', LVL=80, VLT=false }
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=500, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,500 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_TRAVEL', LVL=90, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.SUPER_THRILLING_DAMNNATION"] = 800		for ak=1,1 do table.insert(Data.Acts,"Abl.SUPER_THRILLING_DAMNNATION") end


return Data
