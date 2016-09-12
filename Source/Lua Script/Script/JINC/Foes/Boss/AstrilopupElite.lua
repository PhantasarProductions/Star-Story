--[[
**********************************************
  
  AstrilopupElite.lua
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
	Name = "Astrilopup Elite",
	Desc = "These are no guys to toy with. \nEven the Astrilopups have a few fighters \nwho may call themselves elite, and if\nyou have to oppose one, you'd better\nbe well-prepared.",
	ImageFile = "Reg/Astrilopup.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Light = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 1,
	Stat = {
		["Strength"] = {376,400},
		["Defense"] = {41,42},
		["Will"] = {85,90},
		["Resistance"] = {27,30},
		["Agility"] = {20,80},
		["Accuracy"] = {41,100},
		["Evasion"] = {3,5},
		["HP"] = {3163,4000},
		["AP"] = {0,0},
		["LevelRange"] = {50,60},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,1000 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 56		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 58		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 54		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 60		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 55		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
temp = { ITM='ITM_ANTIDOTE', LVL=5, VLT=false }
for ak=1,95 do table.insert(Data.ItemDrop ,temp) end
for ak=1,95 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=55, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,90 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=10, VLT=false }
for ak=1,80 do table.insert(Data.ItemDrop ,temp) end
for ak=1,85 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=15, VLT=false }
for ak=1,75 do table.insert(Data.ItemDrop ,temp) end
for ak=1,80 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=20, VLT=false }
for ak=1,75 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=25, VLT=false }
for ak=1,70 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=30, VLT=false }
for ak=1,65 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=35, VLT=false }
for ak=1,60 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=40, VLT=false }
for ak=1,55 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=45, VLT=false }
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=50, VLT=false }
for ak=1,45 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=55, VLT=false }
for ak=1,70 do table.insert(Data.ItemDrop ,temp) end
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=60, VLT=false }
for ak=1,65 do table.insert(Data.ItemDrop ,temp) end
for ak=1,35 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=65, VLT=false }
for ak=1,60 do table.insert(Data.ItemDrop ,temp) end
for ak=1,30 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=70, VLT=false }
for ak=1,55 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDIKIT', LVL=75, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MINDCLEARPILL', LVL=80, VLT=false }
for ak=1,45 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=85, VLT=false }
for ak=1,40 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=20, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=90, VLT=false }
for ak=1,35 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=95, VLT=false }
for ak=1,30 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=100, VLT=false }
for ak=1,25 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=105, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
Data.ActMinLevel["Abl.ZZZ_ASTRILOPUPELITE_SUMMON"] = 112		for ak=1,5 do table.insert(Data.Acts,"Abl.ZZZ_ASTRILOPUPELITE_SUMMON") end


return Data
