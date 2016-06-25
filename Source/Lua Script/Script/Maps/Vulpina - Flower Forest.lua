--[[
**********************************************
  
  Vulpina - Flower Forest.lua
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
 
version: 16.06.25
]]

-- @USE /Script/Use/Maps/Gen/Next.lua

function Boundaries()
   MS.Run("FIELD","SetScrollBoundaries","1;-2000;2;6400")
   if Maps.LayerCodeName=="#001" then MS.Run("FIELD","SetScrollBoundaries","1;-2000;368;6400") end
end

function KotaInside()
	MapText("KOTA.1")
	Map.GotoLayer('Binnen')
	SpawnPlayer('Start')
	Actors.Actor("PLAYER").Visible = 0 -- Crash prevention, that's all! :-P
	Maps.CamX=0
	Maps.CamY=0
	MapText("KOTA.2")
	Actors.MoveTo("Wendicka",277,152)
	for i=0,20 do DrawScreen() Flip() end
	Actors.MoveTo("Kota",112,76)
	MapText("KOTA.3")
	MiniGame()
end

function NPC_Kota()
  if GetActive()~="Yirl" and (not CVV('&DONE.KOTA')) then
     MapText("KOTA.NOTYIRL")
  elseif (not Done('&DONE.KOTA')) then
     KotaInside()
  elseif rand(1,skill*2)==1 and (not Done("&DONE.REVEALED.SEWERS")) then
     MapText("KOTA.SEWERS")
     ActivateRemotePad("Start","Vulpina - Sewers","Vulpina","Sewers - Start","#001")
  else
     MapText("KOTA.BANIKA")
  end            
end

function GALE_OnLoad()
  Boundaries()
  Music("Dungeon/Weirdomusic_-_34_-_Fiber_visits_the_Q_Continuum.ogg")
  ZA_Enter("BCheck",Boundaries)
  ZA_Enter("BCheck2",Boundaries)
end
