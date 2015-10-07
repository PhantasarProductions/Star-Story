--[[
**********************************************
  
  LostPlanet_GrassJungle_3.lua
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
function GotoPrev()
LoadMap("LostPlanet_GrassJungle_2")
SpawnPlayer("Einde")
end

function GotoPub()
if not Done("&DONE.GRASSJUNGLE") then MapEXP() end
LoadMap("LostPlanet_Pub_Outside")
SpawnPlayer("Start")
end

function Boss()
if CVV("&DONE.GRASSJUNGLE") then inc("%LEVEL.BIGGRASSTIGER") end
CleanCombat()
Var.D("$COMBAT.BACKGROUND","GrassJungle.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Boss/BigGrassTiger")
Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
Var.D("%COMBAT.LVFOE1",MapLevel()+CVV("%LEVEL.BIGGRASSTIGER"))
RandomBossTune()
StartCombat()

end

function BossTutorial()
if not Done("&DONE.TUTORIAL.BOSSINFIELD") then
   Actors.StopWalking("PLAYER")
   CharMapText("BOSS")
   MapText("BOSS.TUTORIAL")
   end
end

function Jump(Side)
Actors.StopWalking("PLAYER")
TurnPlayer("South")
Actors.MoveToSpot("PLAYER","StartJump"..Side)
WalkWait()
for y=304,412 do
    Actors.Actor('PLAYER').Y=y
    DrawScreen()
    Flip()
    end
TurnPlayer(({West="East",East="West"})[Side]) 
Actors.MoveToSpot("PLAYER","AfterJump")
end


function GALE_OnLoad()
Music("Dungeon/Weirdomusic_-_34_-_Fiber_visits_the_Q_Continuum.ogg")
SetScrollBoundaries(-5,5,1648,1744)
ZA_Enter("Pub",GotoPub)
ZA_Enter("Previous",GotoPrev)
ZA_Enter("BossTutorial",BossTutorial)
ZA_Enter("JumpWest",function() Jump("West") end)
ZA_Enter("JumpEast",function() Jump("East") end)
end
