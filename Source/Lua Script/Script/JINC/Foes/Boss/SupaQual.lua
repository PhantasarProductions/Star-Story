--[[
  SupaQual.lua
  Version: 16.07.15
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]


-- Version 16.07.15



Data = {
	Name = "SupaQual",
	Desc = "This guy is very extremly strong, \nbut cannot bear lightning at all",
	ImageFile = "Boss/SupaQual.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 1,
	EleRes_Wind = 2,
	EleRes_Water = 6,
	EleRes_Earth = 5,
	EleRes_Frost = 4,
	EleRes_Lightning = 0,
	EleRes_Light = 4,
	EleRes_Dark = 4,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {0,1000},
		["Defense"] = {0,10},
		["Will"] = {0,5000},
		["Resistance"] = {0,20},
		["Agility"] = {0,5},
		["Accuracy"] = {0,1000},
		["Evasion"] = {0,1000},
		["HP"] = {10000,100000},
		["AP"] = {9,9},
		["LevelRange"] = {0,100},
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


Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_WATERBEAM"] = 1		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_WATERBEAM") end
temp = { ITM='ITM_ANTIDOTE', LVL=50, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=100, VLT=false }
for ak=1,3 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BIOHAZARD', LVL=150, VLT=false }
for ak=1,4 do table.insert(Data.ItemDrop ,temp) end
for ak=1,4 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BLUBAFLOWER', LVL=200, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=500, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=500, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=250, VLT=false }
for ak=1,6 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=250, VLT=false }
for ak=1,7 do table.insert(Data.ItemDrop ,temp) end
for ak=1,7 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=250, VLT=false }
for ak=1,8 do table.insert(Data.ItemDrop ,temp) end
for ak=1,8 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=70, VLT=false }
for ak=1,9 do table.insert(Data.ItemDrop ,temp) end
for ak=1,9 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=80, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=90, VLT=false }
for ak=1,11 do table.insert(Data.ItemDrop ,temp) end
for ak=1,11 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=100, VLT=false }
for ak=1,12 do table.insert(Data.ItemDrop ,temp) end
for ak=1,12 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=300, VLT=false }
for ak=1,14 do table.insert(Data.ItemDrop ,temp) end
for ak=1,14 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=500, VLT=false }
for ak=1,15 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end


return Data
