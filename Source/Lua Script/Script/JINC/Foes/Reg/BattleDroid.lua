--[[
**********************************************
  
  BattleDroid.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 
version: 15.09.14
]]


-- Version 15.09.14



Data = {
	Name = "Battle Droid",
	Desc = "A simple droid whipped up by the Astrilopups.\nAll it can do is kill.",
	ImageFile = "Reg/BattleDroid.png",
	AI = "Default",
	Stat = {
		["Strength"] = {10,250},
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
temp = { ITM='ITM_VLUGZOUT', LVL=3, VLT=false }
for ak=1,200 do table.insert(Data.ItemDrop ,temp) end
for ak=1,3 do table.insert(Data.ItemSteal,temp) end


return Data
