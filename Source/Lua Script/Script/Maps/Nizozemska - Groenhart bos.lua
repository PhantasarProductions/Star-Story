--[[
**********************************************
  
  Nizozemska - Groenhart bos.lua
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
 
version: 16.05.04
]]

-- Entrance hut to savespot
function NPC_Hut()  
Maps.GotoLayer("Hut")
SpawnPlayer("Enter")
end  

function ExitHut()
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer("Bos")
end

function NPC_Save()
if not (Done("&DONE.FIRSTPC")) then SetActive("Wendicka") MapText("WELCOME_SAVE") end
MS.LoadNew("NIZOSAVE","Script/Flow/NizozemskaSave.lua")
LAURA.Flow("NIZOSAVE")
end

function ToSpacePort()
LoadMap("Nizozemska - Space Port")
SpawnPlayer('Start')
end

function ExitNorth()
if not Done("&DONE.GROENHART") then
   MapText("BYE")
   MapEXP()
   Actors.MoveTo("PLAYER",Actors.Actor("PLAYER").X,-40)
   for i=1,100 do DrawScreen(); Flip() end
   LoadMap("Nizozemska - Marlon's House")
   SpawnPlayer('Start')
   PartyPop("Mar")
   MapText("COMINGHOME")
   Sys.Error("The rest is not scripted yet.")
   end
end

-- And init all this shit (again)
function GALE_OnLoad()
MS.Run("FIELD","SetScrollBoundaries","-1;40;1000;6480")
Music("Nizozemska/HoneyBee.ogg")
ZA_Enter("EXIT_HUT",ExitHut)
ZA_Enter("ExitSouth",ToSpacePort)
ZA_Enter("ExitNorth",ExitNorth)
end
