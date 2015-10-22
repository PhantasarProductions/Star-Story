--[[
  Star Story.lua
  Version: 15.10.06
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
-- @USEDIR LIBS
-- @USEDIR Use/Anyway

-- If you are poking in this script and encounter errors as a result.
-- The error reporting within the Kthura editor will refer to this file as 0_MyProject.lua in the current version!

function ENEMY_SPOTPLACE()
local mytag
local timer
repeat
 mytag = "Enemy "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
local ME = SPOT.ME()
ME.Tag = mytag
ME.R = 255
ME.G = 0
ME.B = 5
CSay("Placed "..mytag)
end

function ENEMY_SPOTSHOW()
local ME = SPOT.ME()
ME.R = 255
ME.G = 0
ME.B = 5
SPOT.DrawMe()
end

function ENEMY_SPOTCLICKED()
local ME = SPOT.ME()
local oz = { [false]=0, [true]=1}
local result = CLICKED.X>ME.X-5 and CLICKED.X<ME.X+5 and CLICKED.Y>ME.Y-5 and CLICKED.Y<ME.Y+5
CLICKED.RET = oz[ result ]
-- CSay(ME.IDNum..">"..ME.Tag.." CLICKED.X = "..CLICKED.X.." CLICKED.Y = "..CLICKED.Y.."; ME.X = "..ME.X.."; ME.Y = "..ME.Y.."; RETURN "..CLICKED.RET.." << "..sval(result)) -- debug
end




-- All the same routine anyway, so let's not keep scripting shall we?
CSpot_EnemyHZ1_Place = ENEMY_SPOTPLACE
CSpot_EnemyHZ2_Place = ENEMY_SPOTPLACE
CSpot_EnemyHZ3_Place = ENEMY_SPOTPLACE
CSpot_EnemyVT1_Place = ENEMY_SPOTPLACE
CSpot_EnemyVT2_Place = ENEMY_SPOTPLACE
CSpot_EnemyVT3_Place = ENEMY_SPOTPLACE
CSpot_EnemySS1_Place = ENEMY_SPOTPLACE
CSpot_EnemySS2_Place = ENEMY_SPOTPLACE
CSpot_EnemySS3_Place = ENEMY_SPOTPLACE
CSpot_EnemyAS1_Place = ENEMY_SPOTPLACE
CSpot_EnemyAS2_Place = ENEMY_SPOTPLACE
CSpot_EnemyAS3_Place = ENEMY_SPOTPLACE
CSpot_EnemyHZ1_Show  = ENEMY_SPOTSHOW
CSpot_EnemyHZ2_Show  = ENEMY_SPOTSHOW
CSpot_EnemyHZ3_Show  = ENEMY_SPOTSHOW
CSpot_EnemyVT1_Show  = ENEMY_SPOTSHOW
CSpot_EnemyVT2_Show  = ENEMY_SPOTSHOW
CSpot_EnemyVT3_Show  = ENEMY_SPOTSHOW
CSpot_EnemySS1_Show  = ENEMY_SPOTSHOW
CSpot_EnemySS2_Show  = ENEMY_SPOTSHOW
CSpot_EnemySS3_Show  = ENEMY_SPOTSHOW
CSpot_EnemyAS1_Show  = ENEMY_SPOTSHOW
CSpot_EnemyAS2_Show  = ENEMY_SPOTSHOW
CSpot_EnemyAS3_Show  = ENEMY_SPOTSHOW
CSpot_EnemyHZ1_Click = ENEMY_SPOTCLICKED
CSpot_EnemyHZ2_Click = ENEMY_SPOTCLICKED
CSpot_EnemyHZ3_Click = ENEMY_SPOTCLICKED
CSpot_EnemyVT1_Click = ENEMY_SPOTCLICKED
CSpot_EnemyVT2_Click = ENEMY_SPOTCLICKED
CSpot_EnemyVT3_Click = ENEMY_SPOTCLICKED
CSpot_EnemySS1_Click = ENEMY_SPOTCLICKED
CSpot_EnemySS2_Click = ENEMY_SPOTCLICKED
CSpot_EnemySS3_Click = ENEMY_SPOTCLICKED
CSpot_EnemyAS1_Click = ENEMY_SPOTCLICKED
CSpot_EnemyAS2_Click = ENEMY_SPOTCLICKED
CSpot_EnemyAS3_Click = ENEMY_SPOTCLICKED

function CSpot_EnemyBoss_Place()
local mytag
local timer
repeat
 mytag = "Enemy "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
local ME = SPOT.ME()
ME.Tag = mytag
ME.R = 255
ME.G = 0
ME.B = 5
ME.DataSet("BOSSFUNCTION",INPUT.Ask("Please enter the name of the boss script function (map script) tied to this boss marker"))
ME.DataSet("LINKEDBARRIER",INPUT.Ask("Please enter the tag of the 'barrier' linked to this boss"))
CSay("Placed "..mytag)
end 

function CSpot_EnemyBoss_Show()
local ME = SPOT.ME()
ME.R = 255
ME.G = 0
ME.B = 5
SPOT.DrawMe(32)
end

function CSpot_EnemyBoss_Click()
local ME = SPOT.ME()
local oz = { [false]=0, [true]=1}
local result = CLICKED.X>ME.X-64 and CLICKED.X<ME.X+64 and CLICKED.Y>ME.Y-64 and CLICKED.Y<ME.Y+64
CLICKED.RET = oz[ result ]
-- CSay(ME.IDNum..">"..ME.Tag.." CLICKED.X = "..CLICKED.X.." CLICKED.Y = "..CLICKED.Y.."; ME.X = "..ME.X.."; ME.Y = "..ME.Y.."; RETURN "..CLICKED.RET.." << "..sval(result)) -- debug
end



function CSpot_Item_Place()
local mytag
local timer
repeat
 mytag = "Item "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
local ME = SPOT.ME()
ME.Tag = mytag
CSay("Placed "..mytag)
end

function CSpot_Item_Show()
local ME = SPOT.ME()
ME.R = 255
ME.G = 180
ME.B = 0
SPOT.DrawMe()
ME.R = 255
ME.G = 255
ME.B = 255
end

CSpot_Item_Click = ENEMY_SPOTCLICKED


function CSpot_TransporterGeneral_Place()
local ME = SPOT.ME()
local TransTag = INPUT.Ask("Please tag the transporter:"); if TransTag=="" then SPOT.Kill() return end
local TransWorld = INPUT.Ask("Please give a name to the world:"); if TransWorld=="" then SPOT.Kill() return end
local TransLocation = INPUT.Ask("Please give up a location name: "); if TransLocation=="" then SPOT.Kill() return end
ME.Tag = "Trans.Spot."..TransTag
local Pad = OBJ.CreateNew("TiledArea")
Pad.x = ME.x-32
Pad.y = ME.y-32
Pad.w = 64
Pad.h = 64
Pad.Tag = "Trans.Pad."..TransTag
Pad.TextureFile = "GFX/Textures/Teleporter Pad/General.png"
Pad.Impassible = 0
ME.DataSet("WORLD",TransWorld)
ME.DataSet("LOCATION",TransLocation)
ME.DataSet("TYPE","General")
OBJ.Remap()
end

function CSpot_TransporterRecover_Place()
local ME = SPOT.ME()
local mytag,timer
repeat
 mytag = "Transporter spot "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
ME.Tag = "Trans.Spot."..mytag
local Pad = OBJ.CreateNew("TiledArea")
Pad.x = ME.x-32
Pad.y = ME.y-32
Pad.w = 64
Pad.h = 64
Pad.Impassible = 0
Pad.Tag = "Trans.Pad."..mytag
Pad.TextureFile = "GFX/Textures/Teleporter Pad/Recover.png"
ME.DataSet("TYPE","Recover")
OBJ.Remap()
end

function CSpot_TransporterReturnOnly_Place()
local ME = SPOT.ME()
local mytag,timer
repeat
 mytag = "Transporter spot "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
ME.Tag = "Trans.Spot."..mytag
local Pad = OBJ.CreateNew("TiledArea")
Pad.x = ME.x-32
Pad.y = ME.y-32
Pad.w = 64
Pad.h = 64
Pad.Tag = "Trans.Pad."..mytag
Pad.TextureFile = "GFX/Textures/Teleporter Pad/ReturnOnly.png"
Pad.Impassible = 0
ME.DataSet("TYPE","ReturnOnly")
OBJ.Remap()
end

function CSpot_TransporterGeneral_Show()
local ME = SPOT.ME()
local METAG = ME.Tag
local BSTag = replace(METAG,".Spot.",".Pad.")
if not TagExists(BSTag) then
   CSay("For transporter "..METAG.." the paired pad "..BSTag.." doesn't exist any more.")
   CSay("This means I have no choice but to destroy the transporter itself as well!")
   SPOT.Kill()
   return
   end
local BS = OBJ.Obj(BSTag)
ME.x         = BS.x + 32
ME.y         = BS.y + 32
ME.Dominance = BS.Dominance   
ME.Labels    = BS.Labels
SPOT.DrawMe() -- Debug Only!
end

CSpot_TransporterRecover_Show    = CSpot_TransporterGeneral_Show
CSpot_TransporterReturnOnly_Show = CSpot_TransporterGeneral_Show


function CSpot_TransporterGeneral_Click()   CLICKED.RET = 0 end
function CSpot_TransporterRecover_Click()    CLICKED.RET = 0 end
function CSpot_TransporterReturnOnly_Click() CLICKED.RET = 0 end


CSpot_CrystalARMS_Click = CSpot_TransporterGeneral_Click
function CSpot_CrystalARMS_Place()
local ME = SPOT.ME()
local ARM = upper(INPUT.Ask("Please enter the name of the ARM (without the ARM_ prefix):"))
local mytag,timer,obtag,chest
if not ME then CSay("WARNING! No object has been created! Why?") end
repeat
 local milisecs = DEC_HEX(Time.MSecs())
 mytag = "ARMSPOT "..milisecs.." "..ARM
 obtag = "ARMCHST "..milisecs.." "..ARM
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not (TagExists(mytag) or TagExists(obtag))
local chest = OBJ.CreateNew("Obstacle")
chest.x = ME.x
chest.y = ME.Y
chest.Tag = obtag
chest.TextureFile = "GFX/Textures/Crystal/ARMS_Chest.png"
chest.Impassible=1
ME.Tag = mytag
ME.y = ME.y+32
ME.DataSet("ARM",ARM)
OBJ.Remap()
end

function CSpot_CrystalARMS_Show()
local ME    = SPOT.ME()
local METAG = ME.Tag
local chtag = replace(ME.Tag,"ARMSPOT","ARMCHST")
if not TagExists(chtag) then
   CSay("For ARM "..METAG.." the paired chest "..chtag.." doesn't exist any more.")
   CSay("This means I have no choice but to destroy the ARMS spot itself as well!")
   SPOT.Kill()
   return
   end
local chest = OBJ.Obj(chtag)
chest.Impassible = 1 -- Fix line due to an old bug.
ME.x             = chest.x
ME.y             = chest.y + 32
ME.Dominance     = chest.Dominance   
ME.Labels        = chest.Labels
SPOT.DrawMe(0,180,255) -- Debug Only!
end

function CSpot_SpecialItem_Place()
local ME   = SPOT.ME()
local item = INPUT.Ask("Enter the item codename (without the ITM_ prefix)"); if (not item) or item=="" then SPOT.Kill() return end
local rate = upper(INPUT.Ask("Inc chance rate (1 to x) (INF=Keeps coming back) (UNIQUE=Only once)")) if (not rate) or rate=="" then SPOT.Kill() return end
local s1ri = Sys.Val(INPUT.Ask("Chance for rate increate (easy more only)")) 
ME.DataSet("ITEM",item)
ME.DataSet("RATE",rate)
ME.DataSet("S1RI",s1ri)
local mytag,timer
repeat
 mytag = "Special Item "..DEC_HEX(Time.MSecs())
 timer = (timer or 0) + 1
 if timer>1000000 then Sys.Error("SPOTPLACE TIMEOUT") end
until not TagExists(mytag)
ME.Tag=mytag
end

CSpot_SpecialItem_Show  = CSpot_Item_Show
CSpot_SpecialItem_Click = CSpot_Item_Click
