--[[
**********************************************
  
  Salamander.lua
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
 
version: 16.08.07
]]


-- Version 16.08.07



Data = {
	Name = "Salamander",
	Desc = "This creature loves heath",
	ImageFile = "Reg/Salamander.png",
	AI = "Default",
	EleRes_Fire = 6,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 0,
	EleRes_Lightning = 4,
	EleRes_Light = 4,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {147,150},
		["Defense"] = {62,66},
		["Will"] = {97,98},
		["Resistance"] = {56,59},
		["Agility"] = {25,29},
		["Accuracy"] = {20,92},
		["Evasion"] = {10,11},
		["HP"] = {1115,1210},
		["AP"] = {154,15},
		["LevelRange"] = {50,70},
},
	StatusResistance = {
		["Poison"] = 50   --[[ #1 ]],
		["Paralysis"] = 65   --[[ #2 ]],
		["Disease"] = 100   --[[ #3 ]],
		["Will"] = 0   --[[ #4 ]],
		["Block"] = 0   --[[ #5 ]],
		["Death"] = 80   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ARM_FLAMETHROWER"] = 30		for ak=1,50 do table.insert(Data.Acts,"Abl.ARM_FLAMETHROWER") end
temp = { ITM='ITM_BANDAGE', LVL=10, VLT=false }
for ak=1,900 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BIOHAZARD', LVL=30, VLT=false }
for ak=1,950 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=40, VLT=false }
for ak=1,800 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=100, VLT=false }
for ak=1,200 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=90, VLT=false }
for ak=1,300 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=500, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=60, VLT=false }
for ak=1,600 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=80, VLT=false }
for ak=1,400 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=70, VLT=false }
for ak=1,500 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ICEBOMB', LVL=120, VLT=false }
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=50, VLT=false }
for ak=1,700 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=20, VLT=false }
for ak=1,850 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=90, VLT=false }
for ak=1,700 do table.insert(Data.ItemSteal,temp) end


return Data
