--[[
**********************************************
  
  Ysperon - Facility.lua
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
 
version: 16.01.26
]]

-- @USE /Script/Use/Maps/Gen/SchuifNext.lua

function StartMusic()
Music("Dungeon/AstrilopupBase")
end

function Silence()
Music("Sys/Silence")
end

function AfterWelcomeFight()
MapText("ENTER_B")
PartyUnPop()
end

function DoNotLeave()
MapText("DONOTLEAVE")
Actors.WalkTo("PLAYER","Start")
end

EnterArea = {
               ["#002"] = function() MapShow("Main") end,
               ["#006"] = function() MapShow("Main")
                                     if Maps.Obj.Exists("BossDoor")==1 then 
                                        Maps.Obj.Obj("BossDoor").Visible = Maps.Obj.Obj("BossDoor").Impassible
                                        CSay("Boss door adjusted: "..Maps.Obj.Obj("BossDoor").Impassible) 
                                        end 
                                     end
            }
                       

SchuifNextExtraInit = {
                          ["#006"] = function() 
                                     InitSchuif("BossLinks",-30,0,"Dicht")       
                                     InitSchuif("BossRechts",30,0,"Dicht")                                     
                                     ZA_Enter("OpenBoss",function() SetSchuif({"BossLinks","BossRechts"},"Open") end); ZA_Enter("GroteKamer",function() SetSchuif({"BossLinks","BossRechts"},"Dicht") end)
                                     end
                      }
function GALE_OnLoad()
({ [true] = StartMusic, [false]=Silence})[Done("&DONE.EUGORVNIA.COMPLETE")]()
ZA_Enter("DoNotLeave",DoNotLeave)
ZA_Enter("ShowMain",EnterArea["#006"])
ZA_Enter("ShowSide",MapShow,"Side")
ZA_Enter("OpenBonus",MapShow,"Bonus")
end
