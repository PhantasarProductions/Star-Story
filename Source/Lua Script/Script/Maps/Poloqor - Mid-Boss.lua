--[[
**********************************************
  
  Poloqor - Mid-Boss.lua
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
 
version: 16.02.19
]]

MS.LoadNew("FIELD","Script/Flow/Field.lua")
MS.Run("FIELD"," SetScrollBoundaries","-1;48;1;49")


function MIDBOSS()
Maps.CamX = 0
Maps.CamY = 48
PartyPop("MB","West")
MapText("PREBOSS_A")
MapShow("*ALL*")
Actors.Actor("PLAYER").Visible = 0 -- Needed otherwise Wendicka will be visible twice.
MapText("PREBOSS_B")
KickReggie('EAST','POP_Foxy','Reggie')
MapText("PREBOSS_C")
Schedule("MAP","PostMIDBOSS")
CleanCombat()
Var.D("$COMBAT.BACKGROUND","Mid-Boss.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Boss/Mid-Boss")
Var.D("%COMBAT.LVFOE1",RPGStat.Stat("Wendicka","Level"))
Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
Var.D("$COMBAT.MUSIC","SpecialBoss/Exit the premises.ogg")
StartCombat()
--Sys.Error("Boss fight not yet set up")
end

function PostMIDBOSS()
MapText("POSTBOSS")
Done("&DONE.MIDBOSS")
Maps.Obj.Kill("Reggie",1)
PartyUnPop()
MapEXP()
MapShow("Un")
Maps.Obj.Kill("Mid-Boss",1)
TransporterPad("Start",2)
Award("BOSS_MIDBOSS")
--Sys.Error("Boss aftermath not yet set")
end

function CLICK_ARRIVAL_Stickie()
Done("&APP.GAMESHOOT")
MapText("GAMESHOOT")
Maps.Obj.Kill("Stickie",1)
local a = 24 / skill
inc('%AURINAS',a)
inc('%AURINARATE',a*2)
end

StartUp = {
             [true] = function() 
                      Music('Ji/The_Loneliness')
                      MapShow("*ALL*")
                      AddClickable('Stickie')
                      end,
             [false] = function() 
                       MapShow("Un")
                       Music("SYS/SILENCE.OGG")                       
                       ZA_Enter("STARTMIDBOSS",MIDBOSS)
                       end
          }

GALE_OnLoad = StartUp[Var.C("&DONE.MIDBOSS")=="TRUE"]
