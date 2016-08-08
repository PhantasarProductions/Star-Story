--[[
**********************************************
  
  Nizozemska - Marlon's Garden.lua
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
 
version: 16.05.27
]]

koeien = 6
function setup_koelevels()
  koe = {
         minlevel = (function()
                     if skill==1 then return 1 else return MapLevel() - round( MapLevel()/2 ) end 
                     end)(),
         maxlevel = MapLevel() + round((MapLevel()/5)*skill)            
        }
end

function Welcome()
   if Done('&DONE.NIZOZEMSKA.GARDEN.WELCOME') then return end
   PartyPop('Start')
   MapText('WELCOME')
   KickReggie('North',"POP_Foxy","Reggie")
   MapText("WELCOME2")
   Maps.Obj.Kill('Reggie',1)   
   PartyUnPop()
end

function CLICK_ARRIVAL_DIABLO()
CleanCombat()
  Var.D("$COMBAT.BACKGROUND","Bos - Loofbomen.png")
  Var.D("$COMBAT.BEGIN","Default")
  Var.D("$COMBAT.MUSIC","Garden/River Valley Breakdown.ogg")
  for i=1,skill do
      Var.D("$COMBAT.FOE"..i,"Reg/Cow")
      Var.D("%COMBAT.LVFOE"..i,rand(koe.minlevel,koe.maxlevel))      
  end
  Var.D("$COMBAT.FOE5","BOSS/DIABLO")
  Var.D("%COMBAT.LVFOE5",koe.maxlevel+(10-((3-skill)*10)))
  Schedule("MAP","DIABLO_KAPOT")
  StartCombat()     
  Maps.Obj.Kill('DIABLO',1)    
end

function DIABLO_KAPOT()
  Maps.CamX = 1680
  Maps.CamY = 3728
  Maps.Obj.Obj('Blokkade').Impassible = 0 -- This line (and the next) should allow Sue to reach this spot 
  Maps.Remap()
  Actors.Spawn('SueSpot','GFX/Actors/Sue','Sue')
  Actors.ChoosePic("Sue","SUE.NORTH")
  Actors.MoveToSpot('Sue','Start',1)
  PartyPop('Start',"South")
  MapText('SUE')
  Actors.MoveToSpot('Sue','SueSpot',1)
  Actors.MoveToSpot('POP_Wendicka','Start')
  MapText('SUE2')
  LoadMap('Hawk','Bridge')
  Maps.GotoLayer('Bridge')
  SpawnPlayer('Scotty')
  Award("SCENARIO_DIABLO")
  Var.D('$HAWK','BACK2YSPERON')
  UnBlockWorld('Ysperon')
  Done('&DONE.NIZOZEMSKA.GARDEN')
end

function KOE_KAPOT()
   local over = 0
   for i=1,koeien do
       over = over + Maps.Obj.Exists("KOE"..i)       
   end
   CSay(over.." cows left")
   if over==0 then
      Maps.Obj.Obj('DIABLO').Visible = 1
      AddClickable("DIABLO")
      MINI("Diablo has appeared and he's furious with you",180,0,255,1)
   end
end

function KOE(tag)
  CSay("Activating: "..tag)
  Maps.Obj.Kill(tag,1)
  Schedule("MAP","KOE_KAPOT")
  CleanCombat()
  Var.D("$COMBAT.BACKGROUND","Bos - Loofbomen.png")
  Var.D("$COMBAT.BEGIN","Default")
  Var.D("$COMBAT.MUSIC","Garden/River Valley Breakdown.ogg")
  for i=1,skill do
      Var.D("$COMBAT.FOE"..i,"Reg/Cow")
      Var.D("%COMBAT.LVFOE"..i,rand(koe.minlevel,koe.maxlevel))      
  end
  StartCombat()       
end

function GALE_OnLoad()
  if CVV("&DONE.NIZOZEMSKA.GARDEN") then
     Music('Garden/Ranz des Vaches.ogg')
     ZA_Enter("Exit",GoWorld,"Nizozemska")
  else
     Music('Garden/River Valley Breakdown.ogg')
     Maps.Obj.Obj('DIABLO').Visible = 0
     for i=1,koeien do
        AddClickable("KOE"..i)
     end     
     ZA_Enter("Welcome",Welcome)
     setup_koelevels()
     ZA_Enter('Exit',MapText,'NOEXIT')
     KOE_KAPOT() -- No cows died yet, but this makes it possible to properly work from a debug savegame.
  end 
end
