--[[
  Leopard.lua
  Version: 16.06.23
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


-- Version 16.06.23



Data = {
	Name = "Leopard",
	Desc = "A cat-like animal who can be quite a threat.\nIt has a secret trick ready for you.",
	ImageFile = "Reg/Leopard.png",
	AI = "Default",
	EleRes_Fire = 3,
	EleRes_Wind = 5,
	EleRes_Water = 3,
	EleRes_Earth = 1,
	EleRes_Frost = 3,
	EleRes_Lightning = 4,
	EleRes_Light = 3,
	EleRes_Dark = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {44,346},
		["Defense"] = {10,99},
		["Will"] = {33,227},
		["Resistance"] = {28,148},
		["Agility"] = {23,138},
		["Accuracy"] = {171,900},
		["Evasion"] = {30,79},
		["HP"] = {218,1990},
		["AP"] = {0,0},
		["LevelRange"] = {10,100},
},
	StatusResistance = {
		["Poison"] = 25   --[[ #1 ]],
		["Paralysis"] = 30   --[[ #2 ]],
		["Disease"] = 40   --[[ #3 ]],
		["Will"] = 100   --[[ #4 ]],
		["Block"] = 100   --[[ #5 ]],
		["Death"] = 30   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.ABL_FOE_LICKYOURWOUNDS"] = 10		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_FOE_LICKYOURWOUNDS") end
Data.ActMinLevel["Abl.ABL_FOE_SCRATCH"] = 30		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_SCRATCH") end
temp = { ITM='ITM_ASTRILOPUPHONEY', LVL=70, VLT=false }
for ak=1,900 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EPO', LVL=65, VLT=false }
for ak=1,800 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=85, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,15 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FISH', LVL=90, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,25 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SUPERICEBOMB', LVL=75, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,40 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VYKXIFLOWER', LVL=60, VLT=false }
for ak=1,1000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,50 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ZZZ_FOE_LEOPARD_UPGRADE"] = 80		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_FOE_LEOPARD_UPGRADE") end


return Data
