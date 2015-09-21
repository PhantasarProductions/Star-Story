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
for ch in each(heroes) do
    Actors.Spawn('Start','GFX/Actors/Heroes',ch)
    Actors.ChoosePic(ch,Upper(ch)..".NORTH")
    Actors.MoveTo(ch,ch)
    end
MapText("ESCAPE")
for ch in each(heroes) do
    Actors.MoveTo(ch,"ShipSpot")
    end
Award("SCENARIO_ESCAPEEXCALIBUR")    
repeat
DrawScreen()
until Actors.Actor("Wendicka").Move==0 and Actors.Actor("Crystal").Move==0 and Actors.Actor("ExHuRU").Move==0
for ch in each(heroes) do Maps.Obj.Kill(ch) end
    
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
