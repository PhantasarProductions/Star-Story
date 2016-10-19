--[[
**********************************************
  
  McLeen.lua
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
 
version: 16.10.20
]]


-- Version 16.10.20



Data = {
	Name = "George McLeen",
	Desc = "Crystal's Father\nOnce falsely charged for treason\nNow out to get his revenge.\nHis obsession for revenge made him\na very dangerous man.",
	ImageFile = "SpecialBoss/McLeen.png",
	AI = "McLeen",
	Boss = true,
	EleRes_Fire = 5,
	EleRes_Wind = 5,
	EleRes_Water = 5,
	EleRes_Earth = 5,
	EleRes_Frost = 5,
	EleRes_Lightning = 6,
	EleRes_Light = 2,
	EleRes_Dark = 5,
	EleRes_Healing = 6,
	EleRes_DarkHealing = 5,
	Stat = {
		["Strength"] = {77,542},
		["Defense"] = {12,109},
		["Will"] = {22,197},
		["Resistance"] = {19,109},
		["Agility"] = {10,109},
		["Accuracy"] = {23,108},
		["Evasion"] = {4,19},
		["HP"] = {4100,43940},
		["AP"] = {0,0},
		["LevelRange"] = {2,125},
},
	StatusResistance = {
		["Poison"] = 95   --[[ #1 ]],
		["Paralysis"] = 100   --[[ #2 ]],
		["Disease"] = 95   --[[ #3 ]],
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
Data.ActMinLevel["Abl.ABL_EXHURU_KAKSI"] = 40		for ak=1,80 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KAKSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_KOLME"] = 60		for ak=1,70 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KOLME") end
Data.ActMinLevel["Abl.ABL_EXHURU_KUUSI"] = 100		for ak=1,50 do table.insert(Data.Acts,"Abl.ABL_EXHURU_KUUSI") end
Data.ActMinLevel["Abl.ABL_EXHURU_NELJA"] = 80		for ak=1,60 do table.insert(Data.Acts,"Abl.ABL_EXHURU_NELJA") end
Data.ActMinLevel["Abl.ABL_EXHURU_YKSI"] = 20		for ak=1,90 do table.insert(Data.Acts,"Abl.ABL_EXHURU_YKSI") end
Data.ActMinLevel["Abl.ABL_FOE_IDDQD"] = 150		for ak=1,5 do table.insert(Data.Acts,"Abl.ABL_FOE_IDDQD") end
Data.ActMinLevel["Abl.ABL_FOXY_BACKSTAB"] = 180		for ak=1,25 do table.insert(Data.Acts,"Abl.ABL_FOXY_BACKSTAB") end
Data.ActMinLevel["Abl.ARM_DART"] = 5		for ak=1,100 do table.insert(Data.Acts,"Abl.ARM_DART") end
Data.ActMinLevel["Abl.ARM_FLAMETHROWER"] = 55		for ak=1,19 do table.insert(Data.Acts,"Abl.ARM_FLAMETHROWER") end
Data.ActMinLevel["Abl.ARM_HEALINGSHOWER"] = 1234		for ak=1,1 do table.insert(Data.Acts,"Abl.ARM_HEALINGSHOWER") end
Data.ActMinLevel["Abl.ARM_HEALINGSPRAY"] = 1		for ak=1,90 do table.insert(Data.Acts,"Abl.ARM_HEALINGSPRAY") end
Data.ActMinLevel["Abl.ARM_ICEBULLET"] = 40		for ak=1,30 do table.insert(Data.Acts,"Abl.ARM_ICEBULLET") end
Data.ActMinLevel["Abl.ARM_MINICANNON"] = 45		for ak=1,20 do table.insert(Data.Acts,"Abl.ARM_MINICANNON") end
Data.ActMinLevel["Abl.ARM_MULTIBLAST"] = 15		for ak=1,80 do table.insert(Data.Acts,"Abl.ARM_MULTIBLAST") end
Data.ActMinLevel["Abl.ARM_NAPALMSHOWER"] = 50		for ak=1,10 do table.insert(Data.Acts,"Abl.ARM_NAPALMSHOWER") end
Data.ActMinLevel["Abl.ARM_POISONDART"] = 25		for ak=1,60 do table.insert(Data.Acts,"Abl.ARM_POISONDART") end
Data.ActMinLevel["Abl.ARM_RISINGNOVA"] = 100		for ak=1,5 do table.insert(Data.Acts,"Abl.ARM_RISINGNOVA") end
Data.ActMinLevel["Abl.ARM_ROCKTHROWER"] = 30		for ak=1,50 do table.insert(Data.Acts,"Abl.ARM_ROCKTHROWER") end
Data.ActMinLevel["Abl.ARM_STUN_GUN"] = 20		for ak=1,70 do table.insert(Data.Acts,"Abl.ARM_STUN_GUN") end
Data.ActMinLevel["Abl.ITM_CHLOROFORM"] = 5		for ak=1,5 do table.insert(Data.Acts,"Abl.ITM_CHLOROFORM") end
Data.ActMinLevel["Abl.ITM_EPO"] = 150		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_EPO") end
temp = { ITM='ITM_PHAN_LEVELAPPLE', LVL=1000, VLT=false }
for ak=1,100000 do table.insert(Data.ItemDrop ,temp) end
for ak=1,10000 do table.insert(Data.ItemSteal,temp) end
Data.ActMinLevel["Abl.ITM_STEROIDS"] = 200		for ak=1,1 do table.insert(Data.Acts,"Abl.ITM_STEROIDS") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_ASTRILOPUP"] = 100		for ak=1,5 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_ASTRILOPUP") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_CAPT"] = 100		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_CAPT") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_GUNNER"] = 100		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_GUNNER") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_JI"] = 100		for ak=1,8 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_JI") end
Data.ActMinLevel["Abl.ZZZ_CYBERSUMMON_MEDIC"] = 100		for ak=1,10 do table.insert(Data.Acts,"Abl.ZZZ_CYBERSUMMON_MEDIC") end


return Data
