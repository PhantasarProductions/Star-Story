--[[
**********************************************
  
  Thief Chief.lua
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
 
version: 16.07.30
]]


-- Version 16.07.30



Data = {
	Name = "Thief Chief",
	Desc = "This girl made herself a carreer \nof fighting and killing people,\nin order to get their stuff.\n\nAnd she governs all other girls\nwith the same carreer",
	ImageFile = "Boss/Thief Chief.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 2,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {203,220},
		["Defense"] = {57,60},
		["Will"] = {129,140},
		["Resistance"] = {91,100},
		["Agility"] = {85,95},
		["Accuracy"] = {551,600},
		["Evasion"] = {55,65},
		["HP"] = {5148,7000},
		["AP"] = {0,0},
		["LevelRange"] = {57,60},
},
	StatusResistance = {
		["Poison"] = 8   --[[ #1 ]],
		["Paralysis"] = 95   --[[ #2 ]],
		["Disease"] = 8   --[[ #3 ]],
		["Will"] = 85   --[[ #4 ]],
		["Block"] = 70   --[[ #5 ]],
		["Death"] = 100   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 5		for ak=1,55 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_MULTISTAB"] = 5		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_FOXY_MULTISTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_STUNSTAB"] = 5		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_FOXY_STUNSTAB") end
temp = { ITM='ITM_ANTIDOTE', LVL=20, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=10, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_CHLOROFORM"] = 4		for ak=1,55 do table.insert(Data.Acts,"Abl.ITM_CHLOROFORM") end
temp = { ITM='ITM_CHLOROFORM', LVL=40, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=50, VLT=false }
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=65, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=70, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=80, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=20, VLT=false }
for ak=1,75 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HOMEO"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ITM_HOMEO") end
temp = { ITM='ITM_HOMEO', LVL=65, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_ROCK"] = 75		for ak=1,10 do table.insert(Data.Acts,"Abl.ITM_ROCK") end
Data.ActMinLevel["Abl.ITM_STEROIDS"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_STEROIDS") end


return Data
