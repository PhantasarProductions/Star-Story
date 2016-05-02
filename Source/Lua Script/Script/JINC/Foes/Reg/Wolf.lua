--[[
  Wolf.lua
  Version: 16.02.26
  Copyright (C) 2016 Jeroen Petrus Broks
  
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


-- Version 16.02.26



Data = {
	Name = "Wolf",
	Desc = "Normally not an enemy for human beings,\nhowever if they are really hungry....",
	ImageFile = "Reg/Wolf.png",
	AI = "Default",
	EleRes_Fire = 2,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 4,
	EleRes_Lightning = 3,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {279,285},
		["Defense"] = {113,115},
		["Will"] = {193,195},
		["Resistance"] = {133,135},
		["Agility"] = {85,90},
		["Accuracy"] = {65,70},
		["Evasion"] = {25,26},
		["HP"] = {2679,2700},
		["AP"] = {0,0},
		["LevelRange"] = {60,61},
},
	StatusResistance = {
		["Poison"] = 70   --[[ #1 ]],
		["Paralysis"] = 75   --[[ #2 ]],
		["Disease"] = 65   --[[ #3 ]],
		["Will"] = 60   --[[ #4 ]],
		["Block"] = 75   --[[ #5 ]],
		["Death"] = 60   --[[ #6 ]],
		["Damned"] = 80   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_LICKYOURWOUNDS"] = 56		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_LICKYOURWOUNDS") end
temp = { ITM='ITM_ANTIDOTE', LVL=1, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=2, VLT=false }
for ak=1,3 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_CHLOROFORM', LVL=4, VLT=false }
for ak=1,4 do table.insert(Data.ItemDrop ,temp) end
for ak=1,4 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=60, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=60, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=60, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_KYANITE', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=5, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=6, VLT=false }
for ak=1,6 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=7, VLT=false }
for ak=1,7 do table.insert(Data.ItemDrop ,temp) end
for ak=1,7 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HOMEO', LVL=55, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ICEBOMB', LVL=8, VLT=false }
for ak=1,8 do table.insert(Data.ItemDrop ,temp) end
for ak=1,8 do table.insert(Data.ItemSteal,temp) end


return Data
