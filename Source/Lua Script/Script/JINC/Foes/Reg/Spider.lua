--[[
**********************************************
  
  Spider.lua
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
 
version: 16.11.09
]]


-- Version 16.11.09



Data = {
	Name = "Spider",
	Desc = "Gigantic spider.\nNative to Ysperon.",
	ImageFile = "Reg/Spider.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 2,
	EleRes_Earth = 3,
	EleRes_Frost = 1,
	EleRes_Lightning = 3,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {250,500},
		["Defense"] = {100,250},
		["Will"] = {250,500},
		["Resistance"] = {100,250},
		["Agility"] = {20,100},
		["Accuracy"] = {100,1000},
		["Evasion"] = {100,150},
		["HP"] = {100,5000},
		["AP"] = {0,0},
		["LevelRange"] = {10,100},
},
	StatusResistance = {
		["Poison"] = 100   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 85   --[[ #3 ]],
		["Will"] = 60   --[[ #4 ]],
		["Block"] = 60   --[[ #5 ]],
		["Death"] = 56   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 93		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_CAPTUREWEB"] = 85		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_CAPTUREWEB") end
Data.ActMinLevel["Abl.ABL_FOE_DEATHSTING"] = 90		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATHSTING") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 70		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 120		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_SCRATCH"] = 4		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_SCRATCH") end
Data.ActMinLevel["Abl.ABL_FOE_VENOMSTING"] = 70		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_VENOMSTING") end
temp = { ITM='ITM_ANTIDOTE', LVL=25, VLT=false }
for ak=1,9950 do table.insert(Data.ItemDrop ,temp) end
for ak=1,95 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=80, VLT=false }
for ak=1,9870 do table.insert(Data.ItemDrop ,temp) end
for ak=1,87 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=5, VLT=false }
for ak=1,9990 do table.insert(Data.ItemDrop ,temp) end
for ak=1,99 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BIOHAZARD', LVL=55, VLT=false }
for ak=1,9910 do table.insert(Data.ItemDrop ,temp) end
for ak=1,91 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BLUBAFLOWER', LVL=30, VLT=false }
for ak=1,9940 do table.insert(Data.ItemDrop ,temp) end
for ak=1,94 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_CHLOROFORM', LVL=45, VLT=false }
for ak=1,9930 do table.insert(Data.ItemDrop ,temp) end
for ak=1,93 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=70, VLT=false }
for ak=1,9920 do table.insert(Data.ItemDrop ,temp) end
for ak=1,92 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EPO', LVL=95, VLT=false }
for ak=1,9860 do table.insert(Data.ItemDrop ,temp) end
for ak=1,86 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=180, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=190, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=200, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=210, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=220, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=230, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_PHAN_PRISMDIAMOND', LVL=240, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=250, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=260, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_AQUAMARINE', LVL=520, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=540, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=560, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_ONYX', LVL=580, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=17, VLT=false }
for ak=1,9970 do table.insert(Data.ItemDrop ,temp) end
for ak=1,97 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FISH', LVL=50, VLT=false }
for ak=1,9920 do table.insert(Data.ItemDrop ,temp) end
for ak=1,95 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=35, VLT=false }
for ak=1,9930 do table.insert(Data.ItemDrop ,temp) end
for ak=1,93 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=10, VLT=false }
for ak=1,9980 do table.insert(Data.ItemDrop ,temp) end
for ak=1,98 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=40, VLT=false }
for ak=1,9940 do table.insert(Data.ItemDrop ,temp) end
for ak=1,94 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HOMEO', LVL=85, VLT=false }
for ak=1,9860 do table.insert(Data.ItemDrop ,temp) end
for ak=1,86 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ICEBOMB', LVL=65, VLT=false }
for ak=1,9890 do table.insert(Data.ItemDrop ,temp) end
for ak=1,89 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=60, VLT=false }
for ak=1,9900 do table.insert(Data.ItemDrop ,temp) end
for ak=1,90 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDIKIT', LVL=20, VLT=false }
for ak=1,9960 do table.insert(Data.ItemDrop ,temp) end
for ak=1,96 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MINDCLEARPILL', LVL=75, VLT=false }
for ak=1,9880 do table.insert(Data.ItemDrop ,temp) end
for ak=1,88 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=90, VLT=false }
for ak=1,9870 do table.insert(Data.ItemDrop ,temp) end
for ak=1,87 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_POISONDART', LVL=170, VLT=false }
for ak=1,6000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,72 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=160, VLT=false }
for ak=1,9999 do table.insert(Data.ItemDrop ,temp) end
for ak=1,73 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SHOT', LVL=155, VLT=false }
for ak=1,6900 do table.insert(Data.ItemDrop ,temp) end
for ak=1,74 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=145, VLT=false }
for ak=1,6960 do table.insert(Data.ItemDrop ,temp) end
for ak=1,76 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_STEROIDS', LVL=150, VLT=false }
for ak=1,2000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,75 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERCAPSULE', LVL=130, VLT=false }
for ak=1,7000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,80 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERFIRSTAIDKIT', LVL=135, VLT=false }
for ak=1,6999 do table.insert(Data.ItemDrop ,temp) end
for ak=1,79 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERICEBOMB', LVL=140, VLT=false }
for ak=1,6980 do table.insert(Data.ItemDrop ,temp) end
for ak=1,78 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPER_THUNDER_DIAMOND', LVL=130, VLT=false }
for ak=1,6970 do table.insert(Data.ItemDrop ,temp) end
for ak=1,77 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=100, VLT=false }
for ak=1,8950 do table.insert(Data.ItemDrop ,temp) end
for ak=1,85 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VIRUSDART', LVL=105, VLT=false }
for ak=1,8940 do table.insert(Data.ItemDrop ,temp) end
for ak=1,84 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VITAMINC', LVL=110, VLT=false }
for ak=1,8930 do table.insert(Data.ItemDrop ,temp) end
for ak=1,83 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=115, VLT=false }
for ak=1,8910 do table.insert(Data.ItemDrop ,temp) end
for ak=1,81 do table.insert(Data.ItemSteal,temp) end


return Data
