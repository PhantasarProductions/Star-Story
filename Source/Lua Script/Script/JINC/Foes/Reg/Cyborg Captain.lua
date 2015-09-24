--[[
**********************************************
  
  Cyborg Captain.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 
version: 15.09.24
]]


-- Version 15.09.24



Data = {
	Name = "Cyborg Captain",
	Desc = "She used to be captain in rank, but what can she do now, now that her mind is erased?",
	ImageFile = "Reg/Cyborg Captain.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 6,
	EleRes_Wind = 6,
	EleRes_Water = 6,
	EleRes_Earth = 6,
	EleRes_Cold = 6,
	EleRes_Thunder = 6,
	EleRes_Light = 6,
	EleRes_Darkness = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {25,30},
		["Defense"] = {5,10},
		["Will"] = {25,30},
		["Resistance"] = {5,10},
		["Agility"] = {10,20},
		["Accuracy"] = {10,30},
		["Evasion"] = {1,5},
		["HP"] = {100,150},
		["AP"] = {0,0},
		["LevelRange"] = {5,10},
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,10 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 10		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 15		for ak=1,30 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 30		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 120		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_FOE_PHOTON"] = 10		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_PHOTON") end
Data.ActMinLevel["Abl.ABL_FOE_TASER"] = 5		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_TASER") end
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ANTIDOTE', LVL=2, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=5, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BLUBAFLOWER', LVL=1, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=15, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HEALINGCAPSULE"] = 20		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_HEALINGCAPSULE") end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=10, VLT=false }
for ak=1,25 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=1, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end


return Data
