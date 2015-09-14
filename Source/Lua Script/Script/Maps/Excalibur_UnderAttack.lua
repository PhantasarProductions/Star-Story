--[[
**********************************************
  
  Excalibur_UnderAttack.lua
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
 
version: 15.09.15
]]
function Morgue()
MapText("MORGUE")
MapEXP()
end

function GoFurtherOrNot()
if not(CVV("&DONE.EXCALIBUR.UNDERATTACK.TRANSPORTER")) then CharMapText("TRANSPORTERFIRST") return end
MapShow('Galahad,Galahad2')
end

function TransporterKaduuk()
if Done("&DONE.EXCALIBUR.UNDERATTACK.TRANSPORTER") then return end
SetActive("Wendicka")
TurnPlayer("South")
MapText("NOTRANSPORT")
Maps.Obj.Obj("Block4Transporter").Impassible = 0
Maps.PermaWrite('Maps.Obj.Obj("Block4Transporter").Impassible = 0; Maps.Remap()')
Maps.Remap()
end

function GoHome()
LoadMap("Excalibur_Home")
SpawnPlayer("Voordeur","North")
end

function GALE_OnLoad()
Music("Excalibur/Attacked.ogg")
ZA_Enter("Check_Transporter_First",GoFurtherOrNot)
ZA_Enter("BrokenTransporter",TransporterKaduuk)
ZA_Enter("Go Home",GoHome)
end
