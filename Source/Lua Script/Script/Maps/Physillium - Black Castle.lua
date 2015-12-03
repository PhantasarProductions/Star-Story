--[[
**********************************************
  
  Physillium - Black Castle.lua
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
 
version: 15.12.03
]]

-- @USE /Script/Use/Maps/Gen/Next.lua

BeenHere = "&DONE.BLACKCASTLE.WELCOME"

function Welcome()
if Done(BeenHere) then return end
PartyPop("Start")
Actors.ChoosePic("POP_Xenobi","XENOBI.SOUTH")
MapText("WELCOME")
PartyUnPop()
end

function Boss(BossFile)
CleanCombat()
local lv = MapLevel()
local subjects = ({2,4,8})[skill]
local x,y,si
-- Background data
Var.D("$COMBAT.BACKGROUND","Black Castle.png")
-- Var.D("$COMBAT.VICTORYCHECK","Flirmouse_King")
Var.D("$COMBAT.BEGIN","Default")
-- The boss him/herself
Var.D("$COMBAT.FOE1","Boss/"..BossFile)
Var.D("%COMBAT.LVFOE1",lv)
Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
local base = {300,400}
local subjectxy = {
                     {0,-100},
                     {0, 100},
                     { 100,0},
                     {-100,0},
                     
                     { 50, 50},
                     {-50, 50},
                     { 50,-50},
                     {-50,-50} 
                  }

for i=1,subjects do 
    si = i + 1
    Var.D("$COMBAT.FOE"..si,"Reg/Cid")
    Var.D('%COMBAT.LVFOE'..si,lv/(4-skill))
    -- x = 300+(math.sin(((i-1)/(subjects))*360)*200)
    -- y = 400+(math.cos(((i-1)/(subjects))*360)*100)
    x = base[1]+subjectxy[i][1]
    y = base[2]+subjectxy[i][2]
    CSay("Subject #"..i.." is set to coordinates ("..x..","..y..")")
    Var.D("$COMBAT.ALTCOORDSFOE"..si,x..","..y)
    end
Var.D("$COMBAT.MUSIC","Boss/Exit the premises.ogg")    
StartCombat()
end    

function Moeder()
if Done("&DONE.DARD_MOEDER") then return end
PartyPop("Moeder")
MapText("MOEDER")
Maps.Obj.Kill("Boss Moeder")
Schedule("MAP","PostMoeder")
Boss("DardMoeder")
end

function PostMoeder()
MapText("POST_MOEDER")
PartyUnPop()
end


function GALE_OnLoad()
Music("Dungeon/Dark_City.ogg")
if not CVV(BeenHere) then ZA_Enter("StartRoom",Welcome) end
ZA_Enter("Moeder",Moeder)
end
