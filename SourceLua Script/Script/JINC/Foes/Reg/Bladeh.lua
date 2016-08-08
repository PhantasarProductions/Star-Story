--[[
  Bladeh.lua
  Version: 16.05.26
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


-- Version 16.05.26



Data = {
	Name = "Bladeh Rogue",
	Desc = "The Bladeh have a way of living most members\n of the IF deem \"criminal\". \nWe consider it \"thievery\" and \"murder\". \nThey see it as \"honorable combat\"\n and taking the stuff you have as\n their \"right by combat\".\nThey don't really understand how we \ncan survive without those \"rules\".",
	ImageFile = "Reg/Bladeh.png",
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
		["Strength"] = {0,350},
		["Defense"] = {0,100},
		["Will"] = {0,230},
		["Resistance"] = {0,150},
		["Agility"] = {0,140},
		["Accuracy"] = {0,900},
		["Evasion"] = {0,75},
		["HP"] = {0,2000},
		["AP"] = {0,400},
		["LevelRange"] = {0,90},
},
	StatusResistance = {
		["Poison"] = 94   --[[ #1 ]],
		["Paralysis"] = 22   --[[ #2 ]],
		["Disease"] = 68   --[[ #3 ]],
		["Will"] = 92   --[[ #4 ]],
		["Block"] = 14   --[[ #5 ]],
		["Death"] = 18   --[[ #6 ]],
		["Damned"] = 98   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.BLADEH_MOLOTOV"] = 10		for ak=1,10 do table.insert(Data.Acts,"Abl.BLADEH_MOLOTOV") end
Data.ActMinLevel["Abl.BLADEH_MULTI_STAB"] = 10		for ak=1,80 do table.insert(Data.Acts,"Abl.BLADEH_MULTI_STAB") end
Data.ActMinLevel["Abl.BLADEH_STUNSTAB"] = 10		for ak=1,20 do table.insert(Data.Acts,"Abl.BLADEH_STUNSTAB") end
Data.ActMinLevel["Abl.BLADEH_VENOM"] = 10		for ak=1,40 do table.insert(Data.Acts,"Abl.BLADEH_VENOM") end
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ANTIDOTE', LVL=20, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,30 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=5, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BIOHAZARD', LVL=25, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_EMERALD', LVL=30, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_EQP_RUBY', LVL=35, VLT=false }
for ak=1,1 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_FIRSTAIDKIT', LVL=40, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,20 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEALINGCAPSULE', LVL=10, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_HEATHRUB', LVL=25, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MEDICINE', LVL=25, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_MOLOTOV', LVL=50, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_ROCK', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_SPORES', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_THUNDER_DIAMOND', LVL=1, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_VLUGZOUT', LVL=60, VLT=false }
for ak=1,1 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end


return Data
