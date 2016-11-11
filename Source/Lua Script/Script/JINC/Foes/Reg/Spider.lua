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
 
version: 16.11.11
]]


-- Version 16.11.11



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
temp = { ITM='ITM_BOOK2', LVL=50, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=25, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FISH', LVL=80, VLT=false }
for ak=1,200 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=70, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=20, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,500 do table.insert(Data.ItemSteal,temp) end


return Data
