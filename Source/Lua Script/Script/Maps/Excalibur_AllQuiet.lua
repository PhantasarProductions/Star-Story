--[[
**********************************************
  
  Excalibur_AllQuiet.lua
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
 
version: 15.09.07
]]

function Internal_Transporter(spot,text,labels)
TurnPlayer("South")
MapText(text)
-- Beam Out
Actors.ChoosePic("PLAYER","TELEPORT")
Actors.Actor("PLAYER").NotInMotionThen0 = 0
for f=0,99 do
    Image.Cls()
    Actors.Actor("PLAYER").Frame = f 
    Maps.Draw()
    Flip()    
    end
Maps.OBJ.Kill("PLAYER")
-- Beam in
Actors.Spawn(spot,"GFX/Actors/Uniform","PLAYER")
Maps.CamX = Actors.PX("PLAYER")-400
Maps.CamY = Actors.PY("PLAYER")-300
Actors.ChoosePic("PLAYER","TELEPORT")
Actors.Actor("PLAYER").NotInMotionThen0 = 0
MapShow(labels)
for f=99,0,-1 do
    Image.Cls()
    Actors.Actor("PLAYER").Frame = f 
    Maps.Draw()
    Flip()    
    end
cp = GetActive()
if cp=="UniWendicka" then cp="Wendicka" end    
Actors.ChoosePic("PLAYER",upper(cp)..".SOUTH")     
TurnPlayer("South")  
Actors.Actor("PLAYER").NotInMotionThen0 = 1
end

function NoBusiness()
MapText("NOBUSINESS")
end

function SetDoor(Tag,x)
Doors=Doors or {}
Doors[Tag] = {ox = Maps.Obj.Obj(Tag).X}
Maps.Obj.Obj(Tag).X = Maps.Obj.Obj(Tag).X + x
end

function NoBusiness()
MapText("NOBUSINESS."..upper(GetActive()))
end

function Transporter_Johnson()
CSay("Johnson Transporter")
if not CVV("&DONE.EXCALIBUR.OFFICE.JOHNSON") then MapText("NOTELEPORT_JOHNSON") end
end

function CLICK_ARRIVAL_Deur_Johnson()
if Done("&DONE.EXCALIBUR.OFFICE.JOHNSON") then return end
NoDoorAction = true
MapText("DEUR_JOHNSON")
local Links  = Maps.Obj.Obj("Deur_Johnson_Links")    -- PvdA
local Rechts = Maps.Obj.Obj("Deur_Johnson_Rechts")   -- VVD
for ak=0,40 do
    Links.X  = Links.X  - 1
    Rechts.X = Rechts.X + 1
    Image.Cls()
    DrawScreen()
    Flip()
    end
NoDoorAction = true    
SetAutoScroll("no")
Maps.CamX = 688
Maps.CamY = -16
MapShow("Johnson")
Music("Sys/Silence.ogg")
MapText("JOHNSON")
SetAutoScroll("yes")
TurnPlayer("North")
Maps.CamX = 32
Maps.CamY = 112
MapShow("Staff","Jones")
Music("Scenario/Panic Stations")
MapText("JONES")
MapShow("Staff")
TurnPlayer("South")
Sys.Error("Next part not yet scripted")
end

function GALE_OnLoad()
Music("Excalibur/Blip Stream.ogg")
SetDoor("LeftDoorSickBay",-40)
SetDoor("RightDoorSickBay",40)
SetDoor("Deur_Johnson_Links",-40)
SetDoor("Deur_Johnson_Rechts",40)
if RPGChar.CharExists("Briggs")==1 then RPGChar.DelChar("Briggs") end
ZA_Enter("Sickbay_NoBusiness",NoBusiness)
ZA_Enter("Johnson_NoBusiness",NoBusiness)
ZA_Enter("Johnson2_NoBusiness",NoBusiness)
ZA_Enter("Transporter_Sickbay",function() Internal_Transporter("Johnson_Entrance","TELEPORT_SICK2STAFF","Staff") end)
ZA_Enter("Transporter_Johnson",Transporter_Johnson)
AddClickable("Deur_Johnson")
end

function MAP_FLOW()
local k,v
if not NoDoorAction then
   for k,v in spairs(Doors) do
       if Maps.Obj.Obj(k).X<v.ox then Maps.Obj.Obj(k).X = Maps.Obj.Obj(k).X + 1 end
       if Maps.Obj.Obj(k).X>v.ox then Maps.Obj.Obj(k).X = Maps.Obj.Obj(k).X - 1 end
       end
   end    
end
