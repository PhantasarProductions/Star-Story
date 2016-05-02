--[[
**********************************************
  
  HawkBridge.lua
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
 
version: 16.02.08
]]
HawkBridge = {

    AfterYsperon = function()
                   -- Scenario
                   MapText("GODDESS")
                   -- Beam down to Vulpina
                   --Sys.Error("Vulpina not ready yet!")
                   LoadMap("Vulpina - Town")
                   SpawnPlayer("TownStart")
                   MapText("WELCOME")
                   Party("Wendicka")
                   SetActive("Wendicka")
                   -- Block Ysperon
                   BlockWorld("Ysperon")
                   CSay("Ysperon Blocked")                   
                   end,

    ToVolcania = function()
                 player = Actors.Actor("PLAYER")
                 Actors.StopWalking("PLAYER")
                 Actors.MoveToSpot("PLAYER","Welcome",1)
                 Actors.ChoosePic("PLAYER","WENDICKA.NORTH")
                 Music("Sys/Silence.ogg")
                 MapText("PIRATES_A")
                 MapShow("***NIETS***")
                 player.R = 15
                 player.G = 15
                 player.B = 30
                 MapText("PIRATES_B")
                 Music("Scenario/Panic Stations")
                 Actors.Spawn('PirateLeader',"GFX/Actors/SinglePic/Pirates/PirateLeader.png","PLead",1)
                 for i = 1 , 20 do Actors.Spawn('Pirate'..i,"GFX/Actors/SinglePic/Pirates/Pirate.png","P"..i,1) end
                 MapShow("Bridge")
                 player.R = 0xff
                 player.G = 0xff
                 player.B = 0xff
                 MapText("PIRATES_C")
                 LoadMap("Volcania - Volcanic Plains","#006")
                 SpawnPlayer("START")
                 PartyPop("START")
                 MapText("WELCOME")
                 PartyUnPop()
                 Var.D("&TRANSPORTERBLOCK","TRUE") -- The pirates won't let us go.
                 MS.Run("TRANS",'ActivatePad',"Start")
                 --Sys.Error("The next portion is not yet scripted") 
                 end

}


HawkBridge.AfterFacility = HawkBridge.AfterYsperon -- Leftover from an old bug.
