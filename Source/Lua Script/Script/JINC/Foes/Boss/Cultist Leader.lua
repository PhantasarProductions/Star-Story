--[[
**********************************************
  
  Cultist Leader.lua
  (c) Jeroen Broks, 2016, 2017, All Rights Reserved.
  
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
 
version: 17.03.03
]]


-- Version 16.12.24



Data = {
	Name = "Cultist Leader",
	Desc = "Fools who devoted their lives to demons\nand demonic creatures. \nIs Chthulu real?\nThese guys seem to believe so!",
	ImageFile = "*CULTISTLEADER",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 3,
	EleRes_Light = 1,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {0,800},
		["Defense"] = {1,100},
		["Will"] = {0,850},
		["Resistance"] = {1,80},
		["Agility"] = {1,200},
		["Accuracy"] = {1,100},
		["Evasion"] = {1,50},
		["HP"] = {100,10000},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
},
	StatusResistance = {
		["Poison"] = 5   --[[ #1 ]],
		["Paralysis"] = 20   --[[ #2 ]],
		["Disease"] = 5   --[[ #3 ]],
		["Will"] = 50   --[[ #4 ]],
		["Block"] = 60   --[[ #5 ]],
		["Death"] = 100   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,1 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_CULIST_CALL"] = 80		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_CULIST_CALL") end
Data.ActMinLevel["Abl.ABL_CULTIST_CTHULU"] = 9000		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_CULTIST_CTHULU") end
Data.ActMinLevel["Abl.ABL_CULTIST_PRAYCTHULU"] = 95		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_CULTIST_PRAYCTHULU") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 2		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 3		for ak=1,3 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 4		for ak=1,4 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 5		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 6		for ak=1,6 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 7		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_FLAMETOUCH"] = 8		for ak=1,8 do table.insert(Data.Acts,"Abl.ABL_FOE_FLAMETOUCH") end
Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 9		for ak=1,9 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_POISONCLOUD"] = 11		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOE_POISONCLOUD") end
Data.ActMinLevel["Abl.ABL_FOE_TASER"] = 12		for ak=1,3 do table.insert(Data.Acts,"Abl.ABL_FOE_TASER") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 13		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 14		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_MULTISTAB"] = 15		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_MULTISTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_STUNSTAB"] = 16		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOXY_STUNSTAB") end
Data.ActMinLevel["Abl.ARM_DART"] = 70		for ak=1,1 do table.insert(Data.Acts,"Abl.ARM_DART") end
Data.ActMinLevel["Abl.ARM_HEALINGSPRAY"] = 80		for ak=1,1 do table.insert(Data.Acts,"Abl.ARM_HEALINGSPRAY") end
Data.ActMinLevel["Abl.ITM_ADHBANDAGE"] = 60		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ADHBANDAGE") end
temp = { ITM='ITM_ADHBANDAGE', LVL=10, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_ANTIDOTE"] = 70		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ANTIDOTE") end
temp = { ITM='ITM_ANTIDOTE', LVL=20, VLT=false }
for ak=1,990 do table.insert(Data.ItemDrop ,temp) end
for ak=1,19 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_ASTRILOPUPHONEY"] = 80		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ASTRILOPUPHONEY") end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=30, VLT=false }
for ak=1,980 do table.insert(Data.ItemDrop ,temp) end
for ak=1,18 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_BANDAGE"] = 30		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_BANDAGE") end
temp = { ITM='ITM_BANDAGE', LVL=40, VLT=false }
for ak=1,970 do table.insert(Data.ItemDrop ,temp) end
for ak=1,17 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_BIOHAZARD"] = 20		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_BIOHAZARD") end
temp = { ITM='ITM_BIOHAZARD', LVL=50, VLT=false }
for ak=1,960 do table.insert(Data.ItemDrop ,temp) end
for ak=1,16 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_BLUBAFLOWER"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_BLUBAFLOWER") end
temp = { ITM='ITM_BLUBAFLOWER', LVL=60, VLT=false }
for ak=1,950 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_CHLOROFORM"] = 90		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_CHLOROFORM") end
temp = { ITM='ITM_CHLOROFORM', LVL=70, VLT=false }
for ak=1,940 do table.insert(Data.ItemDrop ,temp) end
for ak=1,14 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=80, VLT=false }
for ak=1,930 do table.insert(Data.ItemDrop ,temp) end
for ak=1,13 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=920, VLT=true }
for ak=1,170 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=930, VLT=true }
for ak=1,160 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=940, VLT=true }
for ak=1,150 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=950, VLT=true }
for ak=1,140 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=960, VLT=true }
for ak=1,130 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=970, VLT=true }
for ak=1,120 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=980, VLT=true }
for ak=1,110 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=990, VLT=true }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_AQUAMARINE', LVL=1000, VLT=true }
for ak=1,90 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=1010, VLT=true }
for ak=1,80 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=1020, VLT=true }
for ak=1,70 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_ONYX', LVL=1030, VLT=true }
for ak=1,60 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_FIRSTAIDKIT"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_FIRSTAIDKIT") end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=1040, VLT=false }
for ak=1,40 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_GUBAFLOWER"] = 2		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_GUBAFLOWER") end
temp = { ITM='ITM_GUBAFLOWER', LVL=90, VLT=false }
for ak=1,920 do table.insert(Data.ItemDrop ,temp) end
for ak=1,12 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HEALINGCAPSULE"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_HEALINGCAPSULE") end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=100, VLT=false }
for ak=1,910 do table.insert(Data.ItemDrop ,temp) end
for ak=1,11 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HEATHRUB"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_HEATHRUB") end
temp = { ITM='ITM_HEATHRUB', LVL=110, VLT=false }
for ak=1,900 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HOMEO"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_HOMEO") end
temp = { ITM='ITM_HOMEO', LVL=120, VLT=false }
for ak=1,890 do table.insert(Data.ItemDrop ,temp) end
for ak=1,9 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_ICEBOMB"] = 5		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ICEBOMB") end
temp = { ITM='ITM_ICEBOMB', LVL=130, VLT=false }
for ak=1,880 do table.insert(Data.ItemDrop ,temp) end
for ak=1,8 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_MEDICINE"] = 6		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_MEDICINE") end
temp = { ITM='ITM_MEDICINE', LVL=140, VLT=false }
for ak=1,870 do table.insert(Data.ItemDrop ,temp) end
for ak=1,7 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_MEDIKIT"] = 8		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_MEDIKIT") end
temp = { ITM='ITM_MEDIKIT', LVL=150, VLT=false }
for ak=1,860 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_MINDCLEARPILL"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_MINDCLEARPILL") end
temp = { ITM='ITM_MINDCLEARPILL', LVL=160, VLT=false }
for ak=1,850 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_MOLOTOV"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_MOLOTOV") end
temp = { ITM='ITM_MOLOTOV', LVL=170, VLT=false }
for ak=1,840 do table.insert(Data.ItemDrop ,temp) end
for ak=1,4 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_ANTIDOTE', LVL=440, VLT=false }
for ak=1,390 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_APPLE', LVL=450, VLT=false }
for ak=1,380 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDUST', LVL=460, VLT=false }
for ak=1,350 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=30, VLT=false }
for ak=1,30 do table.insert(Data.ItemDrop ,temp) end
for ak=1,30 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_ROCK"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_ROCK") end
temp = { ITM='ITM_ROCK', LVL=180, VLT=false }
for ak=1,830 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_SPORES"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_SPORES") end
temp = { ITM='ITM_SPORES', LVL=190, VLT=false }
for ak=1,820 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_STEROIDS"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_STEROIDS") end
temp = { ITM='ITM_STEROIDS', LVL=200, VLT=false }
for ak=1,810 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_THUNDER_DIAMOND"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_THUNDER_DIAMOND") end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=210, VLT=false }
for ak=1,800 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=220, VLT=false }
for ak=1,790 do table.insert(Data.ItemDrop ,temp) end


return Data
