--[[
  QueenMyr.lua
  Version: 16.09.12
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


-- Version 16.09.11



Data = {
	Name = "Myr Queen",
	Desc = "Queen of the Myr. Not a very friendly lady!\nShe has good control over her colony.",
	ImageFile = "Boss/MyrQueen.png",
	AI = "Default",
	EleRes_Fire = 4,
	EleRes_Wind = 2,
	EleRes_Water = 2,
	EleRes_Earth = 5,
	EleRes_Frost = 2,
	EleRes_Lightning = 2,
	EleRes_Light = 2,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {228,233},
		["Defense"] = {44,45},
		["Will"] = {78,80},
		["Resistance"] = {47,50},
		["Agility"] = {42,46},
		["Accuracy"] = {50,52},
		["Evasion"] = {9,11},
		["HP"] = {3422,5196},
		["AP"] = {0,0},
		["LevelRange"] = {40,45},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,18 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_PARALYZEFLUID"] = 46		for ak=1,8 do table.insert(Data.Acts,"Abl.ABL_FOE_PARALYZEFLUID") end
Data.ActMinLevel["Abl.ABL_FOE_VENOMBITE"] = 45		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_VENOMBITE") end
Data.ActMinLevel["Abl.ABL_FOE_VIRUSBITE"] = 40		for ak=1,15 do table.insert(Data.Acts,"Abl.ABL_FOE_VIRUSBITE") end
temp = { ITM='ITM_BLUBAFLOWER', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=1, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,30 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_AQUAMARINE', LVL=20, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_CARNELIAN', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=55, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_ONYX', LVL=45, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=45, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=50, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=45, VLT=false }
for ak=1,20 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=1, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_MEDIKIT', LVL=46, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=43, VLT=false }
for ak=1,4 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=300, VLT=false }
for ak=1,300 do table.insert(Data.ItemDrop ,temp) end
for ak=1,300 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=1, VLT=false }
for ak=1,3 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=44, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=20, VLT=false }
for ak=1,10 do table.insert(Data.ItemDrop ,temp) end
Data.ActMinLevel["Abl.ZZZ_MYR_SUMMON"] = 45		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_MYR_SUMMON") end


return Data
