--[[
**********************************************
  
  PhanUndeadKid_Phelynx.lua
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
	Name = "Undead Phelynx Kid",
	Desc = "Has a fair hand with electricity, \nbut is still as doomed as all other kids\nin the Ghost House",
	ImageFile = "Reg/PhanUndeadKid_Phelynx.png",
	AI = "Default",
	Shilders = 600,
	EleRes_Fire = 2,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 6,
	EleRes_Light = 0,
	EleRes_Dark = 6,
	EleRes_Healing = 1,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {290,294},
		["Defense"] = {72,78},
		["Will"] = {168,190},
		["Resistance"] = {112,118},
		["Agility"] = {103,119},
		["Accuracy"] = {673,685},
		["Evasion"] = {64,100},
		["HP"] = {1145,1174},
		["AP"] = {0,0},
		["LevelRange"] = {72,90},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,50 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 1		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_THRILLINGCHARGE"] = 1		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_FOE_THRILLINGCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_ELECTRICCHARGE"] = 1		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_ELECTRICCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 20		for ak=1,75 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 15		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 25		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=5000, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,500 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.SUPER_THRILLING_DAMNNATION"] = 1		for ak=1,950 do table.insert(Data.Acts,"Abl.SUPER_THRILLING_DAMNNATION") end


return Data
