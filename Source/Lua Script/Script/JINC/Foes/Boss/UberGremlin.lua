--[[
**********************************************
  
  UberGremlin.lua
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
 
version: 16.07.30
]]


-- Version 16.07.30



Data = {
	Name = "Gremlin",
	Desc = "The stronger kind of Gremlin.\nNot the kind of fellow you want to meet in the dark",
	ImageFile = "Boss/UberGremlin.png",
	AI = "Default",
	Shilders = 500,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 3,
	EleRes_Light = 1,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {200,400},
		["Defense"] = {10,20},
		["Will"] = {200,400},
		["Resistance"] = {5,10},
		["Agility"] = {100,200},
		["Accuracy"] = {200,400},
		["Evasion"] = {5,10},
		["HP"] = {25000,50000},
		["AP"] = {0,0},
		["LevelRange"] = {100,200},
},
	StatusResistance = {
		["Poison"] = 0   --[[ #1 ]],
		["Paralysis"] = 99   --[[ #2 ]],
		["Disease"] = 0   --[[ #3 ]],
		["Will"] = 0   --[[ #4 ]],
		["Block"] = 0   --[[ #5 ]],
		["Death"] = 0   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,1000 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_BATTLECRY"] = 1200		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_EXHURU_BATTLECRY") end
Data.ActMinLevel["Abl.ABL_EXHURU_CONCENTRATE"] = 2800		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_EXHURU_CONCENTRATE") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 400		for ak=1,85 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 600		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 800		for ak=1,75 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 1000		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 200		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_DEMON_SOUL_BREAKER"] = 1600		for ak=1,55 do table.insert(Data.Acts,"Abl.ABL_FOE_DEMON_SOUL_BREAKER") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 1400		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 1600		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
temp = { ITM='ITM_PHANTASAR_BANANA', LVL=500, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_CARROT', LVL=270, VLT=false }
for ak=1,65 do table.insert(Data.ItemDrop ,temp) end
for ak=1,65 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_HOLYWATER', LVL=200, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_LIONHEAD', LVL=210, VLT=false }
for ak=1,95 do table.insert(Data.ItemDrop ,temp) end
for ak=1,95 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDISC', LVL=220, VLT=false }
for ak=1,90 do table.insert(Data.ItemDrop ,temp) end
for ak=1,90 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_MAGICDUST', LVL=230, VLT=false }
for ak=1,80 do table.insert(Data.ItemDrop ,temp) end
for ak=1,80 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_PHANTASAR_PANACEA"] = 10		for ak=1,2600 do table.insert(Data.Acts,"Abl.ITM_PHANTASAR_PANACEA") end
temp = { ITM='ITM_PHANTASAR_PANACEA', LVL=240, VLT=false }
for ak=1,85 do table.insert(Data.ItemDrop ,temp) end
for ak=1,85 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_PHANTASAR_PEPPER"] = 15		for ak=1,2200 do table.insert(Data.Acts,"Abl.ITM_PHANTASAR_PEPPER") end
temp = { ITM='ITM_PHANTASAR_PEPPER', LVL=250, VLT=false }
for ak=1,70 do table.insert(Data.ItemDrop ,temp) end
for ak=1,70 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_PHOENIX', LVL=260, VLT=false }
for ak=1,75 do table.insert(Data.ItemDrop ,temp) end
for ak=1,75 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_POTION', LVL=280, VLT=false }
for ak=1,60 do table.insert(Data.ItemDrop ,temp) end
for ak=1,60 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_PHANTASAR_SALVE"] = 10		for ak=1,2400 do table.insert(Data.Acts,"Abl.ITM_PHANTASAR_SALVE") end
temp = { ITM='ITM_PHANTASAR_SALVE', LVL=290, VLT=false }
for ak=1,55 do table.insert(Data.ItemDrop ,temp) end
for ak=1,55 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_SHININGORB', LVL=300, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHANTASAR_SUPERCARROT', LVL=310, VLT=false }
for ak=1,45 do table.insert(Data.ItemDrop ,temp) end
for ak=1,45 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_PHANTASAR_SUPERSALVE"] = 35		for ak=1,1800 do table.insert(Data.Acts,"Abl.ITM_PHANTASAR_SUPERSALVE") end
temp = { ITM='ITM_PHANTASAR_SUPERSALVE', LVL=320, VLT=false }
for ak=1,40 do table.insert(Data.ItemDrop ,temp) end
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_BANANAS', LVL=1000, VLT=false }
for ak=1,15 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_PRISMDIAMOND', LVL=9000, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_TRAVEL', LVL=330, VLT=false }
for ak=1,35 do table.insert(Data.ItemDrop ,temp) end
for ak=1,35 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.SUPER_WENDICKA_VOLTSUNAMI"] = 5		for ak=1,3000 do table.insert(Data.Acts,"Abl.SUPER_WENDICKA_VOLTSUNAMI") end
Data.ActMinLevel["Abl.ZZZ_CID_DARKNESS"] = 25		for ak=1,2000 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKNESS") end


return Data
