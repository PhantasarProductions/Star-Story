--[[
**********************************************
  
  AftermathVolcania.lua
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
 
version: 16.02.13
]]
function AfterVolcania()
MapShow("*NOTHING AT ALL*")
Time.Sleep(2500)
Music("Scenario/Comfortable Mystery.ogg")
Time.Sleep(500)
MapText("VONDELING")
Image.Cls()
Flip()
Time.Sleep(500)
StopMusic()
Time.Sleep(1500)
Music("Scenario/Calm Indoors.ogg")
SpawnPlayer('WendickaInBed',"South")
SetActive("Wendicka")
Actors.Spawn('V_Yirl',"GFX/Actors/Player","VA_Yirl")
Actors.Spawn('V_Reggie','GFX/Actors/Reggie','VA_Reggie')
Actors.ChoosePic('VA_Yirl',"YIRL.EAST")
Actors.ChoosePic("VA_Reggie","REGGIEE")
MapShow('Back')
MapText("Released_A")
Var.D("$HAWK","GODDESSFREE")
Maps.Obj.Kill("VA_Yirl")
Maps.Obj.Kill("VA_Reggie")
local p = Actors.Actor("PLAYER")
local s = Maps.Obj.Obj("GoddessFreeSpot")
p.X = s.X
p.Y = s.Y
MapShow("Bridge")
Var.Clear('&NOHAWKMUSIC') 
HawkMusic()
Actors.WalkToSpot("PLAYER","Welcome")
ActivateRemotePad('Niz_GatePoint','Nizozemska - Space Port','Nizozemska','Spaceport')
-- Must be last
Award("SCENARIO_GODDESSRELEASED")
LAURA.Flow("FIELD") -- This should make sure, we get in the field and NOT back in the boss fight. This should fix #383
-- Sys.Error("We're back on the hawk, but the rest is not yet scripted! Sorry!")
end
