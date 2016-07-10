--[[
**********************************************
  
  Gummi.lua
  (c) Jeroen Broks, 2015, 2016, All Rights Reserved.
  
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
 
version: 16.07.10
]]


-- Version 16.07.10



Data = {
	Name = "Gummi",
	Desc = "A slime like creature living in the Grass Jungle.\nIt's said to be poisonous",
	ImageFile = "Reg/Gummi.png",
	AI = "Default",
	Boss = false,
	EleRes_Fire = 0,
	EleRes_Wind = 4,
	EleRes_Water = 6,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 2,
	EleRes_Light = 3,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {50,55},
		["Defense"] = {1,2},
		["Will"] = {8,10},
		["Resistance"] = {100,1000},
		["Agility"] = {7,10},
		["Accuracy"] = {100,1000},
		["Evasion"] = {1,1},
		["HP"] = {100,200},
		["AP"] = {0,0},
		["LevelRange"] = {5,10},
},
	StatusResistance = {
		["Poison"] = 100   --[[ #1 ]],
		["Paralysis"] = 40   --[[ #2 ]],
		["Disease"] = 100   --[[ #3 ]],
		["Will"] = 1   --[[ #4 ]],
		["Block"] = 1   --[[ #5 ]],
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
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ANTIDOTE', LVL=2, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=5, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=5, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=8, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=3, VLT=false }
for ak=1,3 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=50, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,8 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=7, VLT=false }
for ak=1,3 do table.insert(Data.ItemSteal,temp) end


return Data
