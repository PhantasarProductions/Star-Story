--[[
**********************************************
  
  Cow.lua
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
 
version: 16.05.26
]]


-- Version 16.05.26



Data = {
	Name = "Cow",
	Desc = "Mutated Cow.\nOften dumped somewhere, where the crimminals\ncan get away with it.\nAlthough not very smart they can be dangerous.",
	ImageFile = "Reg/Cow.png",
	AI = "Default",
	EleRes_Fire = 0,
	EleRes_Wind = 0,
	EleRes_Water = 0,
	EleRes_Earth = 0,
	EleRes_Frost = 0,
	EleRes_Lightning = 0,
	EleRes_Light = 0,
	EleRes_Dark = 0,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {5,500},
		["Defense"] = {5,250},
		["Will"] = {5,500},
		["Resistance"] = {5,250},
		["Agility"] = {5,100},
		["Accuracy"] = {5,1000},
		["Evasion"] = {5,20},
		["HP"] = {5,1200},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
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


temp = { ITM='ITM_STEROIDS', LVL=70, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=80, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.MOO_AGLDOWN"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_AGLDOWN") end
Data.ActMinLevel["Abl.MOO_ALLDOWN"] = 50		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_ALLDOWN") end
Data.ActMinLevel["Abl.MOO_APDOWN"] = 5		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_APDOWN") end
Data.ActMinLevel["Abl.MOO_DEFDOWN"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_DEFDOWN") end
Data.ActMinLevel["Abl.MOO_EVADOWN"] = 15		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_EVADOWN") end
Data.ActMinLevel["Abl.MOO_KUN_JE_NIET_BETER_MIKKEN"] = 20		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_KUN_JE_NIET_BETER_MIKKEN") end
Data.ActMinLevel["Abl.MOO_MAXAPDOWN"] = 25		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_MAXAPDOWN") end
Data.ActMinLevel["Abl.MOO_MAXHPDOWN"] = 30		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_MAXHPDOWN") end
Data.ActMinLevel["Abl.MOO_POWERDOWN"] = 35		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_POWERDOWN") end
Data.ActMinLevel["Abl.MOO_RESDOWN"] = 40		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_RESDOWN") end
Data.ActMinLevel["Abl.MOO_WILLDOWN"] = 45		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_WILLDOWN") end
Data.ActMinLevel["Abl.MOO_Z1_DAT_WAS_IK_VERGETEN"] = 50		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_DAT_WAS_IK_VERGETEN") end
Data.ActMinLevel["Abl.MOO_Z1_GIF"] = 55		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_GIF") end
Data.ActMinLevel["Abl.MOO_Z1_IN_DE_WAR"] = 60		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_IN_DE_WAR") end
Data.ActMinLevel["Abl.MOO_Z1_KAN_IK_NIET"] = 65		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_KAN_IK_NIET") end
Data.ActMinLevel["Abl.MOO_Z1_MOEDEEERRRRRRRRRR_WAT_BEN_IK_BANG"] = 70		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_MOEDEEERRRRRRRRRR_WAT_BEN_IK_BANG") end
Data.ActMinLevel["Abl.MOO_Z1_SLAAP_KINDJE_SLAAP"] = 75		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_SLAAP_KINDJE_SLAAP") end
Data.ActMinLevel["Abl.MOO_Z1_SLOTOPDIETAS"] = 80		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_SLOTOPDIETAS") end
Data.ActMinLevel["Abl.MOO_Z1_VERLAMD"] = 85		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_VERLAMD") end
Data.ActMinLevel["Abl.MOO_Z1_ZIEK"] = 90		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z1_ZIEK") end
Data.ActMinLevel["Abl.MOO_Z2_ALLE_STATUSSEN"] = 100		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z2_ALLE_STATUSSEN") end
Data.ActMinLevel["Abl.MOO_Z2_STERF"] = 95		for ak=1,1 do table.insert(Data.Acts,"Abl.MOO_Z2_STERF") end


return Data
