--[[
**********************************************
  
  SuperCyborg.lua
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
 
version: 16.08.11
]]


-- Version 16.08.11



Data = {
	Name = "Super Cyborg",
	Desc = "Comic fanatic before being turned into a cyborg.\nHe can still be very dangerous, though",
	ImageFile = "Boss/SuperCyborg.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 4,
	EleRes_Wind = 4,
	EleRes_Water = 4,
	EleRes_Earth = 4,
	EleRes_Frost = 5,
	EleRes_Lightning = 6,
	EleRes_Light = 5,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {40,454},
		["Defense"] = {40,189},
		["Will"] = {0,240},
		["Resistance"] = {0,101},
		["Agility"] = {1,45},
		["Accuracy"] = {1,92},
		["Evasion"] = {0,23},
		["HP"] = {900,29250},
		["AP"] = {0,0},
		["LevelRange"] = {1,99},
},
	StatusResistance = {
		["Poison"] = 99   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 99   --[[ #3 ]],
		["Will"] = 99   --[[ #4 ]],
		["Block"] = 99   --[[ #5 ]],
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
Data.ActMinLevel["Abl.ABL_EXHURU_BATTLECRY"] = 200		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_EXHURU_BATTLECRY") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 100		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 50		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 25		for ak=1,150 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 12		for ak=1,200 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 200		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_DEATH"] = 5		for ak=1,250 do table.insert(Data.Acts,"Abl.ABL_FOE_DEATH") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 5		for ak=1,300 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 1		for ak=1,120 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ITM_CHLOROFORM"] = 95		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_CHLOROFORM") end
temp = { ITM='ITM_EQP_SUPER_AQUAMARINE', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_CARNELIAN', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_KYANITE', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SUPER_ONYX', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_STEROIDS', LVL=100, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERCAPSULE', LVL=100, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERFIRSTAIDKIT', LVL=100, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.SUPER_WENDICKA_VOLTSUNAMI"] = 2500		for ak=1,1 do table.insert(Data.Acts,"Abl.SUPER_WENDICKA_VOLTSUNAMI") end


return Data
