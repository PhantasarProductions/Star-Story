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
 



Version: 15.07.20

]]
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


function Trap(exitpoint,mapshowlabels)
local exit = Maps.Obj.Obj(exitpoint)
if not exit then Sys.Error("Cannot move to "..sval(exitpoint)) end
Actors.StopWalking("ActWendicka")
Actors.StopWalking("ActCrystal")
Actors.StopWalking("ActBriggs")
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
end

function KantoorNaGevecht()
Maps.Obj.Kill("ASTRILOPUP_A")
Maps.Obj.Kill("ASTRILOPUP_B")
MapText("EAVESDROP_ASTRILOPUP_02")
end

function Kantoor()
MapShow("GreatHall-FirstFloor","Kantoor")
if Done("&YAQIRPA.KANTOOR.ASTRILOPUPS") then return end
Actors.Spawn("ASTRILOPUP_A","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_E.png","ACTASTRILO_A",1)
Actors.Spawn("ASTRILOPUP_B","GFX/ACTORS/SinglePic/Astrilopup/Astrilopup_W.png","ACTASTRILO_B",1)
local gtx=1344
local gty=834
repeat
if Maps.CamX<gtx then Maps.CamX=Maps.CamX+1 elseif Maps.CamX>gtx then Maps.CamX=Maps.CamX-1 end
if Maps.CamY<gty then Maps.CamY=Maps.CamY+1 elseif Maps.CamY>gtx then Maps.CamY=Maps.CamY-1 end
MS.Run("FIELD","DrawScreen")
Flip()
until Maps.CamX==gtx and Maps.CamY==gty
MapText("EAVESDROP_ASTRILOPUP_01")
Var.D("$COMBAT.BACKGROUND","Yaqirpa.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$FOE1","Astrilopup")
Var.D("$FOE2","Astrilopup")
Var.D("%LVFOE1",rand(1,RPGStat.Stat("UniWendicka","Level")+5))
Var.D("%LVFOE2",rand(1,RPGStat.Stat("UniWendicka","Level")+5))
Var.D("$COMBAT.MUSIC","ENCOUNTER/002.ogg")
Schedule("MAP","KantoorNaGevecht")
StartCombat()
end

function SaveSpot()
-- Mini("Savespot reached!")
GotoSave()
end 

CLICK_ARRIVAL_SAVE1 = SaveSpot

function EnterSave() MapShow("save") end
function EnterGreatHall() MapShow("GreatHall") end
function EnterEntrance() MapShow("Entrance") end

function GALE_OnLoad()
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
ZA_Enter("UPto1",function() Trap("U_Verdieping1","GreatHall-FirstFloor") end)
ZA_Enter("DownTo0",function() Trap("BeganeGrond","GreatHall"); EnterGreatHall() end)
-- ZA_Enter("EnterSave",EnterEntrance)
AddClickable("SAVE1")
alwaysshow = {"ActWendicka","ActCrystal","ActBriggs"}
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
