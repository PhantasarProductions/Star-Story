--[[
/**********************************************
  
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
  
  
 **********************************************/
 



Version: 15.08.26

]]

-- @UNDEF TRAPDEBUG
function TutSave()
if not Done("&DONE.TUT.YAQIRPA.SAVE") then
   Actors.StopWalking("ActWendicka")
   Actors.StopWalking("ActCrystal")
   Actors.StopWalking("Briggs")
   MapText("EXPLAIN_SAVE")
   Tutorial("Use the diary to save your game")
   end
MapShow("save")   
end

function TutEnemy()
if not Done("&DONE.TUT.YAQIRPA.Enemy") then
   Actors.StopWalking("ActWendicka")
   Actors.StopWalking("ActCrystal")
   Actors.StopWalking("ActBriggs")
   Actors.WalkToSpot("ActWendicka","FoeWendicka")
   Actors.WalkToSpot("ActCrystal","FoeCrystal")
   Actors.WalkToSpot("ActBriggs","FoeBriggs")
   MapText("EXPLAIN_FOES")
   Tutorial("If you touch the alien faces you'll get into combat.\nIt's up to you to go for them or not though they may come after you!")
   end
end


function Trap(exitpoint,mapshowlabels,whine)
local exit = Maps.Obj.Obj(exitpoint)
if not exit then Sys.Error("Cannot move to "..sval(exitpoint)) end
Actors.StopWalking("ActWendicka")
Actors.StopWalking("ActCrystal")
Actors.StopWalking("ActBriggs")
if whine and (not Done("&YAQIRPA.WENDICKA.WHINE."..whine)) then
   MapText(whine)   
   end
Actors.Actor("ActWendicka").X = exit.X
Actors.Actor("ActWendicka").Y = exit.Y
Actors.Actor("ActCrystal" ).X = exit.X
Actors.Actor("ActCrystal" ).Y = exit.Y
Actors.Actor("ActBriggs"  ).X = exit.X
Actors.Actor("ActBriggs"  ).Y = exit.Y
Actors.StopWalking("ActWendicka")
Actors.StopWalking("ActCrystal")
Actors.StopWalking("ActBriggs")
Actors.StopMoving("ActWendicka")
Actors.StopMoving("ActCrystal")
Actors.StopMoving("ActBriggs")
-- Does this "fix" our bug???
Actors.RenewActor("ActWendicka")
Actors.RenewActor("ActCrystal")
Actors.RenewActor("ActBriggs")
MapShow(mapshowlabels)
if whine and (not Done("&YAQIRPA.WENDICKA.WHINE."..whine)) then
   MapText(whine)   
   end
-- @IF TRAPDEBUG
MINI("Moved to exit point: "..sval(exitpoint))
MINI("Mapshow labels:"..sval(mapshowlabels))
MINI("Whine: "..sval(whine))
MINI("Everything correct?")
-- @FI   
end

function KantoorNaGevecht()
Maps.Obj.Kill("ACTASTRILOPUP_A")
Maps.Obj.Kill("ACTASTRILOPUP_B")
MapShow("GreatHall-FirstFloor","Kantoor")
MapText("EAVESDROP_ASTRILOPUP_02")
end

function TopAstrilopups()
if Done("&YAQIRPA.ASTROLOTOP") then return end
MapText("ASTRILOATTACK")
CleanCombat()
Var.D("$COMBAT.BACKGROUND","Yaqirpa.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Astrilopup")
Var.D("$COMBAT.FOE2","Astrilopup")
Var.D("%COMBAT.LVFOE1",rand(1,RPGStat.Stat("UniWendicka","Level")+5+skill))
Var.D("%COMBAT.LVFOE2",rand(1,RPGStat.Stat("UniWendicka","Level")+5+skill))
Var.D("$COMBAT.MUSIC","ENCOUNTER/002.ogg")
Maps.Obj.Kill("TopAstrilo_East")
Maps.Obj.Kill("TopAstrilo_West")
StartCombat()
end

function Kantoor()
MapShow("GreatHall-FirstFloor","Kantoor")
if Done("&YAQIRPA.KANTOOR.ASTRILOPUPS") then return end
Actors.Spawn("ASTRILOPUP_A","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_E.png","ACTASTRILOPUP_A",1)
Actors.Spawn("ASTRILOPUP_B","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_W.png","ACTASTRILOPUP_B",1)
local gtx=1344
local gty=834
repeat
if Maps.CamX<gtx then Maps.CamX=Maps.CamX+1 elseif Maps.CamX>gtx then Maps.CamX=Maps.CamX-1 end
if Maps.CamY<gty then Maps.CamY=Maps.CamY+1 elseif Maps.CamY>gtx then Maps.CamY=Maps.CamY-1 end
MS.Run("FIELD","DrawScreen")
Flip()
until Maps.CamX==gtx and Maps.CamY==gty
MapText("EAVESDROP_ASTRILOPUP_01")
CleanCombat()
Var.D("$COMBAT.BACKGROUND","Yaqirpa.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Astrilopup")
Var.D("$COMBAT.FOE2","Astrilopup")
Var.D("%COMBAT.LVFOE1",rand(1,RPGStat.Stat("UniWendicka","Level")+5+skill))
Var.D("%COMBAT.LVFOE2",rand(1,RPGStat.Stat("UniWendicka","Level")+5+skill))
Var.D("$COMBAT.MUSIC","ENCOUNTER/002.ogg")
Schedule("MAP","KantoorNaGevecht")
StartCombat()
end

