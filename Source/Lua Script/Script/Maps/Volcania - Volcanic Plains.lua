--[[
**********************************************
  
  Volcania - Volcanic Plains.lua
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
 
version: 16.02.11
]]

AltComeInFromNorth = { [6]=2673 }
AltComeInFromSouth = {}
AltComeIn = { S = AltComeInFromNorth, N=AltComeInFromSouth }
NSPos = { S = 96, N = 3385}

VBoss = "&DONE.VOLCANIA.BOSS"

function LayerNumber()
return Sys.Val(right(Maps.LayerCodeName,3))
end

function NZ(NS)
local oldplay = Actors.Actor("PLAYER")
local x,y = oldplay.X,oldplay.Y
local go = { N=-1, S = 1}
local lay = LayerNumber()+go[NS]
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer("#00"..lay)
SpawnPlayer('START')
local newplay = Actors.Actor("PLAYER")
newplay.y = AltComeIn[NS or 'S'][lay] or NSPos[NS or 'S']
newplay.x = oldplay.x
end

function North() NZ('N') end
function South() NZ('S') end

function MAP_FLOW()
local play = Actors.Actor("PLAYER")
if play.Y>3420 then South() end
if play.Y<64   then North() end
if (not dactiv) and Maps.LayerCodeName=='#006' then
   MS.Run("TRANS",'ActivatePad',"Start")
   CSay("Activating pad")
   dactiv = true
   end
end

function ToSecret()
if not CVV(VBoss) then -- No cheating in. Only available if the boss is dead.
   MapText("CHEATER")
   MS.LoadNew("GAMEOVER","Script/Flow/GameOver.lua")
   LAURA.Flow("GAMEOVER")
   return
   end
end

function Boss()
if Done(VBoss) then return end -- This boss will only be met ONCE!
PartyPop('BOSS')
repeat
Maps.CamY = Maps.CamY - 1
DrawScreen()
Flip()
until Maps.CamY<=1450
MapText("PREBOSS")
-- Needed pre-combat settings
Party("Wendicka;Crystal;Yirl;Foxy;Xenobi") -- Party order is essential. Wendicka MUST be up-front during this fight!
RPGStat.Points("Wendicka","HP").Minimum = 1 -- Wendicka cannot die in this fight!
Maps.Obj.Kill("BOSS")
Music("SYS/SILENCE")
-- Init combat
CleanCombat()
Var.D("$COMBAT.AltEnemyBuild","SUPERFOE_BuildBossVolcania")
Var.D("$COMBAT.NOSWITCH","Wendicka")
Var.D("$COMBAT.BACKGROUND","Volcano.png")
Var.D("$COMBAT.MUSIC",'SpecialBoss/DeathPredator.ogg') -- Death Predator was the codename until the actual boss name was decided
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","SuperBoss/FireSpider")
Var.D("%COMBAT.LVFOE1",200000)
Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
-- Let combat commence
StartCombat()
Sys.Error('The rest has not yet been scripted. Sorry!')
end

function GALE_OnLoad()
Music("Dungeon/Motherlode")
ZA_Enter("N006",NZ,"N")
ZA_Enter("ToSecret",ToSecret)
ZA_Enter("StartBOSS",Boss)
end
