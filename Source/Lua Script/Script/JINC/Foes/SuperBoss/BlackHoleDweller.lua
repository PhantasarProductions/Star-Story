--[[
**********************************************
  
  BlackHoleDweller.lua
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
	Name = "Black Hole Dweller",
	Desc = "The foes of all foes.\nNow that you managed to defeat it\nyou can claim you are the ultimate master\nof Star Story.\nCongratulations. This is one of the \nachievements, the world should BOW for!",
	ImageFile = "SuperBoss/BlackHoleDweller.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 6,
	EleRes_Wind = 6,
	EleRes_Water = 6,
	EleRes_Earth = 6,
	EleRes_Frost = 6,
	EleRes_Lightning = 6,
	EleRes_Light = 6,
	EleRes_Dark = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {66040,66040},
		["Defense"] = {30000,30000},
		["Will"] = {28020,28020},
		["Resistance"] = {10000,10000},
		["Agility"] = {13010,13010},
		["Accuracy"] = {81090,81090},
		["Evasion"] = {0,0},
		["HP"] = {5000000,5000000},
		["AP"] = {0,0},
		["LevelRange"] = {10000,10001},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 0		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.BHD_BLIZZARD"] = 0		for ak=1,25 do table.insert(Data.Acts,"Abl.BHD_BLIZZARD") end
Data.ActMinLevel["Abl.BHD_FIRE"] = 0		for ak=1,25 do table.insert(Data.Acts,"Abl.BHD_FIRE") end
Data.ActMinLevel["Abl.BHD_LIGHT"] = 0		for ak=1,25 do table.insert(Data.Acts,"Abl.BHD_LIGHT") end
Data.ActMinLevel["Abl.BHD_LIGHTNING"] = 0		for ak=1,25 do table.insert(Data.Acts,"Abl.BHD_LIGHTNING") end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end


return Data
