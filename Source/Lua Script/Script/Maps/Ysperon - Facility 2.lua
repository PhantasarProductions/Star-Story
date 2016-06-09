--[[
**********************************************
  
  Ysperon - Facility 2.lua
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
 
version: 16.06.09
]]
-- @USE /Script/Use/Maps/Gen/SchuifNext.lua


function StartMusic()
Music("Dungeon/AstrilopupBase")
end

function Silence()
Music("Sys/Silence")
end

function CamScroll(pos)
	repeat
	   if Maps.CamX<pos.x then Maps.CamX = Maps.CamX + 1 elseif Maps.CamX>pos.x then Maps.CamX = Maps.CamX - 1 end 
	   if Maps.CamY<pos.y then Maps.CamY = Maps.CamY + 1 elseif Maps.CamY>pos.y then Maps.CamY = Maps.CamY - 1 end
	   DrawScreen()
	   Flip()
	until Maps.CamX==pos.x and Maps.CamY==pos.y 
end

function ExOpen()
  SetSchuif({'ExLinks','ExRechts'},'Open')
end  


function ExDicht()
  SetSchuif({'ExLinks','ExRechts'},'Dicht')
end  

function Boss()
  if Done("&DONE.YSPERON.EXHURU.KILLED") then return end
  local camposes = { {x=-96,y=1456},{x=-96,y=1712}}
  PartyPop("Ex")
  MapText("EXHURU1")
  CamScroll(camposes[1])
  Actors.Spawn("SpotExHuRU","GFX/Actors/Player","ExHuRU")
  Actors.ChoosePic("ExHuRU","EXHURU.SOUTH")
  ExOpen()
  Actors.MoveToSpot("ExHuRU","MeetExHuRU",1)
  Actors.MoveTo("ExHuRU",352,1920)
  CamScroll(camposes[2])
  ExDicht()
  MapText("EXHURU2")
  Sys.Error('Fight not yet set up')
end


function GALE_OnLoad()
  ({ [true] = StartMusic, [false]=Silence })[Done("&DONE.EUGORVNIA.COMPLETE")]()
  InitSchuif("ExLinks",-39,0)
  InitSchuif("ExRechts",39,0)
  ZA_Enter("ShowOne",MapShow,"One")
  ZA_Enter("ShowTwo",MapShow,"Two")
  ZA_Enter("Boss",Boss)
  ZA_Enter("OpenEx",ExOpen)
  ZA_Leave("OpenEx",ExDicht)
end


