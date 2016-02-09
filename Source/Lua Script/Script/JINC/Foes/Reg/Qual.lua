--[[
  Qual.lua
  Version: 16.02.09
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


-- Version 16.02.09



Data = {
	Name = "Qual",
	Desc = "A kind of jellyfish that can live on land. \nIt loves trash and due to illegal dumping \nyou can now find it on any planet that has \nbeen target at least once of illegal dumping.",
	ImageFile = "Reg/Qual.png",
	AI = "Default",
	EleRes_Fire = 1,
	EleRes_Wind = 3,
	EleRes_Water = 6,
	EleRes_Earth = 3,
	EleRes_Frost = 2,
	EleRes_Lightning = 0,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {30,310},
		["Defense"] = {5,112},
		["Will"] = {20,300},
		["Resistance"] = {25,200},
		["Agility"] = {9,100},
		["Accuracy"] = {90,500},
		["Evasion"] = {5,40},
		["HP"] = {40,2500},
		["AP"] = {0,0},
		["LevelRange"] = {1,90},
},
	StatusResistance = {
		["Poison"] = 10   --[[ #1 ]],
		["Paralysis"] = 0   --[[ #2 ]],
		["Disease"] = 30   --[[ #3 ]],
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


Data.ActMinLevel["Abl.ABL_FOE_WATERBEAM"] = 0		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_WATERBEAM") end
temp = { ITM='ITM_EQP_EMERALD', LVL=9000, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=50, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=30, VLT=false }
for ak=1,4 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end


return Data
