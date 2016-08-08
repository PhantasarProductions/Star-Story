--[[
**********************************************
  
  HellHound.lua
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
 
version: 16.08.08
]]


-- Version 16.08.08



Data = {
	Name = "Hell Hound",
	Desc = "A dog filled up with fire.",
	ImageFile = "Reg/HellHound.png",
	AI = "Default",
	Shilders = 25,
	EleRes_Fire = 6,
	EleRes_Wind = 3,
	EleRes_Water = 2,
	EleRes_Earth = 3,
	EleRes_Frost = 1,
	EleRes_Lightning = 3,
	EleRes_Light = 3,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {0,410},
		["Defense"] = {0,10},
		["Will"] = {0,300},
		["Resistance"] = {0,120},
		["Agility"] = {0,110},
		["Accuracy"] = {0,500},
		["Evasion"] = {0,65},
		["HP"] = {0,2500},
		["AP"] = {0,0},
		["LevelRange"] = {1,300},
},
	StatusResistance = {
		["Poison"] = 75   --[[ #1 ]],
		["Paralysis"] = 70   --[[ #2 ]],
		["Disease"] = 60   --[[ #3 ]],
		["Will"] = 100   --[[ #4 ]],
		["Block"] = 100   --[[ #5 ]],
		["Death"] = 85   --[[ #6 ]],
		["Damned"] = 100   --[[ #7 ]],
	},
	Acts = {}, -- Data itself defined below
	ActMinLevel = {}, -- Data itself defined below
	ItemDrop = {}, -- Data itself defined below
	ItemSteal = {} -- Data itself definded below
}


local temp


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,100 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_INFERNO"] = 200		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOE_INFERNO") end


return Data
