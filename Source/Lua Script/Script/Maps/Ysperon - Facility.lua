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
 
version: 16.08.25
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
CleanCombat()
local lv=(RPGStat.Stat("Wendicka","Level")*skill)*.95
Var.D("$COMBAT.BACKGROUND","Facility.png")
Var.D("$COMBAT.BEGIN","Default")
-- Ast 1
Var.D("$COMBAT.FOE1","AstrilopupGuard")
Var.D("%COMBAT.LVFOE1",lv)
Var.D("$COMBAT.ALTCOORDSFOE1","200,300")
-- Ast 2
Var.D("$COMBAT.FOE2","AstrilopupGuard")
Var.D("%COMBAT.LVFOE2",lv)
Var.D("$COMBAT.ALTCOORDSFOE2","200,450")
Var.D("$COMBAT.MUSIC","Dungeon/AstrilopupBase")
StartCombat()   
Schedule("MAP","Lab")
Maps.Obj.Kill("Astrilo_A",1)
Maps.Obj.Kill("Astrilo_B",1)
end

function Lab()
MapText("FREE_WENDICA_A") -- Wendica is of course a typo, but as the language editor didn't allow tag modifications, I kept it this way. The player won't notice the difference.
-- McLeen beams away
Actors.Actor("GMcLeen").NotInMotionThen0 = 0
Actors.ChoosePic("GMcLeen","TELEPORT")
for f=0,99 do -- The beam out does not work. This is not a bug in the code below. This bug doesn't exist. It's impossible that this doesn't work while it works on all other beam-outs. If somebody can explain this impossibility, I'm all ears.
    Image.Cls()
    Actors.Actor("GMcLeen").Frame = f -- This function goes a bit into the hardcode of Kthura, and best not to use it yourself unless you know the deep background of Kthura.
    Maps.Draw()
    -- @IF *DEVELOPMENT
    CSay("McLeen Beam away - Frame #"..f.. " >>> "..Actors.Actor("GMcLeen").Frame)
    -- @FI
    -- DrawScreen()
    Flip()    
    end    
Maps.Obj.Kill("GMcLeen")    
MapText("FREE_WENDICA_B")
Award("SHESPOKEFRENCH")    
for i=0,100 do
    DrawScreen()
    Black()
    Image.SetAlpha(i/100)
    Image.Rect(0,0,800,600)
    Flip()
    end
Actors.Spawn("WendickaInChains","GFX/Textures/Wendicka/Naked/WendickaNakedStandEast.png","POP_Wendicka",1)
Maps.Obj.Kill("WendickaInChains",1)
AddPartyPop("POP_Wendicka")
AddPartyPop("POP_Reggie")
RemPartyPop("POP_ExHuRU")    
WarpPlayer("ByeBye")
for i=100,0,-1 do -- Dirty method, I know. I was a bit lazy. At least this way everything MUST work
    DrawScreen()
    Black()
    Image.SetAlpha(i/100)
    Image.Rect(0,0,800,600)
    Flip()
    end
MapText("FREE_WENDICA_C")    
KickReggie("South","POP_Foxy","POP_Reggie")
MapText("FREE_WENDICA_D")
Music('Scenario/Panic Stations')
SetSchuif({"PrevLinks","PrevRechts","NextLinks","NextRechts"},"Open")
for i=0,40 do DrawScreen(); Flip() end
local x = Maps.Obj.Obj("AstriloEast").X
for y=260,620,32 do
    Actors.Spawn("AstriloEast","GFX/Actors/SinglePic/Astrilopup/Astrilopup_W.png","AST_E_"..y,1)
    Actors.MoveTo("AST_E_"..y,x,y)
    end
for x=60,330,10 do
    Actors.Spawn("AstriloWest","GFX/Actors/SinglePic/Astrilopup/Astrilopup_E.png","AST_W_"..x,1)
    Actors.WalkTo("AST_W_"..x,x,290)
    end    
MapText("FREE_WENDICA_E") 
PartyUnPop()
Maps.CamY=40
ReLevel("Wendicka","Yirl")   
Party("Crystal","Yirl","Foxy","Xenobi","Wendicka")
SetActive("Crystal")
ActivatePad("Lab","General")
BlockWorld("Ysperon")
TransporterPad("Lab",2)
Var.D("$HAWK.BRIDGE","AfterYsperon")
-- Sys.Error("You entered the lab, but the scenario there is not yet ready")
end

function ToFacility012()
Maps.GotoLayer("#012")
SpawnPlayer('Einde')
end

function ToFacility2()
LoadMap("Ysperon - Facility 2","#013")
Maps.GotoLayer("#013")
SpawnPlayer("Start")
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
ZA_Enter("ToFacility012",ToFacility012)
ZA_Enter("ToFacility2",ToFacility2)
end
