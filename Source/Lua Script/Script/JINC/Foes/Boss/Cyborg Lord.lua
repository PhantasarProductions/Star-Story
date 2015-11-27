--[[
**********************************************
  
  Cyborg Lord.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 
version: 15.11.27
]]


-- Version 15.11.27



Data = {
	Name = "Cyborg Lord",
	Desc = "A strong cyborg.\n",
	ImageFile = "Boss/Cyborg Lord.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Cold = 5,
	EleRes_Thunder = 5,
	EleRes_Light = 5,
	EleRes_Darkness = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {30,500},
		["Defense"] = {10,80},
		["Will"] = {10,200},
		["Resistance"] = {10,100},
		["Agility"] = {7,80},
		["Accuracy"] = {12,50},
		["Evasion"] = {3,10},
		["HP"] = {50,4000},
		["AP"] = {0,0},
		["LevelRange"] = {1,1234},
},
	StatusResistance = {
		["Poison"] = 55   --[[ #1 ]],
		["Paralysis"] = 65   --[[ #2 ]],
		["Disease"] = 2   --[[ #3 ]],
		["Will"] = 31   --[[ #4 ]],
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


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ARM_DART"] = 250		for ak=1,90 do table.insert(Data.Acts,"Abl.ARM_DART") end
Data.ActMinLevel["Abl.ARM_HEALINGSPRAY"] = 300		for ak=1,40 do table.insert(Data.Acts,"Abl.ARM_HEALINGSPRAY") end
Data.ActMinLevel["Abl.ARM_MULTIBLAST"] = 400		for ak=1,30 do table.insert(Data.Acts,"Abl.ARM_MULTIBLAST") end
Data.ActMinLevel["Abl.ARM_POISONDART"] = 600		for ak=1,20 do table.insert(Data.Acts,"Abl.ARM_POISONDART") end
Data.ActMinLevel["Abl.ARM_VIRUSBOMB"] = 500		for ak=1,25 do table.insert(Data.Acts,"Abl.ARM_VIRUSBOMB") end
temp = { ITM='ITM_EQP_EMERALD', LVL=5000, VLT=true }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=1000, VLT=true }
for ak=1,2000 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=1, VLT=true }
for ak=1,15000 do table.insert(Data.ItemDrop ,temp) end
Data.ActMinLevel["Abl.ITM_FIRSTAIDKIT"] = 600		for ak=1,10 do table.insert(Data.Acts,"Abl.ITM_FIRSTAIDKIT") end


return Data
