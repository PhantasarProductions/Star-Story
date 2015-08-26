--[[
	Generated by Foe Editor
	(c) Jeroen P. Broks
	If this file has any references at all to the story line
	or any of its characters it may only be distributed in an
	unmodified form with an unmodified version of the game

	If this file has no references at all, you may
	use it under the terms of the zlib license!
]]


-- Version 15.08.26



Data = {
	Name = "Battle Droid",
	Desc = "A simple droid whipped up by the Astrilopups.\nAll it can do is kill.",
	ImageFile = "Reg/BattleDroid.png",
	AI = "Default",
	Stat = {
		["Strength"] = {15,250},
		["Defense"] = {10,240},
		["Will"] = {1,5},
		["Resistance"] = {2,95},
		["Agility"] = {5,200},
		["Accuracy"] = {100,10000},
		["Evasion"] = {2,10},
		["HP"] = {20,600},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,5 do table.insert(Data.Acts,"Sys.Attack") end
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=20, VLT=false }
for ak=1,2 do table.insert(Data.ItemDrop ,temp) end
for ak=1,6 do table.insert(Data.ItemSteal,temp) end


return Data
