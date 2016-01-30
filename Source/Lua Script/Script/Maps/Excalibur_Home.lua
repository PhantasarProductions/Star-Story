--[[
**********************************************
  
  Excalibur_Home.lua
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
 
version: 15.11.01
]]

function CLICK_ARRIVAL_Vlag_Brabant()
CharMapText("Brabant") 
end

function CLICK_ARRIVAL_Computer()
CSay("Savespot activated")
GotoSave()
end

function CLICK_ARRIVAL_Scyndi()
GoToVault()
end

function CLICK_ARRIVAL_Crystal_Asleep()
MapText("FOUNDCRYSTAL_FOUNDHER")
local alpha
for alpha=0,100 do
    Image.SetAlphaPC(100)
    DrawScreen()
    Black()
    Image.SetAlphaPC(alpha)
    Image.Rect(0,0,800,600)
    Flip()
    end
MapShow("Crystal","CrystalFound")    
for alpha=100,0,-1 do
    Image.SetAlphaPC(100)
    DrawScreen()
    Black()
    Image.SetAlphaPC(alpha)
    Image.Rect(0,0,800,600)
    Flip()
    end
MapText("FOUNDCRYSTAL_SECURITY")
Maps.Obj.Kill("Crystal_Asleep",1)
MapText("FOUNDCRYSTAL_AWAKE")    
GrantExperienceOnLevel({"UniWendicka","UniCrystal"},10)
Music("Sys/Silence.ogg")
DrawScreen()
Flip()
Party("Wendicka")
Maps.Obj.Kill("Crystal Awake",1)
Maps.Obj.Kill("CrystalUniform",1)
Image.Cls(); Flip(); Time.Sleep(500)
Image.Font("Fonts/Robotica.ttf",40)
White()
Image.Cls(); Image.DText(({Dutch = "Een jaar later"})[CVV("$LANG")] or "One Year Later",400,300,2,2); Flip(); Time.Sleep(2000)
Image.Cls(); Flip(); Time.Sleep(500)
LoadMap("Excalibur_Kitchen")
MapShow("Niks")
MapText("COOK1")
MapShow("Keuken")
MapText("COOK2")
SetActive("Wendicka")
Actors.Spawn("Wendicka","GFX/Actors/PLAYER","PLAYER")
Actors.ChoosePic("PLAYER","WENDICKA.SOUTH")
local ak
for ak=1,40 do
    Maps.Obj.Obj("Deur_Links" ).X = Maps.Obj.Obj("Deur_Links" ).X - 1
    Maps.Obj.Obj("Deur_Rechts").X = Maps.Obj.Obj("Deur_Rechts").X + 1
    DrawScreen()
    Flip()
    end
Actors.WalkToSpot("PLAYER","WendickaCook")
TurnPlayer("West")
WalkWait()
MapText("COOK3")    
Actors.WalkToSpot("PLAYER","Wendicka")
WalkWait()
-- Maps.Obj.Kill("PLAYER")
Actors.Actor("PLAYER").Visible = 0
for ak=1,40 do
    Maps.Obj.Obj("Deur_Links" ).X = Maps.Obj.Obj("Deur_Links" ).X + 1
    Maps.Obj.Obj("Deur_Rechts").X = Maps.Obj.Obj("Deur_Rechts").X - 1
    DrawScreen()
    Flip()
    end    
LoadMap("Excalibur_AllQuiet")
Actors.Spawn("Keuken_Start","GFX/Actors/PLAYER","PLAYER")
MapShow("Keuken")
TurnPlayer("South")   
Actors.ChoosePic("PLAYER","WENDICKA.SOUTH") 
Done("&DONE.PROLOGUE")
Award("SCENARIO_PROLOGUE")
end

function WendickaRoom()
MapShow("Wendicka")
if CVV("&DONE.PROLOGUE") and (not Done("&DONE.HOME.CRYSTAL.HOME")) then
   MapText("CRYSTAL_HOME") 
   Actors.Spawn("Crystal_Home","GFX/Actors/SinglePic/Heroes/Crystal.png","Crystal",1)
   -- Actors.Actor("Crystal").Visible = 0
   end
HideCrystal()   
end

function Woonkamer() 
MapShow("Woonkamer")
if Maps.Obj.Exists("Crystal")==1 then
    Actors.Actor("Crystal").Visible = 1 -- Will show Crystal in the living room if she's there
    end
end

function HideCrystal()
if Maps.Obj.Exists("Crystal")==1 then
    Actors.Actor("Crystal").Visible = 0 -- Will hide Crystal in the living room if she's there
    end
end

function CrystalHome()
if (not CVV("&DONE.PROLOGUE")) then return end
if (not CVV("&DONE.HOME.CRYSTAL.HOME")) then return end
if Done("&DONE.HOME.EXHURU") then return end
Actors.StopWalking("PLAYER")
Actors.MoveToSpot("PLAYER","Crystal_Wendicka")
TurnPlayer("North")
MapText("CRYSTAL_FIX")
Music("Sys/Silence.ogg")
local ak
local rood
for ak=1,5 do
    rood = not rood
    DrawScreen()
    if rood then
       Red()
       Image.SetAlphaPC(25)
       Image.Rect(0,0,800,600)
       Image.SetAlphaPC(100)
       end
    Flip()
    Time.Sleep(500)
    end
