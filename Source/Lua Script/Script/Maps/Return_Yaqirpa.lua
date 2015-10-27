--[[
**********************************************
  
  Return_Yaqirpa.lua
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
 
version: 15.10.28
]]
-- @UNDEF TRAPDEBUG


--[[

   I wrote this separate version of the Yaqirpa because the version you come through during the prologue
   uses scripts that will really cause conflicts due to the way the game is set up later on.
   
   
   
   One important note! 
   The Map itself is only stored ONCE inside the JCR6 file even though it seems otherwise.
   This is due to the fact that JCR6 is a very advanced and sophisticated tool supporting multiple references to the same data
   making coding and scripting a lot easier without wasting diskspace 
   
   ]]
   
   
function EnterSave() MapShow("save") end
function EnterGreatHall() MapShow("GreatHall") end
function EnterEntrance() MapShow("Entrance") end
   
function Trap(exitpoint,mapshowlabels,whine)
local exit = Maps.Obj.Obj(exitpoint)
if not exit then Sys.Error("Cannot move to "..sval(exitpoint)) end
Actors.StopWalking("PLAYER")
-- Actors.StopWalking("ActCrystal")
-- Actors.StopWalking("ActBriggs")
if whine and (not Done("&YAQIRPA.WENDICKA.WHINE."..whine)) then
   MapText(whine)   
   end
Actors.Actor("PLAYER").X = exit.X
Actors.Actor("PLAYER").Y = exit.Y
Actors.StopWalking("PLAYER")
-- Does this "fix" our bug???
Actors.RenewActor("PLAYER")
MapShow(mapshowlabels)
-- @IF TRAPDEBUG
MINI("Moved to exit point: "..sval(exitpoint))
MINI("Mapshow labels:"..sval(mapshowlabels))
MINI("Whine: "..sval(whine))
MINI("Everything correct?")
-- @FI   
end


   
function GALE_OnLoad()
CSay("Welcome back to the Yaqirpa")
Music("Dungeon/Opening Theme C")
ZA_Enter("ToHallS",EnterGreatHall)
ZA_Enter("Entrance_Zone",EnterEntrance)
ZA_Enter("Verdieping1",function() MapShow("GreatHall-FirstFloor") end)
ZA_Enter("LeaveBoss",function() MapShow("TowerTop") end)
-- Trappen
ZA_Enter("UPto1",function() Trap("U_Verdieping1","GreatHall-FirstFloor") end)
ZA_Enter("DownTo0",function() Trap("BeganeGrond","GreatHall"); EnterGreatHall() end)
ZA_Enter("DownTo1",function() Trap("D_Verdieping1","GreatHall"); EnterGreatHall() end)
ZA_Enter("UpToTower1", function() Trap("U_Tower1","Tower1") end)
ZA_Enter("UpToTower2", function() Trap("U_Tower2","Tower2") end)
ZA_Enter("UpToTower3", function() Trap("U_Tower3","Tower3","TOWER3") end)
ZA_Enter("UpToTower4", function() Trap("U_Tower4","Tower4","TOWER4") end)
ZA_Enter("UpToTower5", function() Trap("U_Tower5","Tower5","TOWER5") end)
ZA_Enter("UpToTowerTop", function() Trap("Top"   ,"TowerTop","TOWERTOP") end)
ZA_Enter("DownToTower1", function() Trap("D_Tower1","Tower1") end)
ZA_Enter("DownToTower2", function() Trap("D_Tower2","Tower2") end)
ZA_Enter("DownToTower3", function() Trap("D_Tower3","Tower3") end)
ZA_Enter("DownToTower4", function() Trap("D_Tower4","Tower4") end)
ZA_Enter("DownToTower5", function() BreakThe4thWall(); Trap("D_Tower5","Tower5") end)
-- ZA_Enter("Astrilopups",  TopAstrilopups)
ZA_Enter("SAVEZONE1",EnterSave)
ZA_Enter("EnterSave",EnterSave)
-- ZA_Enter("EnterSave",EnterEntrance)
for o in each({'Brain','SAVESPOTTOP','SAVE1'}) do
    Maps.Obj.Kill(o)
    end
end
