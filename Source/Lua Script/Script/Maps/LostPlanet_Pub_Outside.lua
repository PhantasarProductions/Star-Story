--[[
**********************************************
  
  LostPlanet_Pub_Outside.lua
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
 
version: 15.10.07
]]


function IntroBar()
if not Done("&DONE.MAP.INTROBAR") then
   PartyPop("Bar")
   MapText("INTROBAR")
   PartyUnPop()
   end
end

function GALE_OnLoad()
Music("Scenario/Dream Culture.ogg")
SetScrollBoundaries(0,0,0,384)
-- Zone Action
ZA_Enter("IntroBar",IntroBar)
-- Hide the "Rickrolled" banner.
Maps.Obj.Obj("BANNER_RICKROLLED").Visible=0
Maps.Remap()
end
