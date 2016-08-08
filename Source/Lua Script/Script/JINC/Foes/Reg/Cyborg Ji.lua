--[[
**********************************************
  
  Cyborg Ji.lua
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
 
version: 16.06.10
]]


-- Version 16.06.10



Data = {
	Name = "Cyborg Ji Knight",
	Desc = "Fallen to the Dark Side,\nOr just controlled by his \nimplants? \n\nIt doesn't matter, this dude's\nDANGEROUS!",
	ImageFile = "Reg/Cyborg Ji.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 3,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {30,3924},
		["Defense"] = {5,1150},
		["Will"] = {20,2831},
		["Resistance"] = {25,1863},
		["Agility"] = {9,1058},
		["Accuracy"] = {90,4278},
		["Evasion"] = {25,30},
		["HP"] = {40,25915},
		["AP"] = {0,0},
		["LevelRange"] = {1,995},
},
	StatusResistance = {
		["Poison"] = 90   --[[ #1 ]],
		["Paralysis"] = 80   --[[ #2 ]],
		["Disease"] = 70   --[[ #3 ]],
		["Will"] = 100   --[[ #4 ]],
		["Block"] = 100   --[[ #5 ]],
		["Death"] = 80   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,1000 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 10		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 80		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 75		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 85		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 10		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_WENDICKA_ELECTRICCHARGE"] = 100		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_ELECTRICCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 25		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 90		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 80		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
Data.ActMinLevel["Abl.ABL_XENOBI_BREEZE"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BREEZE") end
Data.ActMinLevel["Abl.ABL_XENOBI_FROST"] = 30		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_FROST") end
Data.ActMinLevel["Abl.ABL_XENOBI_HEAL"] = 5		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HEAL") end
Data.ActMinLevel["Abl.ABL_XENOBI_HURRICANE"] = 80		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HURRICANE") end
Data.ActMinLevel["Abl.ABL_XENOBI_LIGHT"] = 75		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_LIGHT") end
Data.ActMinLevel["Abl.ABL_XENOBI_MINDTRICK"] = 75		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_XENOBI_MINDTRICK") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUAKE"] = 80		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUAKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUICKSTRIKE"] = 30		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUICKSTRIKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_RECOVER"] = 50		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_RECOVER") end
Data.ActMinLevel["Abl.ABL_XENOBI_ROCK"] = 10		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_ROCK") end
Data.ActMinLevel["Abl.ABL_XENOBI_VITALIZE"] = 25		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_VITALIZE") end
Data.ActMinLevel["Abl.ABL_YIRL_CONFUSION"] = 25		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_YIRL_CONFUSION") end
temp = { ITM='ITM_ANTIDOTE', LVL=10, VLT=false }
for ak=1,19000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,99 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=85, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=20, VLT=false }
for ak=1,18000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,98 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BIOHAZARD', LVL=30, VLT=false }
for ak=1,17000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,97 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BLUBAFLOWER', LVL=40, VLT=false }
for ak=1,16000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,96 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_CHLOROFORM', LVL=50, VLT=false }
for ak=1,15000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,94 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=60, VLT=false }
for ak=1,14000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,93 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=70, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,92 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=80, VLT=false }
for ak=1,99 do table.insert(Data.ItemDrop ,temp) end
for ak=1,91 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=90, VLT=false }
for ak=1,98 do table.insert(Data.ItemDrop ,temp) end
for ak=1,90 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=100, VLT=false }
for ak=1,97 do table.insert(Data.ItemDrop ,temp) end
for ak=1,89 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=110, VLT=false }
for ak=1,96 do table.insert(Data.ItemDrop ,temp) end
for ak=1,88 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=120, VLT=false }
for ak=1,95 do table.insert(Data.ItemDrop ,temp) end
for ak=1,87 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_PHAN_PRISMDIAMOND', LVL=999, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=130, VLT=false }
for ak=1,94 do table.insert(Data.ItemDrop ,temp) end
for ak=1,86 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=140, VLT=false }
for ak=1,93 do table.insert(Data.ItemDrop ,temp) end
for ak=1,85 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_AQUAMARINE', LVL=900, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=900, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=900, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_ONYX', LVL=900, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=140, VLT=false }
for ak=1,13000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,84 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=150, VLT=false }
for ak=1,12000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,83 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=160, VLT=false }
for ak=1,11000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,82 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=170, VLT=false }
for ak=1,10000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,81 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HOMEO', LVL=180, VLT=false }
for ak=1,9000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,80 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ICEBOMB', LVL=190, VLT=false }
for ak=1,8000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,79 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=200, VLT=false }
for ak=1,7000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,78 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDIKIT', LVL=210, VLT=false }
for ak=1,6000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,77 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MINDCLEARPILL', LVL=220, VLT=false }
for ak=1,5000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,76 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=230, VLT=false }
for ak=1,4000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,75 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_PRISMDIAMOND', LVL=999, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_TRAVEL', LVL=10000, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=240, VLT=false }
for ak=1,3000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,74 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=250, VLT=false }
for ak=1,2000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,73 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_STEROIDS', LVL=260, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,72 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=270, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,71 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=250, VLT=false }
for ak=1,400 do table.insert(Data.ItemDrop ,temp) end
for ak=1,70 do table.insert(Data.ItemSteal,temp) end


return Data
