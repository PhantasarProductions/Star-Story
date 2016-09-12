--[[
  Insetto.lua
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
	Name = "Insetto",
	Desc = "Watch out for its confusion fluid",
	ImageFile = "Reg/Insetto.png",
	AI = "Default",
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 0,
	EleRes_Earth = 0,
	EleRes_Frost = 0,
	EleRes_Lightning = 1,
	EleRes_Light = 1,
	EleRes_Dark = 6,
	EleRes_Healing = 5,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {5,6},
		["Defense"] = {1,2},
		["Will"] = {1,2},
		["Resistance"] = {1,2},
		["Agility"] = {40,50},
		["Accuracy"] = {1000,1000},
		["Evasion"] = {5,10},
		["HP"] = {10,15},
		["AP"] = {0,0},
		["LevelRange"] = {40,1},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,5 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_MINDCONTROLFLUID"] = 0		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_MINDCONTROLFLUID") end
temp = { ITM='ITM_EQP_GARNET', LVL=40, VLT=true }
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MINDCLEARPILL', LVL=40, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=2500, VLT=false }
for ak=1,2500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,2500 do table.insert(Data.ItemSteal,temp) end


return Data
