--[[
**********************************************
  
  Nizozemska - Marlon's house.lua
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
 
version: 16.05.08
]]


function GALE_OnLoad()
  RecoverParty()
	MS.Run("FIELD","SetScrollBoundaries","-1;1;-1;1")
  Music('Nizozemska/Funky Chunk')
  MapShow("Base")
  Maps.CamX = 0
  Maps.CamY = 0
  if not Done("&DONE.MARLON") then Maps.Obj.Kill("DownMarlon") end
  AddClickable("DownMarlon")
  AddClickable("Sue")
  if not Done("&DONE.MARLONHAWK") then Var.D("$HAWK","MARLON") end
end  


function CLICK_ARRIVAL_DownMarlon()
	TurnPlayer("North")
  MapText("DOWNMARLON")
  MS.LoadNew("NIZOSAVE","Script/Flow/NizozemskaSave.lua")
  LAURA.Flow("NIZOSAVE")  
end

function CLICK_ARRIVAL_Sue()
  TurnPlayer("South")
  MapText("SUE_LEAVE")
  GoWorld("Nizozemska")
end  
