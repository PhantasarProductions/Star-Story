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
	Name = "Astrilopup Gunner",
	Desc = "An Astrilopup with a photon gun.\nBut how did it ever get such a gun?",
	ImageFile = "Reg/astrilopup.png",
	AI = "Default",
	Stat = {
		["Strength"] = {5,2000000},
		["Defense"] = {1,50000},
		["Will"] = {1,20000000},
		["Resistance"] = {1,10000},
		["Agility"] = {10,5000},
		["Accuracy"] = {10,100},
		["Evasion"] = {1,5},
		["HP"] = {25,60000},
		["AP"] = {10,70000},
		["LevelRange"] = {1,10000},
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Abl.ABL_FOE_PHOTON"] = 1		for ak=1,100 do table.insert(Data.Acts,"Abl.ABL_FOE_PHOTON") end
temp = { ITM='ITM_ADHBANDAGE', LVL=1, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end
temp = { ITM='ITM_BANDAGE', LVL=20, VLT=false }
for ak=1,5 do table.insert(Data.ItemDrop ,temp) end
for ak=1,5 do table.insert(Data.ItemSteal,temp) end


return Data