Music("Scenario/Panic Stations")
TurnPlayer("North")
MapText("CRYSTAL_REDALERT")
Maps.Obj.Obj("ExD1").Visible = 1
Maps.Obj.Obj("ExD2").Visible = 2
local EXD = { Maps.Obj.Obj("ExD1"), Maps.Obj.Obj("ExD2") }
local ED
local EXDto = { {x=682,y=120, rs=45},{ x=907, y=101, rs=-45}}
for ED in each(EXD) do
  ED.X = 786
  ED.Y = 411
  ED.Labels="Woonkamer"
  end
Actors.Spawn("Voordeur","GFX/Actors/Player","ExHuRU")
Actors.ChoosePic("ExHuRU","EXHURU.NORTH")  
local ok,i  
local timeout = 10000
repeat
timeout = timeout - 1
if timeout<=0 then Sys.Error("Break door time-out") end
ok = true
for i,ED in ipairs(EXD) do
    if ED.X>EXDto[i].x then ED.X=ED.X-1 end
    if ED.X<EXDto[i].x then ED.X=ED.X+1 end
    if ED.Y>EXDto[i].y then ED.Y=ED.Y-2 end
    ok = ok and ED.X==EXDto[i].x and ED.Y<=EXDto[i].y
    ED.Rotation = ED.Rotation + EXDto[i].rs
    if EXDto[i].rs>0 then EXDto[i].rs=EXDto[i].rs-(rand(1,4)*.1) if EXDto[i].rs<0 then EXDto[i].rs=0 end
    elseif EXDto[i].rs<0 then EXDto[i].rs=EXDto[i].rs+(rand(1,4)*.1) if EXDto[i].rs>0 then EXDto[i].rs=0 end end
    ok = ok and EXDto[i].rs==0
    end
Maps.Obj.Seal("ExD1")
Maps.Obj.Seal("ExD2")    
DrawScreen()
Flip()
until ok  
TurnPlayer("South")
MapText("EXHURU_BREAK")
Actors.MoveToSpot("ExHuRU","Crystal",1)
MapText("EXHURU_CRYSTAL")
Actors.MoveToSpot("ExHuRU","ExHuRU_Spot",1)
Actors.ChoosePic("ExHuRU","EXHURU.EAST")
TurnPlayer("West")
MapText("EXHURU_COMEWITHME")
Music("Excalibur/Attacked.ogg")
Maps.Obj.Kill("Crystal")
Maps.Obj.Kill("ExHuRU")
Party("Wendicka","Crystal","ExHuRU")
TurnPlayer("South") 
Var.D("&ATTACKED.EXCALIBUR","TRUE")   
end

-- Leave the room if you are allowed to do so
function Opzouten()
if not CVV("&ATTACKED.EXCALIBUR") then return MapText("DONTLEAVE") end
CleanCombat()
LoadMap("Excalibur_UnderAttack")
SpawnPlayer("Start","South")
MapShow("Galahad")
if Done("&DONE.EXCALIBUR.UNDERATTACK.WELCOME") then return end
MapText("WELCOME")
local l = MapLevel()
CSay("Level cyborgs must be in range ("..Sys.Val(l/3).." - "..l..")")
Var.D("$COMBAT.BACKGROUND","Excalibur.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE1","Cyborg Medic")
Var.D("$COMBAT.FOE2","Cyborg Captain")
Var.D("$COMBAT.FOE3","Cyborg Gunner")
Var.D("%COMBAT.LVFOE1",rand(l/3,l))
Var.D("%COMBAT.LVFOE2",rand(l/3,l))
Var.D("%COMBAT.LVFOE3",rand(l/3,l))
Var.D("$COMBAT.MUSIC","ENCOUNTER/002.ogg")
local ak
for ak=1,3 do Maps.Obj.Kill("Cyborg"..ak,1) end
Schedule("MAP","Morgue")
StartCombat()
end


function GALE_OnLoad()
if not CVV("&DONE.PROLOGUE")      then Music("Scenario/Panic Stations.ogg") 
--elseif CVV("&DONE.EXHURU")        then Music("Scenario/Panic Stations.ogg")
elseif CVV("&ATTACKED.EXCALIBUR") then Music("Excalibur/Attacked.ogg")
else                                   Music("Scenario/Calm Indoors.ogg") end
RecoverParty()
ZA_Enter("Zone_CrystalHome",CrystalHome)
ZA_Enter("Kamer_Wendicka" ,WendickaRoom)
ZA_Enter("Kamer_Woonkamer",Woonkamer)
ZA_Enter("Kamer_Crystal"  ,function() MapShow("Crystal")   HideCrystal() end)
ZA_Enter("Kamer_Keuken",   function() MapShow("Keuken")    HideCrystal() end)
ZA_Enter("Kamer_Badkamer" ,function() MapShow("Badkamer")  HideCrystal() end)
AddClickable("Vlag_Brabant")
AddClickable("Computer")
AddClickable("Scyndi") -- The name "Scyndi refers to a cabinet in my home of which I did have a picture of Scyndi (from Secrets of Dyrt) and named the cabinet after it. The picture is removed by now, but the name remained.
if Maps.Obj.Exists("Crystal_Asleep")>0 then AddClickable("Crystal_Asleep") end
SetScrollBoundaries(432,-96,576,-96)
ZA_Enter("Exit",Opzouten)
end
