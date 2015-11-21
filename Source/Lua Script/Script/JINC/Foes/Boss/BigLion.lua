--[[
  BigLion.lua
  Version: 15.11.21
  Copyright (C) 2015 Jeroen Petrus Broks
  
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


-- Version 15.11.21



Data = {
	Name = "Big Lion",
	Desc = "Nobody knows how this lion got so big. Maybe a stunt by the Cids who used the Dark Side of the Power on it.",
	ImageFile = "Boss/BigLion.png",
	AI = "Default",
	EleRes_Fire = 4,
	EleRes_Wind = 3,
	EleRes_Water = 3,
	EleRes_Earth = 3,
	EleRes_Cold = 1,
	EleRes_Thunder = 2,
	EleRes_Light = 4,
	EleRes_Darkness = 3,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {14,470},
		["Defense"] = {14,200},
		["Will"] = {14,450},
		["Resistance"] = {14,100},
		["Agility"] = {0,75},
		["Accuracy"] = {0,100},
		["Evasion"] = {1,20},
		["HP"] = {0,10000},
		["AP"] = {0,0},
		["LevelRange"] = {1,85},
},
	StatusResistance = {
		["Poison"] = 33   --[[ #1 ]],
		["Paralysis"] = 83   --[[ #2 ]],
		["Disease"] = 85   --[[ #3 ]],
		["Will"] = 98   --[[ #4 ]],
		["Block"] = 35   --[[ #5 ]],
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
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 20		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 30		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 50		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 40		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_STOMP"] = 10		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_EXHURU_STOMP") end
Data.ActMinLevel["Abl.ABL_FOE_SCRATCH"] = 60		for ak=1,40 do table.insert(Data.Acts,"Abl.ABL_FOE_SCRATCH") end
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=30, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BLUBAFLOWER', LVL=40, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=60, VLT=true }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=60, VLT=true }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=50, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=20, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=80, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=100, VLT=false }
for ak=1,100 do table.insert(Data.ItemDrop ,temp) end
for ak=1,4 do table.insert(Data.ItemSteal,temp) end


return Data
