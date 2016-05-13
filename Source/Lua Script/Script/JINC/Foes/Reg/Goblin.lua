--[[
**********************************************
  
  Goblin.lua
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
 
version: 16.05.13
]]


-- Version 16.05.13



Data = {
	Name = "Goblin",
	Desc = "Dumb creatures who roam the forests and some old ruins of Phantasar. \nTheir intelligence always goes like \"Me king, you dead!\"",
	ImageFile = "Reg/Goblin.png",
	AI = "Default",
	Shilders = 100,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Light = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {314,500},
		["Defense"] = {61,70},
		["Will"] = {1,20},
		["Resistance"] = {61,62},
		["Agility"] = {60,70},
		["Accuracy"] = {67,70},
		["Evasion"] = {1,2},
		["HP"] = {2422,5000},
		["AP"] = {0,0},
		["LevelRange"] = {50,100},
},
	StatusResistance = {
		["Poison"] = 0   --[[ #1 ]],
		["Paralysis"] = 0   --[[ #2 ]],
		["Disease"] = 0   --[[ #3 ]],
		["Will"] = 0   --[[ #4 ]],
		["Block"] = 0   --[[ #5 ]],
		["Death"] = 0   --[[ #6 ]],
		["Damned"] = 0   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 500		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_YIRL_INTIMIDATE"] = 60		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_YIRL_INTIMIDATE") end
temp = { ITM='ITM_EQP_GARNET', LVL=70, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_APPLE', LVL=1, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDUST', LVL=1, VLT=false }
for ak=1,200 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_ROCK', LVL=1, VLT=false }
for ak=1,1300 do table.insert(Data.ItemDrop ,temp) end


return Data