function SaveSpot()
-- Mini("Savespot reached!")
GotoSave()
end 

CLICK_ARRIVAL_SAVE1 = SaveSpot
CLICK_ARRIVAL_SAVESPOTTOP = SaveSpot

function CLICK_ARRIVAL_Sleutel()
MapText("KEYTOTOWER")
if not ItemGive("ITM_KEY_YAQIRPA") then Sys.Error("Give Item ITM_KEY_YAQIRPA could not proceed! Why?") end
Maps.Obj.Kill("Sleutel",1) -- Permanent kill. Does it work?
end

function CLICK_ARRIVAL_DEUR()
if ItemHave("ITM_KEY_YAQIRPA") then 
   Maps.Obj.Kill("DEUR",1)
   MINI("The door is open now. Way to go!")
   CSay("Sesam open u!")
else
   MapText("DEUROPSLOT")
   end
end   

function EnterSave() MapShow("save") end
function EnterGreatHall() MapShow("GreatHall") end
function EnterEntrance() MapShow("Entrance") end

function BreakThe4thWall()
if Done("&YAQUIPRA.4EMUUR") then return end
MapText("4EMUURSTART")
-- @IF $MAC
MapText("4EMUURMAC")
-- @FI
-- @IF $WINDOWS
MapText("4EMUURWINDOWS")
-- @FI
-- @IF $LINUX
MapText("4EMUURLINUX")
-- @FI
MapText("4EMUURBRIGGS")
end

function GALE_OnLoad()
SetActive("UniWendicka")
CSay("Welcome to the Yaqirpa")
Music("Dungeon/Opening Theme C")
if not CVV("&DUNG.YAQIRPA") then
  MS.LoadNew("FIELD","Script/Flow/Field.lua") 
  MS.Run("FIELD","SetPlayer","ActWendicka") 
  end
ZA_Enter("SAVEZONE1",TutSave)
ZA_Enter("SAVEZONE1",EnterSave)
ZA_Enter("EnterSave",EnterSave)
ZA_Enter("ToHallS",EnterGreatHall)
ZA_Enter("Entrance_Zone",EnterEntrance)
ZA_Enter("TutEnemy",TutEnemy)
ZA_Enter("Verdieping1",function() MapShow("GreatHall-FirstFloor") end)
ZA_Enter("Kantoor", Kantoor)
ZA_Enter("EnterBoss",function() MapShow("Boss") end)
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
ZA_Enter("Astrilopups",  TopAstrilopups)
-- ZA_Enter("EnterSave",EnterEntrance)
AddClickable("SAVE1")
AddClickable("Sleutel")
AddClickable("DEUR")
AddClickable("SAVESPOTTOP")
alwaysshow = {"ActWendicka","ActCrystal","ActBriggs"}
CSay("Astrilopups on the top defeated: "..sval(CVV("&YAQIRPA.ASTROLOTOP")))
if not CVV("&YAQIRPA.ASTROLOTOP") then
   Actors.Spawn("Astrilo_East","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_E.png","TopAstrilo_East",1)
   Actors.Spawn("Astrilo_West","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_W.png","TopAstrilo_West",1)
   CSay("The Astrilopups have not yet been defeated so, let's put them in shall we?")
   -- RedoMapShow()
   end
end

function MAP_FLOW()
-- Follow the loader. If Wendicka is the leader Crystal will follow Wendicka. If Crystal is the leader, Wendicka will follow Briggs. Briggs can never be the leader and will always follow Crystal.
clplayer = clplayer or "Wendicka"
local follow = {Wendicka = "Briggs", Crystal = "Wendicka", Briggs = "Crystal"}
local x,y,w 
local tx,ty,fx,fy
local leader,follower
for follower,leader in pairs(follow) do
    x,y,w = GetCoords("Act"..leader)
    tx,ty = x,y
    fx,fy = GetCoords("Act"..follower)
    -- @SELECT w
    -- @CASE "North"
       tx = x
       ty = y+64
    -- @CASE "South"
       tx = x
       ty = y-64
    -- @CASE "East"
       tx = x-64
       ty = y
    -- @CASE "West"
       tx = x+64
       ty = y
    -- @DEFAULT
       tx = x
       ty = y+64
    -- @ENDSELECT
    -- CSay(follower.."> Leader:"..x..","..y..","..w.."; Target"..tx..","..ty)
    -- CSay("Leader = "..leader.."; controlled leader player = "..clplayer)
    if follower ~= clplayer and (tx~=fx or ty~=fy) and Actors.Walking("Act"..follower)==0 then Actors.WalkTo("Act"..follower,tx,ty)  end
    Actors.ChoosePic("Act"..leader,upper(leader).."."..upper(w))
    end
end
