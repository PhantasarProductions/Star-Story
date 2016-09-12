--[[
**********************************************
  
  DeathMyrQueen.lua
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
	Name = "Death Myr Queen",
	Desc = "Far more dangerous than\na regular Myr already, \nand also a queen? \nCan it be any worse?",
	ImageFile = "Boss/DeathMyrQueen.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 4,
	EleRes_Wind = 5,
	EleRes_Water = 2,
	EleRes_Earth = 6,
	EleRes_Frost = 1,
	EleRes_Lightning = 2,
	EleRes_Light = 2,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {50,900},
		["Defense"] = {50,250},
		["Will"] = {50,900},
		["Resistance"] = {50,300},
		["Agility"] = {1,100},
		["Accuracy"] = {50,999},
		["Evasion"] = {1,50},
		["HP"] = {500,30000},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_BATTLECRY"] = 100		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_EXHURU_BATTLECRY") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 60		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 90		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 120		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 100		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 30		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_DEATHSTING"] = 90		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATHSTING") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 96		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_PARALYZEFLUID"] = 10		for ak=1,30 do table.insert(Data.Acts,"Abl.ABL_FOE_PARALYZEFLUID") end
Data.ActMinLevel["Abl.ABL_FOE_VENOMSTING"] = 80		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_FOE_VENOMSTING") end
temp = { ITM='ITM_EQP_EMERALD', LVL=10, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1000 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=70, VLT=false }
for ak=1,70 do table.insert(Data.ItemDrop ,temp) end
for ak=1,70 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ZZZ_MYR_SUMMON"] = 100		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_MYR_SUMMON") end
Data.ActMinLevel["Abl.ZZZ_SUMMON_DEATH_MYR"] = 120		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_SUMMON_DEATH_MYR") end


return Data
