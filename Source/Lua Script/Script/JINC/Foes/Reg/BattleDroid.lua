--[[
	Generated by Foe Editor
	(c) Jeroen P. Broks
	If this file has any references at all to the story line
	or any of its characters it may only be distributed in an
	unmodified form with an unmodified version of the game

	If this file has no references at all, you may
	use it under the terms of the zlib license!
]]


-- Version 15.07.11



Data = {
	Name = "Battle Droid",
	Desc = "A simple droid whipped up by the Astrilopups.\nAll it can do is kill.",
	ImageFile = "Reg/BattleDroid.png",
	Stat = {
		["Strength"] = {4,200},
		["Defense"] = {2,100},
		["Will"] = {1,5},
		["Resistance"] = {2,95},
		["Agility"] = {5,200},
		["Accuracy"] = {100,10000},
		["Evasion"] = {2,10},
		["HP"] = {10,500},
		["AP"] = {0,0},
		["LevelRange"] = {1,100},
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {} -- Data itself defined below
}



Data.ActMinLevel["Sys.Attack"] = 1		for ak=1,5 do table.insert(Data.Acts,"Sys.Attack") end


return Data
