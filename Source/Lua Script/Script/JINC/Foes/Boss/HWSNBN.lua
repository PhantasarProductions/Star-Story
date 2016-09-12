--[[
  HWSNBN.lua
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
	Name = "He shall not be named",
	Desc = "Somebody who practices the Dark Arts.\nDid he simple fall to the Dark Side of the Power\nOr is there an other reason he can do this stuff?",
	ImageFile = "Boss/HWSNBN.png",
	AI = "Default",
	Boss = true,
	EleRes_Fire = 3,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Frost = 3,
	EleRes_Lightning = 2,
	EleRes_Light = 1,
	EleRes_Dark = 6,
	EleRes_Healing = 3,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {1,100},
		["Defense"] = {1,50},
		["Will"] = {100,500},
		["Resistance"] = {100,250},
		["Agility"] = {0,90},
		["Accuracy"] = {0,100},
		["Evasion"] = {50,60},
		["HP"] = {100,10000},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
},
	StatusResistance = {
		["Poison"] = 80   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 75   --[[ #3 ]],
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


Data.ActMinLevel["Abl.ABL_FOE_AVADAKEDAVRA"] = 150		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_FOE_AVADAKEDAVRA") end
Data.ActMinLevel["Abl.ABL_FOE_CRUCIO"] = 0		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_CRUCIO") end
Data.ActMinLevel["Abl.ABL_FOE_CURSEDHEALING"] = 100		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_CURSEDHEALING") end
Data.ActMinLevel["Abl.ABL_FOE_EXPDRAIN"] = 500		for ak=1,1 do table.insert(Data.Acts,"Abl.ABL_FOE_EXPDRAIN") end
Data.ActMinLevel["Abl.ABL_FOE_FEAR"] = 5		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_FEAR") end
Data.ActMinLevel["Abl.ABL_FOE_FULLHEALTH"] = 500		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_FULLHEALTH") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 100		for ak=1,10 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOE_IMPERIO"] = 125		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_FOE_IMPERIO") end
Data.ActMinLevel["Abl.ABL_FOE_INFERNO"] = 111		for ak=1,20 do table.insert(Data.Acts,"Abl.ABL_FOE_INFERNO") end
temp = { ITM='ITM_PHAN_PRISMDIAMOND', LVL=180, VLT=false }
for ak=1,180 do table.insert(Data.ItemDrop ,temp) end
for ak=1,180 do table.insert(Data.ItemSteal,temp) end


return Data
