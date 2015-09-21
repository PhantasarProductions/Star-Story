--[[
**********************************************
  
  Excalibur_SecretPassage.lua
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
 
version: 15.09.21
]]


function Open_Exit() 
if Done("&DONE.EXCALIBUR.HIDDEN.EXIT") then return end
MapEXP()
Actors.StopWalking("PLAYER")
local i
for i=0,30 do
    Maps.Obj.Obj("Exit_Links" ).X = Maps.Obj.Obj("Exit_Links" ).X - 1
    Maps.Obj.Obj("Exit_Rechts").X = Maps.Obj.Obj("Exit_Rechts").X + 1
    DrawScreen(); Flip()
    end
end

function Pass_Exit()
local heroes = {"Wendicka","Crystal","ExHuRU"}
LoadMap("Excalibur_Hangar")
SpawnPlayer("Start"); Actors.Actor("PLAYER").X=-5000 -- Crash prevention. Nothing more.
Maps.CamX = 0
Maps.CamY = 16
for ch in each(heroes) do
    Actors.Spawn('Start','GFX/Actors/Player',"ch"..ch)
    Actors.ChoosePic("ch"..ch,upper(ch)..".NORTH")    
    end
for ch in each(heroes) do Actors.MoveToSpot("ch"..ch,ch) end -- Why were all three moving to Crystal's spot before?     
MapText("ESCAPE")
for ch in each(heroes) do
    Actors.MoveTo("ch"..ch,"ShipSpot")
    end
Award("SCENARIO_ESCAPEEXCALIBUR")    
local timer=1000
repeat
DrawScreen()
Flip()
timer = timer - 1
until timer<=0 or (Actors.Actor("chWendicka").Moving==0 and Actors.Actor("chCrystal").Moving==0 and Actors.Actor("chExHuRU").Moving==0)
for ch in each(heroes) do Maps.Obj.Kill("ch"..ch) end
-- Open Sesame
local BayDoor = Maps.Obj.Obj("BayDoor")
local Pod = Maps.Obj.Obj("EscapePod")
local DoorClosed = BayDoor.Y
local DoorOpen   = -124 + BayDoor.Y
for y=DoorClosed,DoorOpen,-1 do BayDoor.Y=y; DrawScreen(); Flip() end
-- To Boldly Go Where No One has gone Before
local spd = .01
repeat spd = spd + .01; Pod.Y=Pod.Y-spd; DrawScreen(); Flip() until Pod.Y<-10
-- Close Sesame
for y=DoorOpen,DoorClosed do BayDoor.Y=y; DrawScreen(); Flip() end
Sys.Error("Unfortunately, the rest is not scripted yet! Hang on!")    
end

function GALE_OnLoad()
Music('Dungeon/Spiedkiks_-_05_-_Freak_Boutique.ogg')
ZA_Enter("Open_Exit",Open_Exit)
ZA_Enter("Exit",Pass_Exit)
end


function MAP_FLOW()
local ak,o
for ak=0,10 do
    o = Maps.Obj.Obj("CLOUD"..ak)
    o.X = Maps.CamX
    o.Y = Maps.CamY
    o.InsertX = math.floor((-o.X) * (ak*0.075))
    o.InsertY = math.floor((-o.Y) * (ak*0.075))
    end
end
