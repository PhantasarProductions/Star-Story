--[[
**********************************************
  
  LostPlanet_GrassJungle_2.lua
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
 
version: 15.09.30
]]

function GotoNext()
if not Done("&DONE.LOSTWORLD.GJ2") then MapEXP() end
LoadMap("LostPlanet_GrassJungle_3")
SpawnPlayer("Start")
end

function GotoPrev()
LoadMap("LostPlanet_GrassJungle")
SpawnPlayer("Einde")
end

function Reveal_Secret()
if not Done("&DONE.REVEAL.SECRET.GRASS2") then MapEXP(); MapEXP() end
MapShow("II","Secret")
end

function DarkCaves()
LoadMap("LostPlanet_Dark_Caves_of_Shilington")
SecretDungeon()
end

function GALE_OnLoad()
Music("Dungeon/Weirdomusic_-_34_-_Fiber_visits_the_Q_Continuum.ogg")
SetScrollBoundaries(nil,-50,nil,1824)
MapShow("II")
ZA_Enter("Next",GotoNext)
ZA_Enter("Previous",GotoPrev)
ZA_Enter("REVEAL_SECRET",Reveal_Secret)
ZA_Enter("ALSO_SECRET",Reveal_Secret)
ZA_Enter("HIDE_SECRET",function() MapShow("II") end)
ZA_Enter("TOSECRETDUNGEON",DarkCaves)
end
