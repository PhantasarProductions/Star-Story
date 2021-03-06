--[[
**********************************************
  
  Ghoul.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 16.09.12
]]


-- Version 16.09.11



Data = {
	Name = "Ghoul",
	Desc = "Dead and rotten,\nbut still dangerous!",
	ImageFile = "Reg/Ghoul.png",
	AI = "Default",
	Shilders = 275,
	EleRes_Fire = 1,
	EleRes_Wind = 4,
	EleRes_Water = 4,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 2,
	EleRes_Light = 0,
	EleRes_Dark = 6,
	EleRes_Healing = 0,
	EleRes_DarkHealing = 6,
	Stat = {
		["Strength"] = {0,100},
		["Defense"] = {0,50},
		["Will"] = {0,75},
		["Resistance"] = {0,10},
		["Agility"] = {0,25},
		["Accuracy"] = {0,200},
		["Evasion"] = {0,1},
		["HP"] = {0,1000},
		["AP"] = {0,0},
		["LevelRange"] = {0,50},
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=1500, VLT=false }
for ak=1,1500 do table.insert(Data.ItemDrop ,temp) end
for ak=1,1500 do table.insert(Data.ItemSteal,temp) end


return Data
