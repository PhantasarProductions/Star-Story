--[[
  Thief.lua
  Version: 16.06.03
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


-- Version 16.06.03



Data = {
	Name = "Thief",
	Desc = "This girl made herself a carreer \nof fighting and killing people,\nin order to get their stuff.\n\nIt's a way to make a living, eh?",
	ImageFile = "Reg/Thief.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 3,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {203,210},
		["Defense"] = {57,60},
		["Will"] = {129,130},
		["Resistance"] = {91,100},
		["Agility"] = {85,90},
		["Accuracy"] = {551,560},
		["Evasion"] = {55,60},
		["HP"] = {1148,1200},
		["AP"] = {0,0},
		["LevelRange"] = {57,60},
},
	StatusResistance = {
		["Poison"] = 8   --[[ #1 ]],
		["Paralysis"] = 95   --[[ #2 ]],
		["Disease"] = 8   --[[ #3 ]],
		["Will"] = 85   --[[ #4 ]],
		["Block"] = 70   --[[ #5 ]],
		["Death"] = 85   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 5		for ak=1,55 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_MULTISTAB"] = 5		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_FOXY_MULTISTAB") end
Data.ActMinLevel["Abl.ABL_FOXY_STUNSTAB"] = 5		for ak=1,65 do table.insert(Data.Acts,"Abl.ABL_FOXY_STUNSTAB") end
temp = { ITM='ITM_ANTIDOTE', LVL=20, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=100, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=10, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_CHLOROFORM"] = 4		for ak=1,55 do table.insert(Data.Acts,"Abl.ITM_CHLOROFORM") end
temp = { ITM='ITM_CHLOROFORM', LVL=40, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,100 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ENERGYDRINK', LVL=50, VLT=false }
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_GARNET', LVL=65, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=70, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_SAPHIRE', LVL=80, VLT=false }
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=20, VLT=false }
for ak=1,75 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_HOMEO"] = 60		for ak=1,10 do table.insert(Data.Acts,"Abl.ITM_HOMEO") end
temp = { ITM='ITM_HOMEO', LVL=65, VLT=false }
for ak=1,50 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end


return Data
