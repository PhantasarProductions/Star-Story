--[[
**********************************************
  
  Flysky.lua
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
 
version: 16.05.13
]]


-- Version 16.05.13



Data = {
	Name = "Flysky",
	Desc = "This creature looks like a butterfly, \nbut that does not make it any less\ndangerous. It \"Ultra Sonic\" can\nput everybody's AP to 0.\nHow lucky you are Crystal does\nnot have AP",
	ImageFile = "Reg/Flysky.png",
	AI = "Default",
	EleRes_Fire = 4,
	EleRes_Wind = 0,
	EleRes_Water = 1,
	EleRes_Earth = 2,
	EleRes_Frost = 0,
	EleRes_Lightning = 5,
	EleRes_Light = 2,
	EleRes_Dark = 6,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 0,
	Stat = {
		["Strength"] = {142,135},
		["Defense"] = {39,39},
		["Will"] = {97,105},
		["Resistance"] = {67,88},
		["Agility"] = {61,63},
		["Accuracy"] = {405,408},
		["Evasion"] = {46,58},
		["HP"] = {792,881},
		["AP"] = {0,0},
		["LevelRange"] = {40,50},
},
	StatusResistance = {
		["Poison"] = 80   --[[ #1 ]],
		["Paralysis"] = 50   --[[ #2 ]],
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


Data.ActMinLevel["Sys.Attack"] = 0		for ak=1,25 do table.insert(Data.Acts,"Sys.Attack") end
Data.ActMinLevel["Abl.ABL_FOE_ULTRASONIC"] = 45		for ak=1,45 do table.insert(Data.Acts,"Abl.ABL_FOE_ULTRASONIC") end
temp = { ITM='ITM_EQP_GARNET', LVL=45, VLT=false }
for ak=1,2 do table.insert(Data.ItemSteal,temp) end


return Data
