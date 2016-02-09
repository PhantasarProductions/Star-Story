--[[
**********************************************
  
  Pyroguin.lua
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
 
version: 16.02.09
]]


-- Version 16.02.09



Data = {
	Name = "Pyroguin",
	Desc = "This bird is on fire",
	ImageFile = "Reg/Pyroguin.png",
	AI = "Default",
	EleRes_Fire = 6,
	EleRes_Wind = 4,
	EleRes_Water = 2,
	EleRes_Earth = 5,
	EleRes_Frost = 1,
	EleRes_Lightning = 2,
	EleRes_Light = 2,
	EleRes_Dark = 4,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {147,416},
		["Defense"] = {0,0},
		["Will"] = {10,35},
		["Resistance"] = {147,416},
		["Agility"] = {50,100},
		["Accuracy"] = {50,200},
		["Evasion"] = {1,1},
		["HP"] = {50,100},
		["AP"] = {0,0},
		["LevelRange"] = {45,60},
},
	StatusResistance = {
		["Poison"] = 80   --[[ #1 ]],
		["Paralysis"] = 0   --[[ #2 ]],
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


Data.ActMinLevel["Abl.ABL_XENOBI_VITALIZE"] = 25		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_XENOBI_VITALIZE") end
Data.ActMinLevel["Abl.ARM_FLAMETHROWER"] = 100		for ak=1,1 do table.insert(Data.Acts,"Abl.ARM_FLAMETHROWER") end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=10, VLT=false }
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=50, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,400 do table.insert(Data.ItemSteal,temp) end


return Data
