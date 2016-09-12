--[[
**********************************************
  
  Imp.lua
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
	Name = "Imp",
	Desc = "Nasty creatures living on Phantasar.\nThey can be quick and deadly.",
	ImageFile = "Reg/Imp.png",
	AI = "Default",
	Shilders = 250,
	EleRes_Fire = 2,
	EleRes_Wind = 2,
	EleRes_Water = 2,
	EleRes_Earth = 2,
	EleRes_Frost = 2,
	EleRes_Lightning = 1,
	EleRes_Light = 1,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {416,600},
		["Defense"] = {145,160},
		["Will"] = {212,424},
		["Resistance"] = {116,130},
		["Agility"] = {100,120},
		["Accuracy"] = {600,1200},
		["Evasion"] = {15,20},
		["HP"] = {3038,5000},
		["AP"] = {0,0},
		["LevelRange"] = {60,80},
},
	StatusResistance = {
		["Poison"] = 90   --[[ #1 ]],
		["Paralysis"] = 30   --[[ #2 ]],
		["Disease"] = 90   --[[ #3 ]],
		["Will"] = 10   --[[ #4 ]],
		["Block"] = 20   --[[ #5 ]],
		["Death"] = 40   --[[ #6 ]],
		["Damned"] = 40   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,1000 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 70		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 80		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=200, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_AQUAMARINE', LVL=300, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=300, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=300, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_ONYX', LVL=300, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_ANTIDOTE', LVL=10, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_APPLE', LVL=60, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_CARROT', LVL=90, VLT=false }
for ak=1,200 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_LIONHEAD', LVL=20, VLT=false }
for ak=1,900 do table.insert(Data.ItemDrop ,temp) end
for ak=1,90 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDISC', LVL=30, VLT=false }
for ak=1,800 do table.insert(Data.ItemDrop ,temp) end
for ak=1,80 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDUST', LVL=40, VLT=false }
for ak=1,700 do table.insert(Data.ItemDrop ,temp) end
for ak=1,70 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MEDICINE', LVL=50, VLT=false }
for ak=1,600 do table.insert(Data.ItemDrop ,temp) end
for ak=1,60 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_PHOENIX', LVL=70, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_SALVE', LVL=80, VLT=false }
for ak=1,400 do table.insert(Data.ItemDrop ,temp) end
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=5, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_TRAVEL', LVL=100, VLT=false }
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=90, VLT=false }
for ak=1,300 do table.insert(Data.ItemDrop ,temp) end
for ak=1,30 do table.insert(Data.ItemSteal,temp) end


return Data
