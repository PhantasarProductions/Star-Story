--[[
**********************************************
  
  LostPlanet_Bonus_Dark_Caves_of_Shilington.lua
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
 
version: 15.10.03
]]

function Boss()
CleanCombat()
Var.D("$COMBAT.BACKGROUND","Dark Caves.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Syss")
Var.D("$COMBAT.FOE2","Boss/SuperSyss")
Var.D("$COMBAT.FOE3","Syss")
if skill==3 then
   Var.D("$COMBAT.FOE4","Gummi")
   Var.D("$COMBAT.FOE5","Gummi")
   Var.D("$COMABT.FOE6","Gummi")
   end
for i=1,6 do
    Var.D("%COMBAT.LVFOE"..i,rand(skill*10,math.ceil(MapLevel()/(4-skill))))
    end   
Var.D("%COMBAT.LVFOE2",MapLevel())
RandomBossTune()
StartCombat()
end

function FirstJump()
Actors.StopWalking("PLAYER")
Actors.MoveToSpot("PLAYER","FirstJumpStart")
WalkWait()
TurnPlayer("South")
for y=1854,1984,2 do
    Actors.Actor("PLAYER").Y = y
    DrawScreen()
    Flip()
    end
end

function GALE_OnLoad()
Music("Dungeon/Dark_City.ogg")
ZA_Enter("Secret1",function() MapShow("Secret1","Main") end)
ZA_Enter("Secret2",function() MapShow("Secret2","Main") end)
ZA_Enter("Secret3",function() MapShow("Secret3","Main") end)
ZA_Enter("Secret4",function() MapShow("Secret4","Main") end)
ZA_Enter("Secret5",function() MapShow("Secret5","Main") end)
ZA_Leave("Secret1",function() MapShow("Main") end)
ZA_Leave("Secret2",function() MapShow("Main") end)
ZA_Leave("Secret3",function() MapShow("Main") end)
ZA_Leave("Secret5",function() MapShow("Main") end)

ZA_Enter("ByeSecret4",function() MapShow("Main") end)
ZA_Enter("FirstJump",FirstJump)
--MapShow("Main")
end
