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
 
version: 16.06.23
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

function SetUpBossFight()
-- Clean up all old shit
CleanCombat()
-- Boss
Var.D("$COMBAT.AltEnemyBuild","BOSS_ExHuRU")
Var.D("$COMBAT.FOE1","ExHuRU")
Var.D("%COMBAT.LVFOE1",RPGChar.Stat("ExHuRU","Level"))
Var.D("$COMBAT.ALTCOORDSFOE1","500,300")
-- Background data
Var.D("$COMBAT.BACKGROUND","Facility.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.MUSIC","SpecialBoss/ExHuRU")
-- Set the post boss stuff on
Schedule("MAP","PostBoss")
-- Let combat commence
StartCombat()   
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
  SyncLevel("ExHuRU")
  SetUpBossFight()
  -- Sys.Error('Fight not yet set up')
end


function PostBoss()
  Actors.ChoosePic("ExHuRU","EXHURU.DEAD")
  Actors.MoveToSpot("POP_Wendicka","Wendicka_Analyse")
  MapText("EXHURU3")
	PartyUnPop()
  -- Sys.Error("This stuff not set up yet")
end  

function GoBackToTheLab()
  LoadMap("Ysperon - Facility","#999")
  Maps.GotoLayer("#999")
  SpawnPlayer("Einde")
end

function McLeen()
  if Done("&DONE.YSPERON.FACILITY.TWO") then return end
  PartyPop("END")
  MapText('DEADEND1')
  --OpenNext()
  local links  = Maps.Obj.Obj("NextLinks")
  local rechts = Maps.Obj.Obj("NextRechts")
  for i=0,39 do
      --SchuifNextDo()
      links .X = links .X - 1
      rechts.X = rechts.X + 1
      DrawScreen()
      Flip()
  end
  MapText("DEADEND2")
  Maps.GotoLayer('MOL')
  Silence()
  SpawnPlayer('Start') Actors.Actor('PLAYER').Visible=0 -- This is only crash prevention.
  Maps.CamX=0
  Maps.CamY=-16
  MapText("MOL1")
  KickReggie('East','Foxy','Reggie')
  MapText("MOL2")
  Award("SCENARIO_CRYSTALFATHER")
  Award("SCENARIO_WENDICKAPREGNANT")
  Var.D("$HAWK","CRYSTALFATHER")
  LoadMap("HAWK","Bridge")
  SpawnPlayer("Scotty")
  ActivateRemotePad("Start","Vulpina - Flower Forest","Vulpina","Flower Forest - Entrance","#001")
  -- Sys.Error("Rest not yet written")
end


function GALE_OnLoad()
  ({ [true] = StartMusic, [false]=Silence })[Done("&DONE.EUGORVNIA.COMPLETE")]()
  Maps.GotoLayer("#018")
  InitSchuif("ExLinks",-39,0)
  InitSchuif("ExRechts",39,0)
  ZA_Enter("ShowOne",MapShow,"One")
  ZA_Enter("ShowTwo",MapShow,"Two")
  ZA_Enter("Boss",Boss)
  ZA_Enter("OpenEx",ExOpen)
  ZA_Leave("OpenEx",ExDicht)
  ZA_Enter("GoBackToTheLab",GoBackToTheLab)
  ZA_Enter("McLeen",McLeen)
end


