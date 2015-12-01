--[[
**********************************************
  
  Cid.lua
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
 
version: 15.12.01
]]


-- Version 15.12.01



Data = {
	Name = "Cid",
	Desc = "Former Ji knight who fell to the Dark Side.\nHe hates the Ji with passion, and he's not very fond of you either.",
	ImageFile = "Reg/Cid.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 4,
	EleRes_Water = 4,
	EleRes_Earth = 4,
	EleRes_Cold = 5,
	EleRes_Thunder = 2,
	EleRes_Light = 1,
	EleRes_Darkness = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {30,410},
		["Defense"] = {5,100},
		["Will"] = {20,300},
		["Resistance"] = {25,150},
		["Agility"] = {9,100},
		["Accuracy"] = {90,600},
		["Evasion"] = {25,20},
		["HP"] = {40,2500},
		["AP"] = {20,888},
		["LevelRange"] = {10,90},
},
	StatusResistance = {
		["Poison"] = 80   --[[ #1 ]],
		["Paralysis"] = 70   --[[ #2 ]],
		["Disease"] = 80   --[[ #3 ]],
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,1 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 48		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_WENDICKA_ELECTRICCHARGE"] = 800		for ak=1,8 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_ELECTRICCHARGE") end
Data.ActMinLevel["Abl.ABL_WENDICKA_JOLT"] = 50		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_JOLT") end
Data.ActMinLevel["Abl.ABL_WENDICKA_MJOLNIR"] = 80		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_MJOLNIR") end
Data.ActMinLevel["Abl.ABL_WENDICKA_SHOCK"] = 70		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_WENDICKA_SHOCK") end
Data.ActMinLevel["Abl.ABL_XENOBI_BLIZZARD"] = 10		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BLIZZARD") end
Data.ActMinLevel["Abl.ABL_XENOBI_BREEZE"] = 10		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_XENOBI_BREEZE") end
Data.ActMinLevel["Abl.ABL_XENOBI_FROST"] = 10		for ak=1,30 do table.insert(Data.Acts,"Abl.ABL_XENOBI_FROST") end
Data.ActMinLevel["Abl.ABL_XENOBI_HEAL"] = 20		for ak=1,35 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HEAL") end
Data.ActMinLevel["Abl.ABL_XENOBI_HURRICANE"] = 5		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_XENOBI_HURRICANE") end
Data.ActMinLevel["Abl.ABL_XENOBI_MINDTRICK"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_MINDTRICK") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUAKE"] = 75		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUAKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_QUICKSTRIKE"] = 5		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_XENOBI_QUICKSTRIKE") end
Data.ActMinLevel["Abl.ABL_XENOBI_RECOVER"] = 4		for ak=1,38 do table.insert(Data.Acts,"Abl.ABL_XENOBI_RECOVER") end
Data.ActMinLevel["Abl.ABL_XENOBI_VITALIZE"] = 4		for ak=1,47 do table.insert(Data.Acts,"Abl.ABL_XENOBI_VITALIZE") end
temp = { ITM='ITM_EQP_EMERALD', LVL=35, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=35, VLT=true }
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=35, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=5, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=2, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=3, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ZZZ_CID_DARKCHARGE"] = 50		for ak=1,50 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKCHARGE") end
Data.ActMinLevel["Abl.ZZZ_CID_DARKNESS"] = 30		for ak=1,1 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKNESS") end
Data.ActMinLevel["Abl.ZZZ_CID_DARKSOULBREAKER"] = 2		for ak=1,9500 do table.insert(Data.Acts,"Abl.ZZZ_CID_DARKSOULBREAKER") end
Data.ActMinLevel["Abl.ZZZ_CID_ULTRADARKNESS"] = 30		for ak=1,35 do table.insert(Data.Acts,"Abl.ZZZ_CID_ULTRADARKNESS") end


return Data
