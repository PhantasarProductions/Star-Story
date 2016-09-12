--[[
  BigGrassTiger.lua
  Version: 16.09.12
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


-- Version 16.09.11



Data = {
	Name = "Big Grass Tiger",
	Desc = "A very big tiger that guards its \nplace in the Grass Jungle",
	ImageFile = "Boss/BigGrassTiger.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 2,
	EleRes_Wind = 6,
	EleRes_Water = 3,
	EleRes_Earth = 4,
	EleRes_Frost = 4,
	EleRes_Lightning = 1,
	EleRes_Light = 2,
	EleRes_Dark = 4,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {40,350},
		["Defense"] = {40,100},
		["Will"] = {20,300},
		["Resistance"] = {25,60},
		["Agility"] = {5,65},
		["Accuracy"] = {10000,10000},
		["Evasion"] = {25,30},
		["HP"] = {1500,3000},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
},
	StatusResistance = {
		["Poison"] = 100   --[[ #1 ]],
		["Paralysis"] = 0   --[[ #2 ]],
		["Disease"] = 30   --[[ #3 ]],
		["Will"] = 0   --[[ #4 ]],
		["Block"] = 0   --[[ #5 ]],
		["Death"] = 25   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_EXHURU_BATTLECRY"] = 0		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_EXHURU_BATTLECRY") end
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 60		for ak=1,4 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 75		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 100		for ak=1,2 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 125		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_FOE_LICKYOURWOUNDS"] = 10		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_LICKYOURWOUNDS") end
Data.ActMinLevel["Abl.ABL_FOE_SCRATCH"] = 0		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_SCRATCH") end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_GUBAFLOWER', LVL=40, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=2500, VLT=false }
for ak=1,2500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2500 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=5, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=30, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end


return Data
