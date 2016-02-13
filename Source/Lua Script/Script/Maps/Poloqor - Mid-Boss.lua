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
 
version: 16.02.13
]]
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
Sys.Error("Boss fight not yet set up")
end

StartUp = {
             [true] = function() 
                      Music('Ji/The_Loneliness')
                      MapShow("*ALL*")
                      end,
             [false] = function() 
                       MapShow("Un")
                       StopMusic()
                       ZA_Enter("STARTMIDBOSS",MIDBOSS)
                       end
          }

GALE_OnLoad = StartUp[Var.C("&DONE.MIDBOSS")=="TRUE"]
