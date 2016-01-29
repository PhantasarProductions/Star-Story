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
 
version: 16.01.29
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
                                     end,
               ["#012"] = function() MapShow("Base") end                      
            }
                       

SchuifNextExtraInit = {
                          ["#006"] = function() 
                                     InitSchuif("BossLinks",-30,0,"Dicht")       
                                     InitSchuif("BossRechts",30,0,"Dicht")                                     
                                     ZA_Enter("OpenBoss",function() SetSchuif({"BossLinks","BossRechts"},"Open") end); ZA_Enter("GroteKamer",function() SetSchuif({"BossLinks","BossRechts"},"Dicht") end)
                                     end,
                                     
                          ["#012"] = function()
                                     InitSchuif("GeheimLinks",-30,0,"Dicht")       
                                     InitSchuif("GeheimRechts",30,0,"Dicht")                                     
                                     ZA_Enter("OpenGeheim",function() SetSchuif({"GeheimLinks","GeheimRechts"},"Open") end); ZA_Leave("OpenGeheim",function() SetSchuif({"GeheimLinks","GeheimRechts"},"Dicht") end)
                                     end
                      }
                      
function Boss()
-- Clean up all old shit
CleanCombat()
-- Determine the boss' level
-- local lv=RPGStat.Stat("Wendicka","Level")*skill
local lv = (100*skill)*ngpcount
CSay("Playthrough:    "..ngpcount)
CSay("Skill:          "..skill)
CSay("Leads to level: "..lv)
-- Boss
Var.D("$COMBAT.FOE1","AstrilopupElite")
Var.D("%COMBAT.LVFOE1",lv)
Var.D("$COMBAT.ALTCOORDSFOE1","500,300")
-- Background data
Var.D("$COMBAT.BACKGROUND","Facility.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.MUSIC","Dungeon/AstrilopupBase")
-- Let combat commence
StartCombat()   
end 

function ToLab()
Maps.GotoLayer("#999")
if Maps.Obj.Exists("PLAYER")==1 then Maps.Obj.Kill("PLAYER") end -- prevent conflicts
SpawnPlayer("Start")
if Done("&DONE.FACILITY.PART.ONE") then return end
MapEXP(4-skill)
Var.Clear("&TRANSPORTERBLOCK") -- This will allow passage back to the Hawk, resolving #329. We did find Wendicka again after all.
Actors.MoveToSpot("PLAYER","WalkIn")
if Maps.Obj.Exists("GMcLeen")==0 then Actors.Spawn('Wendicka_McLeen','GFX/Actors/McLeen','GMcLeen',0) end
Actors.WalkToSpot("GMcLeen","Wendicka_McLeen") -- Should not have any effect normally, but this was needed because of an earlier bug.
repeat
if Maps.CamX<-16 then Maps.CamX=Maps.CamX+1 elseif Maps.CamX>-16 then Maps.CamX=Maps.CamX-1 end
if Maps.CamY< 16 then Maps.CamY=Maps.CamY+1 elseif Maps.CamY> 16 then Maps.CamY=Maps.CamY-1 end
DrawScreen()
Flip()
until Maps.CamX==-16 and Maps.CamY==16
WalkWait()
PartyPop("Wen","West")
Actors.Spawn('WalkIn','GFX/Actors/Reggie/ReggieW.png','POP_Reggie',1)
Actors.MoveToSpot("POP_Reggie","Wen_Reggie")
Maps.Obj.Obj("Astrilo_A").ScaleX = -1000
Maps.Obj.Obj("Astrilo_B").ScaleX = -1000
MapText("Astrilopup_Alarm")
Sys.Error("You entered the lab, but the scenario there is not yet ready")
end
                      
function GALE_OnLoad()
({ [true] = StartMusic, [false]=Silence})[Done("&DONE.EUGORVNIA.COMPLETE")]()
ZA_Enter("DoNotLeave",DoNotLeave)
ZA_Enter("ShowMain",EnterArea["#006"])
ZA_Enter("ShowSide",MapShow,"Side")
ZA_Enter("OpenBonus",MapShow,"Bonus")
ZA_Enter("To999",ToLab)
ZA_Enter("ShowBase",MapShow,"Base")
ZA_Enter("ShowGeheim",MapShow,"Geheim")
end
